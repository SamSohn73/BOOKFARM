package gq.bookfarm.vo;

public class PageVO
{
	private int page;
	private int startPage;
	private int endPage;
	private int totalRows;
	private int totalPages;
	
	public int getPage()
	{
		return page;
	}
	public void setPage(int page)
	{
		this.page = page;
	}
	
	public int getStartPage()
	{
		return startPage;
	}
	public void setStartPage(int startPage)
	{
		this.startPage = startPage;
	}
	
	public int getEndPage()
	{
		return endPage;
	}
	public void setEndPage(int endPage)
	{
		this.endPage = endPage;
	}
	
	public int getTotalRows()
	{
		return totalRows;
	}
	public void setTotalRows(int totalRows)
	{
		this.totalRows = totalRows;
	}
	
	public int getTotalPages()
	{
		return totalPages;
	}
	public void setTotalPages(int totalPages)
	{
		this.totalPages = totalPages;
	}
	
}
