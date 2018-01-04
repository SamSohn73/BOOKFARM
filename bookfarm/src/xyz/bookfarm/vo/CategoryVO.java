package xyz.bookfarm.vo;

public class CategoryVO
{
	private	int		idx;
	private	int		parent_idx;
	private	String	category_name;
	
	public CategoryVO() {}

	public CategoryVO(int idx, int parent_idx, String category_name)
	{
		super();
		this.idx				= idx;
		this.parent_idx			= parent_idx;
		this.category_name		= category_name;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public int getParent_idx()
	{
		return parent_idx;
	}
	public void setParent_idx(int parent_idx)
	{
		this.parent_idx = parent_idx;
	}

	public String getCategory_name()
	{
		return category_name;
	}
	public void setCategory_name(String category_name)
	{
		this.category_name = category_name;
	}
	
}
