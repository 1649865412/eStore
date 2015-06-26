package com.cartmatic.estoresf.content.web.action;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.content.Content;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.content.service.ContentManager;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.textsearch.model.SearchResult;

@Controller
public class ContentSearchController extends GenericStoreFrontController<Content>
{
    private ContentManager  contentManager;
    private SolrService solr = null;
    //去除HTML
    private Pattern remove_html = Pattern.compile("<([^>]*)>");
    
    
    @RequestMapping(value="/Customer_Service/search.html")
    public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response) 
    {
        ModelAndView mv = getModelAndView("content/contentList");
        List<Content> results = new ArrayList<Content>();
        SearchResult searchResult = solr.queryAllContentByCategory(request,defaultPageSize);
        List<Integer> ids = (List<Integer>)searchResult.getResultList();
        for (Integer id : ids)
        {
            Content obj=contentManager.getById(id);
            if(obj!=null)
            {
                String content = obj.getContentBody();
                content = remove_html.matcher(content).replaceAll("");
                results.add(obj);                
            }
        }
        mv.addObject("contentList", results);
        return mv;
    } 
    
    @Override
    protected void initController() throws Exception
    {
        // TODO Auto-generated method stub
        mgr = contentManager;
        defaultPageSize=20;
    }

    public void setContentManager(ContentManager avalue)
    {
        contentManager = avalue;
    }
    public void setSolrService(SolrService avalue)
    {
        this.solr = avalue;
    }
}
