package xyz.bookfarm.control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.action.ActionForward;
import xyz.bookfarm.control.MallActionFactory;

/**
 * Servlet implementation class BoardControlServlet
 */
@WebServlet({"*.do" })
public class MallControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final Logger log = Logger.getLogger(this.getClass());
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		log.debug("MallControlServlet Start.");
		//Korean Language Processing
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html;charset=UTF-8");
		
		//Parsing URI
		log.debug("MallControlServlet Parcing Start.");
		String requestURI	= req.getRequestURI();
		String contextPath	= req.getContextPath();
		String cmd			= requestURI.substring(contextPath.length());
		log.debug("MallControlServlet Parcing End. requestURI= " + requestURI);
		log.debug("MallControlServlet Parcing End. contextPath= " + contextPath);
		log.debug("MallControlServlet Parcing End. cmd= " + cmd);
		
		// Create Action through cmd value
		log.debug("MallControlServlet Action creat Start.");
		MallActionFactory baFactory	= MallActionFactory.getInstance();
		Action action = null;
		action = baFactory.action(cmd);
		log.debug("MallControlServlet Action creat End.");
		
		// Do each Action work
		ActionForward aForward = null;
		try {
			log.debug("MallControlServlet Action Execute Start.");
			aForward = action.execute(req, res);
			log.debug("MallControlServlet Action Execute End.");
		} catch (Exception e) {
			log.fatal("MallControlServlet Action Executed Failed!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			e.printStackTrace();
		}
		
		//Redirect/Forward to somewhere after doing the work.
		log.debug("MallControlServlet Redirect/Forward Start.");
		if (aForward.isRedirect()) {
			res.sendRedirect(aForward.getPath());
		} else {
			RequestDispatcher rd = req.getRequestDispatcher(aForward.getPath());
			rd.forward(req, res);
		}
		log.debug("MallControlServlet Redirect/Forward End.");
		log.debug("MallControlServlet End.");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
