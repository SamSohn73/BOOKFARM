package xyz.bookfarm.vo;

public class OrdersProductVO
{
	private	int		idx;
	private	int		orders_idx;
	private	int		products_idx;
	private	int		products_quantity;
	private	float	final_price;
	
	public OrdersProductVO() {}

	public OrdersProductVO(int idx, int orders_idx, int products_idx, int products_quantity, float final_price)
	{
		super();
		this.idx				= idx;
		this.orders_idx			= orders_idx;
		this.products_idx		= products_idx;
		this.products_quantity	= products_quantity;
		this.final_price		= final_price;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public int getOrders_idx()
	{
		return orders_idx;
	}
	public void setOrders_idx(int orders_idx)
	{
		this.orders_idx = orders_idx;
	}

	public int getProducts_idx()
	{
		return products_idx;
	}
	public void setProducts_idx(int products_idx)
	{
		this.products_idx = products_idx;
	}

	public int getProducts_quantity()
	{
		return products_quantity;
	}
	public void setProducts_quantity(int products_quantity)
	{
		this.products_quantity = products_quantity;
	}

	public float getFinal_price()
	{
		return final_price;
	}
	public void setFinal_price(float final_price)
	{
		this.final_price = final_price;
	}
	
}
