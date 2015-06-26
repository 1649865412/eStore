package com.cartmatic.estoresf.catalog.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.CategoryManager;
import com.cartmatic.estore.common.model.catalog.Category;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.search.SearchCriteria;

public class ContentCategoryFrontController extends GenericStoreFrontController<Category> {
	private CategoryManager categoryManager;

	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		logger.debug("entering 'ContentCategoryFrontController defaultAction' method...");
		ModelAndView mv = getModelAndView("catalog/contentList");
		
		SearchCriteria sc = createSearchCriteria(request,null);
//		List<Content> contentList = contentManager.searchContents(sc, csc);
//		mv.addObject("categoryList", categoryList);
		return mv;
	}
	
	public CategoryManager getCategoryManager() {
		return categoryManager;
	}

	public void setCategoryManager(CategoryManager categoryManager) {
		this.categoryManager = categoryManager;
	}

	protected void initController() throws Exception {
		mgr = categoryManager;

	}
	
	

}
