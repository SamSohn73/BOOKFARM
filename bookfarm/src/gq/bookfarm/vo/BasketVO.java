package gq.bookfarm.vo;

import java.sql.Date;

public class BasketVO
{
	private	int		idx;
	private	int		customer_idx;
	private	int		product_idx;
	private	int		quantity;
	private	String	options;
	private	float	final_price;
	private	Date	date_added;
	public BasketVO() {}
	
	public BasketVO(int idx, int customer_idx, int product_idx, int quantity, String options, float final_price,
			Date date_added)
	{
		super();
		this.idx			= idx;
		this.customer_idx	= customer_idx;
		this.product_idx	= product_idx;
		this.quantity		= quantity;
		this.options		= options;
		this.final_price	= final_price;
		this.date_added		= date_added;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public int getCustomer_idx()
	{
		return customer_idx;
	}
	public void setCustomer_idx(int customer_idx)
	{
		this.customer_idx = customer_idx;
	}

	public int getProduct_idx()
	{
		return product_idx;
	}
	public void setProduct_idx(int product_idx)
	{
		this.product_idx = product_idx;
	}

	public int getQuantity()
	{
		return quantity;
	}
	public void setQuantity(int quantity)
	{
		this.quantity = quantity;
	}

	public String getOptions()
	{
		return options;
	}
	public void setOptions(String options)
	{
		this.options = options;
	}

	public float getFinal_price()
	{
		return final_price;
	}
	public void setFinal_price(float final_price)
	{
		this.final_price = final_price;
	}

	public Date getDate_added()
	{
		return date_added;
	}
	public void setDate_added(Date date_added)
	{
		this.date_added = date_added;
	}
	
}
