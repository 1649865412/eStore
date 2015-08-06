package com.cartmatic.estoresf.seckill.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.model.sekillproduct.SekillProduct;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.sekillproduct.service.SekillProductManager;
import com.cartmatic.estoresf.seckill.help.Constant;
import com.cartmatic.estoresf.seckill.help.SeckillTool;

import edu.emory.mathcs.backport.java.util.Collections;


@Controller
public class SeckillFrontControl extends GenericStoreFrontController<SekillProduct>
{
	private ProductManager productManager = null;
	
	private SekillProductManager sekillProductManager = null;
	
	private SolrService solr = null;
	
	
	@Override
	protected void initController() throws Exception
	{
		// TODO Auto-generated method stub
		
	}
	
	
	@RequestMapping(value = "/love520.html", method = RequestMethod.GET)
	public ModelAndView getSekillProductList(HttpServletRequest request, HttpServletResponse response)
	{
		// 显示该目录的产品
		// List<Product> productList= new ArrayList<Product>();
		// SearchResult searchResult=sekillProductManager.getAll();
		List<SekillProduct> sekillProductList = sekillProductManager.getAllOrdered("sekillProductId", true);
		
		List<SekillProduct> sekillProductListDay1 = new ArrayList<SekillProduct>();
		
		List<SekillProduct> sekillProductListDay2 = new ArrayList<SekillProduct>();
		
		List<SekillProduct> sekillProductListDay3 = new ArrayList<SekillProduct>();
		
		
		for (int i = 0; i < sekillProductList.size(); i++)
		{
			SekillProduct sekill = sekillProductList.get(i);
			String sekillTime = sekill.getSekillTime().toString();
			if (sekillTime.equals(Constant.SEKILL_ONE_DAY))
			{
				sekillProductListDay1.add(sekill);
			}
			else if (sekillTime.equals(Constant.SEKILL_TWO_DAY))
			{
				sekillProductListDay2.add(sekill);
			}
			else if (sekillTime.equals(Constant.SEKILL_THRID_DAY))
			{
				sekillProductListDay3.add(sekill);
			}
		}
		
		
/*		SeckillTool.getStayDay( sekillProductListDay1, sekillProductListDay2,
				 sekillProductListDay3);*/
		
		ModelAndView mv = new ModelAndView("/seckillpage/seckill");
		
		
	//	Collections.reverse(sekillProductListDay1);
	//  Collections.reverse(sekillProductListDay2);
	//	Collections.reverse(sekillProductListDay3);
		
		mv.addObject("sekillProductListDay1", sekillProductListDay1);
		mv.addObject("sekillProductListDay2", sekillProductListDay2);
		mv.addObject("sekillProductListDay3", sekillProductListDay3);
		// mv.addObject("facetMap", searchResult.getFacetMap());	
		return mv;
	}
	
	
	
	
	public void setProductManager(ProductManager inMgr)
	{
		this.productManager = inMgr;
	}
	
	public void setSekillProductManager(SekillProductManager sekillProductManager)
	{
		this.sekillProductManager = sekillProductManager;
	}
	
	public void setSolrService(SolrService avalue)
	{
		this.solr = avalue;
	}
}
