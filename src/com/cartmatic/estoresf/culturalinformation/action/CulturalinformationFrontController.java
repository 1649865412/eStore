package com.cartmatic.estoresf.culturalinformation.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.culturalinformation.CulturalInformation;
import com.cartmatic.estore.common.model.monthlycultural.MonthlyCultural;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
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
	@RequestMapping(value="/culturalinformation/culturatemplate.html*")
	public ModelAndView getCulTemResultList(HttpServletRequest request,HttpServletResponse response){
		ModelAndView mv = getModelAndView("");
    	mv= setCommend( request, mv );
		return mv;
	}
	
	/**
	 * 功能:月刊页面数据
	 * <p>作者 杨荣忠 2015-6-19 下午05:02:34
	 * @param request
	 * @param response
	 * @return
	 */
    @RequestMapping(value="/Cultural_Service/month.html")
    public ModelAndView getMonhtData(HttpServletRequest request, HttpServletResponse response)	 
    {
    	ModelAndView mv = getModelAndView("");
    	mv=setCommend( request, mv );
    	//获取月刊图片
    	CulturalInformation culturalInformation =getCulturalInformation(request.getParameter("culturalInformationId"));  
    	Set<MonthlyCultural> monthlyCulturalList  =culturalInformation.getMonthlyCultural();
        mv.addObject("monthlyCultural", monthlyCulturalList);
		return mv;
    }

    
    
    
    public ModelAndView setCommend(HttpServletRequest request,ModelAndView mv ){
    	CulturalInformation lastCultural = getCulturalInformation(request.getParameter("lastId"));
    	CulturalInformation nextCultural = getCulturalInformation(request.getParameter("nextId")); 
    	//获取culturalInformation
    	CulturalInformation culturalInformation =getCulturalInformation(request.getParameter("culturalInformationId"));  
    	//获取推荐信息List
        List<CulturalInformation> reCommendResults = culturalInformationManager.getAllByIdArray(culturalInformation.getRecommendArrayId());
        mv.addObject("culturalInformation", culturalInformation);   
    	 mv.addObject("reCommendResults", reCommendResults);   
         mv.addObject("lastCultural", lastCultural);
         mv.addObject("nextCultural", nextCultural);
         return mv;
    }
    
    
    /**
     * 
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
