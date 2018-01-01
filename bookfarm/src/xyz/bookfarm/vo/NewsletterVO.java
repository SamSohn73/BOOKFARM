package xyz.bookfarm.vo;

import java.sql.Date;

public class NewsletterVO
{
	private	int		idx;
	private	String	title;
	private	String	content;
	private	Date	date_added;
	private	Date	date_sent;
	private	int		status;
	private	int		locked;
	
	public NewsletterVO() {}

	public NewsletterVO(int idx, String title, String content, Date date_added, Date date_sent, int status, int locked)
	{
		super();
		this.idx			= idx;
		this.title			= title;
		this.content		= content;
		this.date_added		= date_added;
		this.date_sent		= date_sent;
		this.status			= status;
		this.locked			= locked;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}

	public Date getDate_added()
	{
		return date_added;
	}
	public void setDate_added(Date date_added)
	{
		this.date_added = date_added;
	}

	public Date getDate_sent()
	{
		return date_sent;
	}
	public void setDate_sent(Date date_sent)
	{
		this.date_sent = date_sent;
	}

	public int getStatus()
	{
		return status;
	}
	public void setStatus(int status)
	{
		this.status = status;
	}

	public int getLocked()
	{
		return locked;
	}
	public void setLocked(int locked)
	{
		this.locked = locked;
	}
	
}
