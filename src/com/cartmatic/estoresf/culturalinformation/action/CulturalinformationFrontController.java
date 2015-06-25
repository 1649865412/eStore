package com.cartmatic.estoresf.culturalinformation.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.content.Content;
import com.cartmatic.estore.common.model.culturalinformation.CulturalInformation;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.culturalinformation.service.CulturalInformationManager;
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
public class CulturalinformationFrontController extends GenericStoreFrontController<CulturalInformation>
{
	private SolrService solr = null;
	private CulturalInformationManager culturalInformationManager = null;
	
	
    @Override
    protected void initController() throws Exception
    {
        mgr = culturalInformationManager;
        defaultPageSize=20;
    }
	
	/**
	 * 功能:搜索查询，未完工，待测试
	 * <p>作者 杨荣忠 2015-6-19 下午05:02:34
	 * @param request
	 * @param response
	 * @return
	 */
    @RequestMapping(value="/Cultural_Service/search.html")
    public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response,String tags)	 
    {
        ModelAndView mv = getModelAndView("content/contentList");//此处放搜索结果列表页
        List<CulturalInformation> results = new ArrayList<CulturalInformation>();
        SearchResult searchResult = solr.queryAllCulturalByTag(request,tags,defaultPageSize);
        List<Integer> ids = (List<Integer>)searchResult.getResultList();
        for (Integer id : ids)
        {
        	CulturalInformation obj=culturalInformationManager.getById(id);
            if(obj!=null)
            {
               // String content = obj.getContentBody();
               // content = remove_html.matcher(content).replaceAll("");
                results.add(obj);                
            }
        }
        mv.addObject("CulturalInformationList", results);
        return mv;
    } 
	

    public SolrService getSolr()
	{
		return solr;
	}


	public void setSolr(SolrService solr)
	{
		this.solr = solr;
	}


	public CulturalInformationManager getCulturalInformationManager()
	{
		return culturalInformationManager;
	}
    
    public void setCulturalInformationManager(CulturalInformationManager inMgr) {
        this.culturalInformationManager = inMgr;
    }



}
