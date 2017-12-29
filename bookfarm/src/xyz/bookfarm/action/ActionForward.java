package  xyz.bookfarm.action;

import org.apache.log4j.Logger;

public class ActionForward
{
	private String path;
	private boolean redirect;
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	public ActionForward(String path, boolean redirect)
	{
		super();
		this.path		= path;
		this.redirect	= redirect;
	}
	
	
	public String getPath()
	{
		log.debug("ActionForward getPath() path=" + path);
		return path;
	}
	public void setPath(String path)
	{
		log.debug("ActionForward setPath(String path) path=" + path);
		this.path = path;
	}
	
	public boolean isRedirect()
	{
		log.debug("ActionForward isRedirect() redirect=" + redirect);
		return redirect;
	}
	public void setRedirect(boolean redirect)
	{
		log.debug("ActionForward setRedirect(boolean redirect) redirect=" + redirect);
		this.redirect = redirect;
	}

}
