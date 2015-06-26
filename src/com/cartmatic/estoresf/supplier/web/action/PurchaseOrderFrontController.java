package com.cartmatic.estoresf.supplier.web.action;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.supplier.PurchaseOrder;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.search.SearchCriteria;
import com.cartmatic.estore.supplier.service.PurchaseOrderManager;
import com.cartmatic.estore.webapp.util.RequestContext;

@Controller
public class PurchaseOrderFrontController extends GenericStoreFrontController<PurchaseOrder>
{

    private PurchaseOrderManager purchaseOrderManager = null;

    @Override
	@RequestMapping(value="/myaccount/purchaseOrder.html")
    public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response)
    {
        if (logger.isDebugEnabled())
        {
            logger.debug("entering 'PurchaseOrderFrontController defaultAction' method...");
        }
        // return a paging list
        List results = queryAndSetAttributes(request);
        return new ModelAndView("customer/purchaseOrderList", "purchaseOrderList", results);
    }
    

	@RequestMapping(value="/myaccount/purchaseOrder/{id}.html")
    public ModelAndView viewOrder(@PathVariable Integer id,HttpServletRequest request, HttpServletResponse response){
        if (logger.isDebugEnabled()) {
            logger.debug("entering 'PurchaseOrderFrontController viewOrder' method...");
        }
        PurchaseOrder po = purchaseOrderManager.loadById(id);
        Customer user = (Customer) RequestContext.getCurrentUser();
        if(id==null||!po.getSupplier().getSupplierId().equals(user.getSupplierId()))
        {
            //非法访问
            return new ModelAndView(new RedirectView("/myaccount/invadeError.html"));
        }
        return new ModelAndView("customer/purchaseOrderReview", "purchaseOrder",po);
    }

    private List queryAndSetAttributes(HttpServletRequest request)
    {
        Customer user = (Customer) RequestContext.getCurrentUser();
        String filter = request.getParameter("orderFilter");
        String orderNo = request.getParameter("orderNo");
        SearchCriteria sc = null;
        if (empty(filter))
            filter = "default";

        if (filter.equals("default"))
        {
            sc = this.createSearchCriteria(request, "sf_default");
            // 14天内
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, -14);
            sc.addParamValue(user.getSupplierId());
            sc.addParamValue(cal.getTime());
        }
        else if (filter.equals("months-6"))
        {
            sc = this.createSearchCriteria(request, "sf_default");
            // 6个月前
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MONTH, -6);
            sc.addParamValue(user.getSupplierId());
            sc.addParamValue(cal.getTime());
        }
        else if (filter.equals("all"))
        {
            // 所有的订单
            sc = this.createSearchCriteria(request, "sf_all");
            sc.addParamValue(user.getSupplierId());

        }
        else if (filter.equals("all_cancel"))
        {
            // 所有已取消的订单
            sc = this.createSearchCriteria(request, "sf_cancel");
            sc.addParamValue(user.getSupplierId());
        }
        else if (filter.equals("special"))
        {
            // 所有已取消的订单
            sc = this.createSearchCriteria(request, "sf_specialNo");
            sc.addParamValue(user.getSupplierId());
            sc.addParamValue(orderNo);
        }
        if (sc == null)
            return null;
        return this.searchByCriteria(sc);
    }

    @Override
    protected void initController() throws Exception
    {
        // TODO Auto-generated method stub
        mgr = purchaseOrderManager;
    }

    public void setPurchaseOrderManager(PurchaseOrderManager avalue)
    {
        purchaseOrderManager = avalue;
    }
}
