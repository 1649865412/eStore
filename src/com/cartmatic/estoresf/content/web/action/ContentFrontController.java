
package com.cartmatic.estoresf.content.web.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.catalog.service.CategoryManager;
import com.cartmatic.estore.catalog.util.UrlBuilderUtil;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.model.catalog.Category;
import com.cartmatic.estore.common.model.content.Content;
import com.cartmatic.estore.content.model.ContentSearchCriteria;
import com.cartmatic.estore.content.service.ContentManager;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.search.SearchCriteria;
import com.cartmatic.estore.core.view.RedirectView301;
/**
 * 前台内容显示controller
 * @author CartMatic
 */
@Controller
public class ContentFrontController extends GenericStoreFrontController<Content> 
{
	private ContentManager	contentManager;
	private CategoryManager	categoryManager;

	public ContentManager getContentManager() {
		return contentManager;
	}

	public void setContentManager(ContentManager contentManager) {
		this.contentManager = contentManager;
	}

	public CategoryManager getCategoryManager() {
		return categoryManager;
	}

	public void setCategoryManager(CategoryManager categoryManager) {
		this.categoryManager = categoryManager;
	}

	public ModelAndView defaultAction(HttpServletRequest request,
			HttpServletResponse response) {
		logger.info("entering 'ContentFrontController defaultAction' method...");
		String uri = request.getRequestURI();
		if (uri.endsWith("index.html")) {
			return showIndex(request, response);
		} else if (Pattern.matches("^.*_\\d{1,}.html",uri)) {
			return showDetail(request, response);
		} else {
			return showList(request, response);
		}
	} 
	
	@RequestMapping(value={"/customer_service/index.html"})
	public ModelAndView showIndex(HttpServletRequest request,HttpServletResponse response) {
		logger.debug("entering 'ContentFrontController showIndex' method...");
		ModelAndView mv = getModelAndView("content/index");
		return mv;
	}
	
	private ModelAndView notFoundPage(HttpServletRequest request,HttpServletResponse response) {
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		return getModelAndView("404");
	}
	
	@RequestMapping(value={"customer_service/**/contents.html"})
	public ModelAndView showList(HttpServletRequest request,HttpServletResponse response) {
		SearchCriteria sc = createSearchCriteria(request, null);
		ContentSearchCriteria csc = new ContentSearchCriteria();
		// 获取目录
		CatalogHelper catalogHelper = CatalogHelper.getInstance();
		Category category = catalogHelper.getContentCategoryByUri(request.getRequestURI());
		if(category==null){ 
			//获取内容主目录
			category=catalogHelper.getCategoryById4Front(Constants.CATEGORY_TYPE_CONTENT,Constants.ROOT_CATEGORY_CONTENT);
		}
		if(category==null){
			return notFoundPage(request, response);
		}
		Integer pageNo = catalogHelper.getPageNoByUriForContent(request.getRequestURI());
		sc.changePaging(pageNo, 100);
		csc.setCategoryId(category.getCategoryId());
		if (!Constants.FLAG_TRUE.equals(category.getIsLinkCategory())) {
			// -----------------显示列表---------------------------//
			// 获取内容文章
			List<Content> contentList = contentManager.searchContentsForFront(sc, csc);
			// 获取导航目录
			List<Category> navigatorCategorys =category.getNavigatorCategorys();
//			if (navigatorCategorys == null) {
//				String path = "/catalog/categorys_dy.html?doAction=doNotFoundAction";
//				return new ModelAndView("redirect:" + path);
//			}
			Content content = contentManager.getUniqueContentForFront(csc);
			if (content == null) {
				String view = this.getTemplatePath("content/contentList", category.getTemplatePath());
				ModelAndView mv = getModelAndView(view);
				
				// TODO 考虑直接返回set
				// 获取子目录
				Set<Category> subCategoryList=category.getCategorys();
				
				mv.addObject("contentList", contentList);
				mv.addObject("category", category);
				mv.addObject("subCategoryList", subCategoryList);
				mv.addObject("navigatorCategorys", navigatorCategorys);
				return mv;
			}else{
				// -----------------显示单条---------------------------//
				ModelAndView mv = getModelAndView("content/contentDetail");
				return  showContentDetail(content,mv);
			}
		} else {
			// -----------------到页面将重定向---------------------------//
			String view = this.getTemplatePath("content/contentList", category.getTemplatePath());
			ModelAndView mv = getModelAndView(view);
			mv.addObject("category", category);
			return  mv;

		}
	}
	
	/**
	 * 帮助中心
	 * contentId在表content中，如需增加新的导航栏可查找相应id进行添加
	 */
	@RequestMapping(value={"/customer_help.html"})
	public ModelAndView getHelpBody(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv = getModelAndView("help");
		String contentId = request.getParameter("contentId");
		Content content = contentManager.getById(Integer.parseInt(contentId));
		mv.addObject("contentBody", content.getContentBody());
		return mv;
	}
	
	/**
	 * 内容详情页（左边列表页导航+右边说细页）
	 */
	@RequestMapping(value={"/customer_service/**_*.html"})
	public ModelAndView showDetail(HttpServletRequest request,HttpServletResponse response) {
		Integer contentId = UrlBuilderUtil.getInstance().getIdByContentUri(request.getRequestURI());
		ModelAndView mv = getModelAndView("content/contentDetail");
		if(contentId.equals(18) || contentId.equals(19) || contentId.equals(27)){
			Content contentAbout = contentManager.getById(18);
			Content contentJoin = contentManager.getById(19);
			Content contentLink = contentManager.getById(27);	
			Content content = contentManager.getById(contentId); //点击的contentId
			mv.addObject("contentAbout", contentAbout);
			mv.addObject("contentJoin", contentJoin);
			mv.addObject("contentLink", contentLink);
			return showContentDetail(content,mv);
		}else{
			Content content = contentManager.getById(contentId);
			if(content!=null){
				Date now=new Date();
				if(content.getStatus().intValue()==Constants.STATUS_ACTIVE&&content.getPublishTime().before(now)&&(content.getExpiredTime()==null||content.getExpiredTime().after(now))){
					String uri=request.getRequestURI();
					String contentUri=CatalogHelper.getInstance().getContentUrl(content);
					try {
						if(!URLDecoder.decode(uri, "UTF-8").equals(request.getContextPath()+contentUri)){
							//301重定向
							return new ModelAndView(new RedirectView301(contentUri,true));
						}
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}else{
					content=null;
				}
				return showContentDetail(content,mv);
			}else{
				return notFoundPage(request, response);
			}
		}
	}

	private ModelAndView showContentDetail(Content content, ModelAndView mv) {
		logger.debug("entering 'ContentFrontController showDetail' method...");
		if(content!=null){
			// 获取目录
			Category category = null;
			CatalogHelper catalogHelper = CatalogHelper.getInstance();
			category=catalogHelper.getCategoryById4Front(Constants.CATEGORY_TYPE_CONTENT, content.getCategoryId());
			// 获取导航目录
			List<Category> navigatorCategorys = category.getNavigatorCategorys();
			// 获取子目录
			Set<Category> subCategoryList=category.getCategorys();
			mv.addObject("category", category);
			mv.addObject("navigatorCategorys", navigatorCategorys);
			mv.addObject("content", content);
			mv.addObject("subCategoryList", subCategoryList);
		}
		return mv;
	}

	protected void initController() throws Exception {
		mgr = contentManager;
	}
	
	
/*
 *@TODO 现在没有使用上	
 public ModelAndView showCategoryContents(HttpServletRequest request,
			HttpServletResponse response) {
		String categoryCode=request.getParameter("categoryCode");
		String template=request.getParameter("template");
		Integer pageNo=ServletRequestUtils.getIntParameter(request,"pageNo",1);
		Integer pageSize=ServletRequestUtils.getIntParameter(request,"pageSize",10);
		ModelAndView mv=new ModelAndView(template);
		if(StringUtils.isNotBlank(categoryCode)){
			Category category=CatalogHelper.getInstance().getCategoryByCode4Front(Constants.CATEGORY_TYPE_CONTENT, categoryCode);
			if(category!=null){
				SearchCriteria sc = createSearchCriteria(request, null);
				sc.changePaging(pageNo, pageSize);
				ContentSearchCriteria csc = new ContentSearchCriteria();
				csc.setCategoryId(category.getCategoryId());
				// 获取内容文章
				List<Content> contentList = contentManager.searchContentsForFront(sc, csc);
				mv.addObject("contentList", contentList);
				mv.addObject("category", category);
				List<Category> navigatorCategorys=(List<Category>)request.getAttribute("navigatorCategorys");
				if(navigatorCategorys==null){
					navigatorCategorys=category.getParentCategorys();
					navigatorCategorys.add(category);
					mv.addObject("navigatorCategorys", navigatorCategorys);
				}
			}
		}
		return mv;
	}
*/

}
