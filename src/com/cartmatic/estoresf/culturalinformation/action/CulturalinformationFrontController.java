package com.cartmatic.estoresf.culturalinformation.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;
import net.sf.json.util.JSONUtils;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.culturalinformation.CulturalInformation;
import com.cartmatic.estore.common.model.monthlycultural.MonthlyCultural;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.culturalinformation.service.CulturalInformationManager;
import com.cartmatic.estore.monthlycultural.service.MonthlyCulturalManager;
import com.cartmatic.estore.textsearch.model.SearchResult;


/**
 * 文化资讯模块查询
 *  <code>CulturalinformationFrontController.java</code>
 *  <p>
 *  <p>Copyright  2015 All right reserved.
 *  @author admin 时间 2015-6-8 下午02:19:51	
 *  @version 1.0 
 *  </br>最后修改人 无
 */
@Controller
public class CulturalinformationFrontController extends GenericStoreFrontController<CulturalInformation>
{
	private CulturalInformationManager culturalInformationManager = null;
	private MonthlyCulturalManager monthlyCulturalManager = null;
	public MonthlyCulturalManager getMonthlyCulturalManager() {
		return monthlyCulturalManager;
	}

	public void setMonthlyCulturalManager(
			MonthlyCulturalManager monthlyCulturalManager) {
		this.monthlyCulturalManager = monthlyCulturalManager;
	}

	private SolrService solr = null;
	
	public void setSolrService(SolrService avalue)
	{
		this.solr = avalue;
	}

	@Override
    protected void initController() throws Exception
    {
        mgr = culturalInformationManager;
        defaultPageSize=85;
       // System.out.println("fujun");
    }
	
	public Map<String,CulturalInformation>get_last_nextID( List<CulturalInformation> result,int culId){
    	Map<String,CulturalInformation>map=new HashMap();
		CulturalInformation culturalInformation =null;
		CulturalInformation lastId =new CulturalInformation() ;
		CulturalInformation nextId =new CulturalInformation();
		int size =result.size();
    	for(int i=0;i<size;i++){
    		culturalInformation =result.get(i);
    		int nowId= culturalInformation.getId();
    		if(size==1){
    			//lastId =null;
    			//nextId =null;
    		}
    		else if(nowId==culId&&i==0){
    			//lastId=null;
    			nextId=culturalInformationManager.getById(result.get(i+1).getId());
    		}else if(nowId==culId&&i>0&&i<size-1){
    			lastId=culturalInformationManager.getById(result.get(i-1).getId());
    			nextId=culturalInformationManager.getById(result.get(i+1).getId());
    		}else if(nowId==culId&&i>0&&i==size-1){
    			lastId=culturalInformationManager.getById(result.get(i-1).getId());
    			//nextId=null;
    		}
    	}
    	map.put("lastId", lastId);
    	map.put("nextId", nextId);
    	return map;
    }
	
	/**
	 * 详情页
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/culturalinformation/getCulView.html")
	public ModelAndView getCulView(HttpServletRequest request,HttpServletResponse response){
		CulturalInformation culturalInformation =getCulturalInformation(request.getParameter("culId"));
		 AjaxView ajaxView = new AjaxView(response);
		String type =culturalInformation.getType()+"";
		Map map = new HashMap();
		if(type.equals("4")){
			map=getMonthData(request,response,map);
		}else{
		  map=	getCulData( request, response,map);
		}
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[] {"yyyy-MM-dd HH:mm:ss"}) );
		JSONObject json =JSONObject.fromObject(map, jsonConfig);
		String result = json.toString();
		System.out.print(result);
	     ajaxView.setData(result);
		 return ajaxView;
	}
	
	
	
	/**
	 * 文化资讯列表页获取类型list
	 */
	@RequestMapping(value="/culturalinformation/index.html")
	public ModelAndView getCulTypeResultList(HttpServletRequest request,HttpServletResponse response,String type) {
		ModelAndView mv=new ModelAndView("cultura/culturalinformation");
		List<CulturalInformation> culturalinformationList=culturalInformationManager.getResutlType(type);
		mv.addObject("culturalinformationList", culturalinformationList);
		return mv;
	}
	
	/**
	 * 文化资讯详情页
	 * @param request
	 * @param response
	 * @return
	 */
	public Map getCulData(HttpServletRequest request,HttpServletResponse response,Map map){
		map=setCommend( request,map);
		return map;
	}
	
	/**
	 * 月刊列表页获取类型list
	 */
	@RequestMapping(value="/monthlyinformation/index.html")
	public ModelAndView getMonTypeResultList(HttpServletRequest request,HttpServletResponse response,String type) {
		ModelAndView mv=new ModelAndView("cultura/monthlyinformation");
		List<CulturalInformation> monthlyCulturalList=culturalInformationManager.getResutlType(type);
		mv.addObject("culturalinformationList", monthlyCulturalList);
		return mv;
	}
	
	/**
	 * 功能:月刊详情页数据
	 * <p>作者 杨荣忠 2015-6-19 下午05:02:34
	 * @param request
	 * @param response
	 * @return
	 */
    public Map getMonthData(HttpServletRequest request, HttpServletResponse response,Map map)	 
    {
    	map=setCommend( request,map);
    	//获取月刊图片
    	CulturalInformation culturalInformation =getCulturalInformation(request.getParameter("culId"));
    	Set<MonthlyCultural> monthlyCultural  =culturalInformation.getMonthlyCultural();
    	map.put("monthlyCultural", monthlyCultural);
		return map;
    }

    
    
    /**
     * 获取文化资讯列表数据
     * @param request
     * @param mv
     * @return
     */
    @SuppressWarnings("unchecked")
	public Map setCommend(HttpServletRequest request,Map map ){
    	//获取culturalInformation
    	CulturalInformation culturalInformation =getCulturalInformation(request.getParameter("culId"));
    	 List<CulturalInformation> result= culturalInformationManager.getResutlType(culturalInformation.getType()+"");
    	Map<String,CulturalInformation>last_next_map =get_last_nextID(result,culturalInformation.getId());
    	//获取推荐信息List
        List<CulturalInformation> reCommendResults = culturalInformationManager.getAllByIdArray(culturalInformation.getRecommendArrayId());
        map.put("culturalInformation", culturalInformation);
        map.put("reCommendResults", reCommendResults);
        map.put("lastCultural", last_next_map.get("lastId"));
        map.put("nextCultural",  last_next_map.get("nextId"));
         return map;
    }
    
    
    /**
     * 获取文化资讯详情页数据
     * @param id
     * @return
     */
    public CulturalInformation getCulturalInformation(String id){
    	CulturalInformation Cultural =new CulturalInformation();
    	try{
    	 Cultural =culturalInformationManager.getById(Integer.parseInt( id));
    	}
    	catch(Exception e ){
    		
    	}
    	return Cultural;
    }
	
	/**
	 * 功能:搜索查询controller，根据查询的tag查询，返回查询到的文化列表beanList
	 * <p>作者 杨荣忠 2015-6-19 下午05:02:34
	 * @param request
	 * @param response
	 * @return 
	 * @return
	 */
    @RequestMapping(value="/Cultural_Service/search.html")
    public ModelAndView searchAction(HttpServletRequest request, HttpServletResponse response,String q)	 
    {
    	ModelAndView mv=new ModelAndView("cultura/culturalinformation");
        List<CulturalInformation> results = new ArrayList<CulturalInformation>();
        SearchResult searchResult = solr.queryAllCulturalByTag(request,q,defaultPageSize);
        List<Integer> ids = (List<Integer>)searchResult.getResultList();
        for (Integer id : ids)
        {
        	CulturalInformation obj=culturalInformationManager.getById(id);
            if(obj!=null)
            {
            	System.out.println(obj.getTitle());
                results.add(obj);  
            }
        }
        mv.addObject("culturalinformationList",results);
        return mv;
    }
    

    /**
	 * 功能:搜索查询测试
	 * <p>作者 杨荣忠 2015-6-19 下午05:02:34
	 * @param request
	 * @param response
	 * @return
	 */
    @RequestMapping(value="/Cultural_Service/searchText.html")
    public void searchTextAction(HttpServletRequest request, HttpServletResponse response,String tags)	 
    {
    	System.out.println("solr==========="+solr);
    	System.out.println("culturalInformationManager==========="+culturalInformationManager);
    	
        List<CulturalInformation> results = new ArrayList<CulturalInformation>();
        tags ="long";
        SearchResult searchResult = solr.queryAllCulturalByTag(request,tags,defaultPageSize);
        List<Integer> ids = (List<Integer>)searchResult.getResultList();
        for (Integer id : ids)
        {
        	CulturalInformation obj=culturalInformationManager.getById(id);
            if(obj!=null)
            {
            	System.out.println(obj.getTitle());
                results.add(obj);                
            }
        }
    }
    
	public CulturalInformationManager getCulturalInformationManager()
	{
		return culturalInformationManager;
	}
    
    public void setCulturalInformationManager(CulturalInformationManager inMgr) {
        this.culturalInformationManager = inMgr;
    }
}
