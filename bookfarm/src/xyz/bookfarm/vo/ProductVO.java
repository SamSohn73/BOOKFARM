package xyz.bookfarm.vo;

public class ProductVO
{
	private	int		idx;
	private	int		category_idx;
	private	int		products_quantity;
	private	String	products_model;
	private	String	products_image;
	private	float	products_price;
	private	int		manufacturers_id;
	private	String	products_desc;
	
	public ProductVO() {}

	public ProductVO(int idx, int category_idx, int products_quantity, String products_model, String products_image,
			float products_price, int manufacturers_id, String products_desc)
	{
		super();
		this.idx				= idx;
		this.category_idx		= category_idx;
		this.products_quantity	= products_quantity;
		this.products_model		= products_model;
		this.products_image		= products_image;
		this.products_price		= products_price;
		this.manufacturers_id	= manufacturers_id;
		this.products_desc		= products_desc;
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

	public int getProducts_quantity()
	{
		return products_quantity;
	}
	public void setProducts_quantity(int products_quantity)
	{
		this.products_quantity = products_quantity;
	}

	public String getProducts_model()
	{
		return products_model;
	}
	public void setProducts_model(String products_model)
	{
		this.products_model = products_model;
	}

	public String getProducts_image()
	{
		return products_image;
	}
	public void setProducts_image(String products_image)
	{
		this.products_image = products_image;
	}

	public float getProducts_price()
	{
		return products_price;
	}
	public void setProducts_price(float products_price)
	{
		this.products_price = products_price;
	}

	public int getManufacturers_id()
	{
		return manufacturers_id;
	}
	public void setManufacturers_id(int manufacturers_id)
	{
		this.manufacturers_id = manufacturers_id;
	}

	public String getProducts_desc()
	{
		return products_desc;
	}
	public void setProducts_desc(String products_desc)
	{
		this.products_desc = products_desc;
	}
	
}
