package gq.bookfarm.vo;

import java.sql.Date;

public class OrdersVO
{
	private	int		idx;
	private	int		customers_idx;
	
	private	String	delivery_name;
	private	String	delivery_postcode;
	private	String	delivery_address1;
	private	String	delivery_address2;
	private	String	delivery_phone1;
	private	String	delivery_phone2;
	private	String	delivery_phone3;
	private	String	delivery_email1;
	private	String	delivery_email2;
	
	private	String	billing_name;
	private	String	billing_postcode;
	private	String	billing_address1;
	private	String	billing_address2;
	private	String	billing_phone1;
	private	String	billing_phone2;
	private	String	billing_phone3;
	private	String	billing_email1;
	private	String	billing_email2;
	
	private	String	payment_method;
	private	float	final_price;
	
	private	Date	last_modified;
	private	Date	date_purchased;
	private	int		orders_status;
	private	Date	orders_date_finished;
	
	public OrdersVO() {}

	public OrdersVO(int idx, int customers_idx, String delivery_name,
			String delivery_postcode, String delivery_address1, String delivery_address2, String delivery_phone1,
			String delivery_phone2, String delivery_phone3, String delivery_email1, String delivery_email2,
			String billing_name, String billing_postcode, String billing_address1,
			String billing_address2, String billing_phone1, String billing_phone2, String billing_phone3,
			String billing_email1, String billing_email2, String payment_method, float final_price, Date last_modified,
			Date date_purchased, int orders_status, Date orders_date_finished)
	{
		super();
		this.idx = idx;
		this.customers_idx = customers_idx;
		this.delivery_name = delivery_name;
		this.delivery_postcode = delivery_postcode;
		this.delivery_address1 = delivery_address1;
		this.delivery_address2 = delivery_address2;
		this.delivery_phone1 = delivery_phone1;
		this.delivery_phone2 = delivery_phone2;
		this.delivery_phone3 = delivery_phone3;
		this.delivery_email1 = delivery_email1;
		this.delivery_email2 = delivery_email2;
		this.billing_name = billing_name;
		this.billing_postcode = billing_postcode;
		this.billing_address1 = billing_address1;
		this.billing_address2 = billing_address2;
		this.billing_phone1 = billing_phone1;
		this.billing_phone2 = billing_phone2;
		this.billing_phone3 = billing_phone3;
		this.billing_email1 = billing_email1;
		this.billing_email2 = billing_email2;
		this.payment_method = payment_method;
		this.final_price = final_price;
		this.last_modified = last_modified;
		this.date_purchased = date_purchased;
		this.orders_status = orders_status;
		this.orders_date_finished = orders_date_finished;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public int getCustomers_idx()
	{
		return customers_idx;
	}
	public void setCustomers_idx(int customers_idx)
	{
		this.customers_idx = customers_idx;
	}

	public String getDelivery_name()
	{
		return delivery_name;
	}
	public void setDelivery_name(String delivery_name)
	{
		this.delivery_name = delivery_name;
	}

	public String getDelivery_postcode()
	{
		return delivery_postcode;
	}
	public void setDelivery_postcode(String delivery_postcode)
	{
		this.delivery_postcode = delivery_postcode;
	}

	public String getDelivery_address1()
	{
		return delivery_address1;
	}
	public void setDelivery_address1(String delivery_address1)
	{
		this.delivery_address1 = delivery_address1;
	}

	public String getDelivery_address2()
	{
		return delivery_address2;
	}
	public void setDelivery_address2(String delivery_address2)
	{
		this.delivery_address2 = delivery_address2;
	}

	public String getDelivery_phone1()
	{
		return delivery_phone1;
	}
	public void setDelivery_phone1(String delivery_phone1)
	{
		this.delivery_phone1 = delivery_phone1;
	}

	public String getDelivery_phone2()
	{
		return delivery_phone2;
	}
	public void setDelivery_phone2(String delivery_phone2)
	{
		this.delivery_phone2 = delivery_phone2;
	}

	public String getDelivery_phone3()
	{
		return delivery_phone3;
	}
	public void setDelivery_phone3(String delivery_phone3)
	{
		this.delivery_phone3 = delivery_phone3;
	}

	public String getDelivery_email1()
	{
		return delivery_email1;
	}
	public void setDelivery_email1(String delivery_email1)
	{
		this.delivery_email1 = delivery_email1;
	}

	public String getDelivery_email2()
	{
		return delivery_email2;
	}
	public void setDelivery_email2(String delivery_email2)
	{
		this.delivery_email2 = delivery_email2;
	}

	public String getBilling_name()
	{
		return billing_name;
	}
	public void setBilling_name(String billing_name)
	{
		this.billing_name = billing_name;
	}


	public String getBilling_postcode()
	{
		return billing_postcode;
	}
	public void setBilling_postcode(String billing_postcode)
	{
		this.billing_postcode = billing_postcode;
	}

	public String getBilling_address1()
	{
		return billing_address1;
	}
	public void setBilling_address1(String billing_address1)
	{
		this.billing_address1 = billing_address1;
	}

	public String getBilling_address2()
	{
		return billing_address2;
	}
	public void setBilling_address2(String billing_address2)
	{
		this.billing_address2 = billing_address2;
	}

	public String getBilling_phone1()
	{
		return billing_phone1;
	}
	public void setBilling_phone1(String billing_phone1)
	{
		this.billing_phone1 = billing_phone1;
	}

	public String getBilling_phone2()
	{
		return billing_phone2;
	}
	public void setBilling_phone2(String billing_phone2)
	{
		this.billing_phone2 = billing_phone2;
	}

	public String getBilling_phone3()
	{
		return billing_phone3;
	}
	public void setBilling_phone3(String billing_phone3)
	{
		this.billing_phone3 = billing_phone3;
	}

	public String getBilling_email1()
	{
		return billing_email1;
	}
	public void setBilling_email1(String billing_email1)
	{
		this.billing_email1 = billing_email1;
	}

	public String getBilling_email2()
	{
		return billing_email2;
	}
	public void setBilling_email2(String billing_email2)
	{
		this.billing_email2 = billing_email2;
	}

	public String getPayment_method()
	{
		return payment_method;
	}
	public void setPayment_method(String payment_method)
	{
		this.payment_method = payment_method;
	}

	public float getFinal_price()
	{
		return final_price;
	}
	public void setFinal_price(float final_price)
	{
		this.final_price = final_price;
	}

	public Date getLast_modified()
	{
		return last_modified;
	}
	public void setLast_modified(Date last_modified)
	{
		this.last_modified = last_modified;
	}

	public Date getDate_purchased()
	{
		return date_purchased;
	}
	public void setDate_purchased(Date date_purchased)
	{
		this.date_purchased = date_purchased;
	}

	public int getOrders_status()
	{
		return orders_status;
	}
	public void setOrders_status(int orders_status)
	{
		this.orders_status = orders_status;
	}

	public Date getOrders_date_finished()
	{
		return orders_date_finished;
	}
	public void setOrders_date_finished(Date orders_date_finished)
	{
		this.orders_date_finished = orders_date_finished;
	}
	
}
