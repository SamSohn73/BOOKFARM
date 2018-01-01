package xyz.bookfarm.vo;

public class CategoryVO
{
	private	int		idx;
	private	int		parent_idx;
//	private	String	categories_image;
	private	String	categories_name;
	
	public CategoryVO() {}

	public CategoryVO(int idx, int parent_idx, String categories_name)
	{
		super();
		this.idx				= idx;
		this.parent_idx			= parent_idx;
		this.categories_name	= categories_name;
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

	public String getCategories_name()
	{
		return categories_name;
	}
	public void setCategories_name(String categories_name)
	{
		this.categories_name = categories_name;
	}
	
}
