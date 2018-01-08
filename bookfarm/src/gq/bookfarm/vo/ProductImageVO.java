package gq.bookfarm.vo;

public class ProductImageVO
{
	private	int		idx;
	private	int		product_idx;
	private	String	image_path;
	
	public ProductImageVO() {}

	public ProductImageVO(int idx, int product_idx, String image_path)
	{
		super();
		this.idx			= idx;
		this.product_idx	= product_idx;
		this.image_path		= image_path;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public int getProduct_idx()
	{
		return product_idx;
	}
	public void setProduct_idx(int product_idx)
	{
		this.product_idx = product_idx;
	}

	public String getImage_path()
	{
		return image_path;
	}
	public void setImage_path(String image_path)
	{
		this.image_path = image_path;
	}

}
