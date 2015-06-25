package com.cartmatic.estoresf.webapp.view;

import java.util.Locale;

import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.AbstractUrlBasedView;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.cartmatic.estore.core.util.ContextUtil;
import com.cartmatic.estore.webapp.util.RequestContext;

public class TemplateViewResolver extends InternalResourceViewResolver
{
		
	@Override
	protected AbstractUrlBasedView buildView(String viewName) throws Exception {
		AbstractUrlBasedView view = super.buildView(viewName);
		if (!ContextUtil.getInstance().isFileExists(view.getUrl())) {
			logger.error(new StringBuilder("Template not found: [").append(view.getUrl()).append("]."));
			return null;
		}
		return view;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.springframework.web.servlet.view.UrlBasedViewResolver#getPrefix()
	 */
	@Override
	protected String getPrefix() {
		return RequestContext.getCurrentTemplatePath() + super.getPrefix();
	}

	/**
	 * Never cache the view
	 */
	@Override
	public boolean isCache() {
		return false;
	}
	/*
	 * session里面的ts改变的话，需要重新createView而不能直接使用缓存的；可以判断是否与context里面的相同
	 * 
	 * @see org.springframework.web.servlet.view.AbstractCachingViewResolver#resolveViewName(java.lang.String,
	 *      java.util.Locale)
	 */
	@Override
	public View resolveViewName(String viewName, Locale locale)
			throws Exception {
		//return RequestContext.getTemplateSetPath().equals(
		//		ContextUtil.getInstance().getTsPath()) ? super.resolveViewName(
		//		viewName, locale) : createView(viewName, locale);
		return super.resolveViewName(viewName, locale);
	}
}
