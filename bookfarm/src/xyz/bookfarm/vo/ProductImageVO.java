package xyz.bookfarm.vo;

public class ProductImageVO
{
	private	int		idx;
	private	int		products_idx;
	private	String	image;
	private	String	htmlcontent;
	
	public ProductImageVO() {}

	public ProductImageVO(int idx, int products_idx, String image, String htmlcontent)
	{
		super();
		this.idx			= idx;
		this.products_idx	= products_idx;
		this.image			= image;
		this.htmlcontent	= htmlcontent;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public int getProducts_idx()
	{
		return products_idx;
	}
	public void setProducts_idx(int products_idx)
	{
		this.products_idx = products_idx;
	}

	public String getImage()
	{
		return image;
	}
	public void setImage(String image)
	{
		this.image = image;
	}

	public String getHtmlcontent()
	{
		return htmlcontent;
	}
	public void setHtmlcontent(String htmlcontent)
	{
		this.htmlcontent = htmlcontent;
	}
	
}
