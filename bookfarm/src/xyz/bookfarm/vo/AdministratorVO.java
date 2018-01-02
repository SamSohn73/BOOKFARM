package xyz.bookfarm.vo;

public class AdministratorVO
{
	private	int		idx;
	private	String	user_name;
	private	String	user_password;
	
	public AdministratorVO() {}

	public AdministratorVO(int idx, String user_name, String user_password)
	{
		super();
		this.idx			= idx;
		this.user_name		= user_name;
		this.user_password	= user_password;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}

	public String getUser_name()
	{
		return user_name;
	}
	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}

	public String getUser_password()
	{
		return user_password;
	}
	public void setUser_password(String user_password)
	{
		this.user_password = user_password;
	}
	
	
}
