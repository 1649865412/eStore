
package com.cartmatic.estoresf.sales.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Category;
import com.cartmatic.estore.common.model.catalog.CategoryTreeItem;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.sales.RecommendedProduct;
import com.cartmatic.estore.common.model.sales.RecommendedType;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.sales.service.EvalRecommendationManager;
import com.cartmatic.estore.sales.service.RecommendedProductManager;
import com.cartmatic.estore.sales.service.RecommendedTypeManager;
import com.cartmatic.estore.webapp.util.RequestUtil;
/**
 * 推荐产品显示controller(包括手动管理和自动评估)
 * @author CartMatic
 *
 */

@Controller
public class RecommendedProductFrontController extends GenericStoreFrontController<RecommendedProduct> {
	private RecommendedProductManager	recommendedProductManager;
	private RecommendedTypeManager		recommendedTypeManager;
	private EvalRecommendationManager	evalRecommendationManager;

	public void setRecommendedProductManager(
			RecommendedProductManager recommendedProductManager) {
		this.recommendedProductManager = recommendedProductManager;
	}

	public void setRecommendedTypeManager(
			RecommendedTypeManager recommendedTypeManager) {
		this.recommendedTypeManager = recommendedTypeManager;
	}

	public void setEvalRecommendationManager(
			EvalRecommendationManager evalRecommendationManager) {
		this.evalRecommendationManager = evalRecommendationManager;
	}

	protected void initController() throws Exception {
		mgr = recommendedProductManager;
		setCacheSecondsConfigurable(true);
	}
	
	@RequestMapping(value="/sales/recommendedProduct.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		Store store=ConfigUtil.getInstance().getStore();
		String typeName = RequestUtil.getParameterNullSafe(request, "typeName"); // 推荐类型
		if (empty(typeName))
		    return null;
		String firstResultString = RequestUtil.getParameterNullSafe(request,
				"firstResult"); // 起始序号
		String maxResultsString = RequestUtil.getParameterNullSafe(request,
				"maxResults"); // 最大数量
		String sourceFormat = RequestUtil.getParameterNullSafe(request,
				"sourceFormat"); // 标示是用sourceId还是用sourceIds,默认用sourceId
		String sourceIdString = RequestUtil.getParameterNullSafe(request,
				"sourceId"); // sourceId 可以是categoryId 也可以是productId
		String sourceIdsString = RequestUtil.getParameterNullSafe(request,
				"sourceIds"); // sourceIds 可以是categoryIds 也可以是productIds
		// 由typeName决定
		String template = RequestUtil.getParameterNullSafe(request, "template"); // 模板
		// ----------------------初始化参数 开始------------------------------//
		int firstResult;
		int maxResults;
		Integer sourceId;
		List<Integer> sourceIds = new ArrayList<Integer>();
		if (firstResultString.equals("")) {
			firstResult = 0;
		} else {
			firstResult = Integer.parseInt(firstResultString);
		}
		if (maxResultsString.equals("")) {
			maxResults = -1;
		} else {
			maxResults = Integer.parseInt(maxResultsString);
		}
		if (sourceIdString.equals("")) {
			sourceId = ConfigUtil.getInstance().getStore().getCatalog().getCategoryId();
		} else {
			sourceId = new Integer(sourceIdString);
		}
		if (sourceFormat.equals("list")) {
			if (!sourceIdsString.trim().equals("")) {
				String[] temps = sourceIdsString.split(",");
				for (String temp : temps) {
					sourceIds.add(new Integer(temp));
				}
			}
		}
		RecommendedType recommendedType = recommendedTypeManager
				.getRecommendedTypeByName(typeName);

		if (template.equals("")) {
			template = recommendedType.getTemplatePath();
		}
		if (template == null || template.trim().equals("")) {
			template = "sales/include/re_defaultTemplate";
		}
		// ----------------------初始化参数 结束------------------------------//
		List<Product> list;
		if (!sourceFormat.equals("list")) {
		    if (Constants.FLAG_TRUE.equals(recommendedType.getIsApplyToCategory()))
		    { 
		        list = evalRecommendationManager.getProductsByRecommendedTypeNameByCategoryId(store,typeName, sourceId, firstResult, maxResults);
		    }
		    else
		    {
		        list = evalRecommendationManager.getProductsByRecommendedTypeNameByProductId(store,typeName, sourceId, firstResult, maxResults);
		    }
		} else {
			//目前只是做了AlsoBuy部分
			list = evalRecommendationManager.getProductsByRecommendedTypeNameBySourceIdList(store,typeName, sourceIds, firstResult, maxResults);
		}

		request.setAttribute("recommendedType", recommendedType);
		request.setAttribute("productList", list);

		if (Constants.FLAG_TRUE.equals(recommendedType.getIsApplyToCategory())) {
			//当指定的sourceId为1（产品根目录）时，不需要获取根目录；目前前台目录树内不存在id为1的根目录
			if(sourceId!=1){
				Category category = CatalogHelper.getInstance().getCategoryById4Front(Constants.CATEGORY_TYPE_CATALOG, new Integer(sourceId));
				if(category==null){
					category=CatalogHelper.getInstance().getCategoryById4Front(Constants.CATEGORY_TYPE_CATALOG, new Integer(sourceId));
				}
				request.setAttribute("category", category);
				request.setAttribute("categoryUrl", ((CategoryTreeItem)category).getUrl());
			}
		}

		return getModelAndView(template);
	}
	
	
	/**
	 * @TODO目前没有使用 (之前可能考虑 产品页面,购物车的促销使用ajax获取)
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView jsonArray(HttpServletRequest request,HttpServletResponse response) {
		Store store=ConfigUtil.getInstance().getStore();
		Integer storeId=store.getStoreId();
		String typeName = RequestUtil.getParameterNullSafe(request, "typeName"); // 推荐类型
		if (empty(typeName))
		    return null;
		String firstResultString = RequestUtil.getParameterNullSafe(request,
				"firstResult"); // 起始序号
		String maxResultsString = RequestUtil.getParameterNullSafe(request,
				"maxResults"); // 最大数量
		String sourceFormat = RequestUtil.getParameterNullSafe(request,
				"sourceFormat"); // 标示是用sourceId还是用sourceIds,默认用sourceId
		String sourceIdString = RequestUtil.getParameterNullSafe(request,
				"sourceId"); // sourceId 可以是categoryId 也可以是productId
		String sourceIdsString = RequestUtil.getParameterNullSafe(request,
				"sourceIds"); // sourceIds 可以是categoryIds 也可以是productIds
		// 由typeName决定
		String template = RequestUtil.getParameterNullSafe(request, "template"); // 模板
		
		//返回的js数据变量
		String var = RequestUtil.getParameterNullSafe(request, "var"); 
		// ----------------------初始化参数 开始------------------------------//
		int firstResult;
		int maxResults;
		Integer sourceId;
		List<Integer> sourceIds = new ArrayList<Integer>();
		if (firstResultString.equals("")) {
			firstResult = 0;
		} else {
			firstResult = Integer.parseInt(firstResultString);
		}
		if (maxResultsString.equals("")) {
			maxResults = -1;
		} else {
			maxResults = Integer.parseInt(maxResultsString);
		}
		if (sourceIdString.equals("")) {
			sourceId = new Integer("1");
		} else {
			sourceId = new Integer(sourceIdString);
		}
		if (sourceFormat.equals("list")) {
			if (!sourceIdsString.trim().equals("")) {
				String[] temps = sourceIdsString.split(",");
				for (String temp : temps) {
					sourceIds.add(new Integer(temp));
				}
			}
		}
		RecommendedType recommendedType = recommendedTypeManager
				.getRecommendedTypeByName(typeName);

		if (template.equals("")) {
			template = recommendedType.getTemplatePath();
		}
		if (template == null || template.trim().equals("")) {
			template = "sales/include/re_jsonDataTemplate";
		}
		// ----------------------初始化参数 结束------------------------------//
		List<Product> list;
		if (!sourceFormat.equals("list")) {
		    if (Constants.FLAG_TRUE.equals(recommendedType.getIsApplyToCategory()))
            {
                list = evalRecommendationManager.getProductsByRecommendedTypeNameByCategoryId(store,typeName, sourceId, firstResult, maxResults);
            }
            else
            {
                list = evalRecommendationManager.getProductsByRecommendedTypeNameByProductId(store,typeName, sourceId, firstResult, maxResults);
            }			
		} else {
			list = evalRecommendationManager
					.getProductsByRecommendedTypeNameBySourceIdList(store,typeName,sourceIds, firstResult, maxResults);
		}

		request.setAttribute("recommendedType", recommendedType);
		request.setAttribute("productList", list);
		CatalogHelper catalogHelper=CatalogHelper.getInstance();
		JSONArray productList=new JSONArray();
		for (Product product : list) {
			JSONObject jsonProduct=new JSONObject();
			jsonProduct.put("url",catalogHelper.getProductUrl(product,store.getCatalogId(), null));
			jsonProduct.put("productName",product.getProductName());
			jsonProduct.put("image",product.getDefaultProductSku().getImage());
			jsonProduct.put("price",product.getDefaultProductSku().getPrice());
			productList.add(jsonProduct);
		}
		request.setAttribute("var", var);
		request.setAttribute("jsonArray",productList);
		return getModelAndView(template);
	}


}
