
package com.cartmatic.estoresf;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.textsearch.model.SearchResult;

@Controller
@RequestMapping("/rss.html")
public class RSSController{
	private SolrService solrService = null;
	private ProductManager productManager=null;

	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		List<Product> productList= new ArrayList<Product>();
		SearchResult searchResult = solrService.queryLastModifiedProductsBySourceId(Constants.ROOT_CATEGORY_CATALOG.intValue(), 0,20);
		List<Integer> solrRsp = (List<Integer>)searchResult.getResultList();
		for (Integer id : solrRsp)
		{
			Product product=productManager.getById(id); 
			if(product!=null)
				productList.add(product);
		}
		ModelAndView mav = new ModelAndView("rssXML");
		mav.addObject("productList", productList);
		request.setAttribute("productList", productList);
		return mav;
	}
	
	public void setSolrService(SolrService solrService) {
		this.solrService = solrService;
	}
	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}
	
}
