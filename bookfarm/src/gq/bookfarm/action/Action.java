package gq.bookfarm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action
{
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception;
}

/*//Logger HowTo
logger.fatal("log4j:logger.fatal()");
logger.error("log4j:logger.error()");
logger.warn("log4j:logger.warn()");
logger.info("log4j:logger.info()");
logger.debug("log4j:logger.debug()");
*/
