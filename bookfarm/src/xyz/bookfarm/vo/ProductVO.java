package xyz.bookfarm.vo;

public class ProductVO
{
	private	int		idx;
	private	int		category_idx;
	private	int		product_quantity;
	private	String	product_name;
	private	String	product_image;
	private	float	product_price;
	private	String	product_desc;
	
	public ProductVO() {}

	public ProductVO(int idx, int category_idx, int product_quantity, String product_name, String product_image, float product_price, String product_desc)
	{
		super();
		this.idx				= idx;
		this.category_idx		= category_idx;
		this.product_quantity	= product_quantity;
		this.product_name		= product_name;
		this.product_image		= product_image;
		this.product_price		= product_price;
		this.product_desc		= product_desc;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}
	
	public int getCategory_idx()
	{
		return category_idx;
	}
	public void setCategory_idx(int category_idx)
	{
		this.category_idx = category_idx;
	}
	public int getProduct_quantity()
	{
		return product_quantity;
	}
	
	public void setProduct_quantity(int product_quantity)
	{
		this.product_quantity = product_quantity;
	}
	public String getProduct_name()
	{
		return product_name;
	}
	public void setProduct_model(String product_name)
	{
		this.product_name = product_name;
	}

	public String getProduct_image()
	{
		return product_image;
	}
	public void setProduct_image(String product_image)
	{
		this.product_image = product_image;
	}

	public float getProduct_price()
	{
		return product_price;
	}
	public void setProduct_price(float product_price)
	{
		this.product_price = product_price;
	}

	public String getProduct_desc()
	{
		return product_desc;
	}
	public void setProduct_desc(String product_desc)
	{
		this.product_desc = product_desc;
	}

}
