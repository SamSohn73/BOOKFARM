package xyz.bookfarm.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;

public class ReviewsInsertAction implements Action {
	private String path;
	public ReviewsInsertAction(String path) {
		super();
		this.path = path;
	}
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		req.getParameter("");
		
		return new ActionForward(path,false);
	}

}
