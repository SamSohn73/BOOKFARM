package xyz.bookfarm.vo;

import java.sql.Date;

public class CurrencyVO
{
	private	int		idx;
	private	String	title;
	private	String	code;
	private	String	symbol_left;
	private	String	symbol_right;
	private	char	decimal_point;
	private	char	thousands_point;
	private	char	decimal_places;
	private	float	worth;
	private	Date	last_updated;
	
	public CurrencyVO()
	{
		super();
		// TODO Auto-generated constructor stub
	}

	public CurrencyVO(int idx, String title, String code, String symbol_left, String symbol_right, char decimal_point,
			char thousands_point, char decimal_places, float worth, Date last_updated)
	{
		super();
		this.idx				= idx;
		this.title				= title;
		this.code				= code;
		this.symbol_left		= symbol_left;
		this.symbol_right		= symbol_right;
		this.decimal_point		= decimal_point;
		this.thousands_point	= thousands_point;
		this.decimal_places		= decimal_places;
		this.worth				= worth;
		this.last_updated		= last_updated;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getCode()
	{
		return code;
	}
	public void setCode(String code)
	{
		this.code = code;
	}

	public String getSymbol_left()
	{
		return symbol_left;
	}
	public void setSymbol_left(String symbol_left)
	{
		this.symbol_left = symbol_left;
	}

	public String getSymbol_right()
	{
		return symbol_right;
	}
	public void setSymbol_right(String symbol_right)
	{
		this.symbol_right = symbol_right;
	}

	public char getDecimal_point()
	{
		return decimal_point;
	}
	public void setDecimal_point(char decimal_point)
	{
		this.decimal_point = decimal_point;
	}

	public char getThousands_point()
	{
		return thousands_point;
	}
	public void setThousands_point(char thousands_point)
	{
		this.thousands_point = thousands_point;
	}

	public char getDecimal_places()
	{
		return decimal_places;
	}
	public void setDecimal_places(char decimal_places)
	{
		this.decimal_places = decimal_places;
	}

	public float getWorth()
	{
		return worth;
	}
	public void setWorth(float worth)
	{
		this.worth = worth;
	}

	public Date getLast_updated()
	{
		return last_updated;
	}
	public void setLast_updated(Date last_updated)
	{
		this.last_updated = last_updated;
	}
	
}
