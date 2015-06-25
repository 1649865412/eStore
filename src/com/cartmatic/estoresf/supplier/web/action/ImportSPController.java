package com.cartmatic.estoresf.supplier.web.action;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.supplier.Supplier;
import com.cartmatic.estore.common.util.DecompressionUtil;
import com.cartmatic.estore.common.util.FileUtil;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.supplier.service.ImportSupplierProductManager;
import com.cartmatic.estore.webapp.util.RequestContext;


@Controller
@RequestMapping("/myaccount/supplierProduct/import.html")
public class ImportSPController  extends BaseStoreFrontController{
	private ImportSupplierProductManager importSupplierProductManager;
	private CustomerManager customerManager;
	
	private List<String> encodings=null;
	
	private List<String> importTypes=null;

	@Override
	protected void initController() throws Exception {
		super.initController();
		encodings=new ArrayList<String>();
		encodings.add("GB18030");
		encodings.add("GBK");
		encodings.add("GB2312");
		encodings.add("UTF-8");
		
		importTypes=new ArrayList<String>();
		importTypes.add("taobao");
	}

	public void setImportTypes(List<String> importTypes) {
		this.importTypes = importTypes;
	}

	public void setEncodings(List<String> encodings) {
		this.encodings = encodings;
	}
	
	public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

	public void setImportSupplierProductManager(
			ImportSupplierProductManager importSupplierProductManager) {
		this.importSupplierProductManager = importSupplierProductManager;
	}

    @RequestMapping(method=RequestMethod.GET)
	public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response) throws ServletException 
	{
		return importType(request, response);
	}

	@RequestMapping(params="doAction=importType")
	public ModelAndView importType(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		ModelAndView mv=new ModelAndView("customer/importSPType");
		mv.addObject("importTypes", importTypes);
		return mv;
	}

	@RequestMapping(params="doAction=importUpload")
	public ModelAndView importUpload(HttpServletRequest request, HttpServletResponse response) throws ServletException 
	{
		ModelAndView mv=new ModelAndView("customer/importSPUpload");
		String importType=request.getParameter("importType");
		if(StringUtils.isEmpty(importType)){
			return getRedirectView("/myaccount/supplierProduct/import.html?doAction=importType");
		}
		request.setAttribute("importType",importType);
		mv.addObject("encodings", encodings);
		return mv;
	}
	
	/**
	 * 进入导入文件预览页面
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 */
	@RequestMapping(params="doAction=previewCsv")
	public ModelAndView previewCsv(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		String importCsvFilePath = request.getParameter("importCsvFilePath");
		String encoding = request.getParameter("encoding");
		ModelAndView mv = null;
		mv = new ModelAndView("customer/importSPFilePreview"); 
		List<List<String>> result=previewFileData(importCsvFilePath,encoding); 
		
		mv.addObject("previewCsvData", result);
		return mv;
	}

	@RequestMapping(params="doAction=checkFile")
	public ModelAndView checkFile(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String importZipFile = request.getParameter("importZipFile");
		if(StringUtils.isBlank(importZipFile)){
			return getRedirectView("/myaccount/supplierProduct.html");
		}
		String importFilePath=importZipFile.substring(0, importZipFile.lastIndexOf("."));
		//解压文件
		String importZipFilePath=ConfigUtil.getInstance().getMediaStorePath()+"/importSupplierProduct/"+importZipFile;
		String importUnZipFilePath=ConfigUtil.getInstance().getMediaStorePath()+"/importSupplierProduct/"+importFilePath;
		DecompressionUtil.unzip(importZipFilePath,  importUnZipFilePath);
		File importCsvFile=FileUtil.searchOneFile(new File(importUnZipFilePath), ".*.csv");
		String importCsvFilePath=FileUtil.formatPath(importCsvFile.getAbsolutePath());
		String encoding = request.getParameter("encoding");
		Integer rowCount=getFileRowSize(importCsvFile, encoding);
		request.setAttribute("rowCount", rowCount);
		request.setAttribute("importFilePath", importFilePath);
		request.setAttribute("importCsvFilePath", importCsvFilePath);
		ModelAndView mv  = new ModelAndView("customer/importSPFileInfo");
		return mv;
	}

	@RequestMapping(params="doAction=doImport")
	public ModelAndView doImport(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		AjaxView ajaxView=new AjaxView(response);
		String importCsvFilePath = request.getParameter("importCsvFilePath");
		String importFilePath = request.getParameter("importFilePath");
		importFilePath=ConfigUtil.getInstance().getMediaStorePath()+"/importSupplierProduct/"+importFilePath;
		String encoding = request.getParameter("encoding");
		try {
			doImport(importCsvFilePath,importFilePath, encoding);
		} catch (Exception e) {
			ajaxView.setStatus(new Short("2"));
			e.printStackTrace();
		}
		return ajaxView;
	}
	
	private List<List<String>> doImport(String importCsvFilePath,String importFilePath,String encoding) throws Exception {
		Supplier supplier=customerManager.getById(RequestContext.getCurrentUserId()).getSupplier();
		if(supplier==null){
			return null;
		}
		Connection conn = null;
		Statement stm = null;
		ResultSet rs = null;
		Integer rowIndex = 0;
		List<List<String>> result=new ArrayList<List<String>>();
		try {
			conn = getConnectionFromCSV(importCsvFilePath,encoding);
			String fileName=getFileName(importCsvFilePath);
			stm = conn.createStatement();
			rs = stm.executeQuery("SELECT * FROM " + fileName);
			ResultSetMetaData metaData = rs.getMetaData();
			List<String> rowColumnData=new ArrayList<String>();
			Integer rowNum=1;
			rowColumnData.add(rowNum.toString());
			for(int i=1;i<=metaData.getColumnCount();i++){
				String columnName=metaData.getColumnName(i);
				rowColumnData.add(columnName);
			}
			result.add(rowColumnData);
			while (rs.next()) {
				rowNum++;
				//判断是否空白行
				if (isEmptyRow(rs)) {
					continue;
				}
				String productName=rs.getString("宝贝名称");
				String productCode=rs.getString("商家编码");
				String tb_cid=rs.getString("宝贝类目");
				String price=rs.getString("宝贝价格");
				String description=rs.getString("宝贝描述");
				String image=rs.getString("新图片");
				//宝贝属性
				String tb_cateProps=rs.getString("宝贝属性");
				//销售属性组合
				String tb_sell_cateProps=rs.getString("销售属性组合");
				String tb_id=rs.getString("宝贝编号");
				System.out.println(productName+"\t"+tb_cid+"\t"+price+"\t"+image+"\t"+tb_id+"\t"+tb_sell_cateProps);
				importSupplierProductManager.doImportSupplierProduct(supplier,importFilePath, productName,productCode, new Long(tb_cid), price, description,image, tb_cateProps, tb_sell_cateProps, new Long(tb_id));
			}
		} catch (Exception e) {
			throw e;
		} finally {
			closeResource(rs, stm, conn);
		}
		return result;
	}
	
	private Integer getFileRowSize(File csvFile,String encoding) {
		String csvFilePath=FileUtil.formatPath(csvFile.getAbsolutePath());
		Connection conn = null;
		Statement stm = null;
		ResultSet rs = null;
		Integer rowCount = 0;
		try {
			conn = getConnectionFromCSV(csvFilePath,encoding);
			String fileName=getFileName(csvFilePath);
			stm = conn.createStatement();
			rs = stm.executeQuery("SELECT * FROM " + fileName);
			while (rs.next()) {
				//判断是否空白行
				if (isEmptyRow(rs)) {
					continue;
				}
				rowCount++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResource(rs, stm, conn);
		}
		return rowCount;
	}
	
	
	private List<List<String>> previewFileData(String fileName,String encoding) {
		Connection conn = null;
		Statement stm = null;
		ResultSet rs = null;
		Integer rowIndex = 0;
		List<List<String>> result=new ArrayList<List<String>>();
		try {
			conn = getConnectionFromCSV(fileName,encoding);
			fileName=getFileName(fileName);
			stm = conn.createStatement();
			rs = stm.executeQuery("SELECT * FROM " + fileName);
			ResultSetMetaData metaData = rs.getMetaData();
			List<String> rowColumnData=new ArrayList<String>();
			Integer rowNum=1;
			rowColumnData.add(rowNum.toString());
			List<Integer> previewIndexs=new ArrayList<Integer>();
			for(int i=1;i<=metaData.getColumnCount();i++){
				String columnName=metaData.getColumnName(i);
				if(columnName.trim().equals("宝贝名称")
						||columnName.trim().equals("商家编码")
						||columnName.trim().equals("宝贝价格")){
					previewIndexs.add(i);
					rowColumnData.add(columnName);
				}
			}
			result.add(rowColumnData);
			while (rs.next()) {
				rowNum++;
				//判断是否空白行
				if (isEmptyRow(rs)) {
					continue;
				}
				List<String> rowData=new ArrayList<String>();
				rowData.add(rowNum.toString());
				for(int i=1;i<=metaData.getColumnCount();i++){
					if(previewIndexs.contains(i)){
						rowData.add(rs.getString(i));
					}
				}
				rowIndex++;
				result.add(rowData);
				if(rowIndex>10){
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeResource(rs, stm, conn);
		}
		return result;
	}
	
	private boolean isEmptyRow(ResultSet rs) throws Exception{
		boolean isEmptyRow=true;
		for (int i = 1; i < 8; i++) {
			if(StringUtils.isNotBlank(rs.getString(i))){
				isEmptyRow=false;
				break;
			}
		}
		return isEmptyRow;
	}
	
	private String getFileName(String filePath){
		String fileName=filePath.substring(filePath.lastIndexOf("/")+1,filePath.indexOf("."));
		return fileName;
	}
	
	private Connection getConnectionFromCSV(String filePath,String encoding) throws Exception {
		filePath=filePath.substring(0,filePath.lastIndexOf("/"));
		Class.forName("org.relique.jdbc.csv.CsvDriver");
		Properties props = new java.util.Properties();
		props.put("charset", encoding);
		Connection conn = DriverManager.getConnection("jdbc:relique:csv:" + filePath, props);
		return conn;
	}
	
	private void closeResource(ResultSet rs, Statement stmt, Connection conn) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
}
