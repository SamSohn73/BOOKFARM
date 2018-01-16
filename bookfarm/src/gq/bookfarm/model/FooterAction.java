package gq.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;

public class FooterAction implements Action {	

	private final	Logger		log		=	Logger.getLogger(this.getClass());
	private 		String		path;
	
	public FooterAction(String path) {
		super();
		log.debug("AdminProductViewAction create Start.");
		this.path  = path;
		log.debug("AdminProductViewAction create End. path=" + path);
	}

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		
		
		
		return new ActionForward(path, true);
	}

}
