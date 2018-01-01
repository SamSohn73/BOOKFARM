package xyz.bookfarm.vo;

public class CountryVO
{
	private int		idx;
	private	String	name_eng;
	private	String	iso_code_2;
	private	String	iso_code_3;
	
	public CountryVO() {}

	public CountryVO(int idx, String name_eng, String iso_code_2, String iso_code_3)
	{
		super();
		this.idx		= idx;
		this.name_eng	= name_eng;
		this.iso_code_2 = iso_code_2;
		this.iso_code_3 = iso_code_3;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}
	
	public String getName_eng()
	{
		return name_eng;
	}
	public void setName_eng(String name_eng)
	{
		this.name_eng = name_eng;
	}

	public String getIso_code_2()
	{
		return iso_code_2;
	}
	public void setIso_code_2(String iso_code_2)
	{
		this.iso_code_2 = iso_code_2;
	}

	public String getIso_code_3()
	{
		return iso_code_3;
	}
	public void setIso_code_3(String iso_code_3)
	{
		this.iso_code_3 = iso_code_3;
	}
	
	
}
