package xyz.bookfarm.vo;

import java.sql.Date;

public class CustomerVO
{
	private int		idx	;
	private String	username;
	private String	password;
	private String	firstname;
	private String	lastname;
	private int		country_idx;
	private String	postcode;
	private String	address1;
	private String	address2;
	
	private String	phone1;
	private String	phone2;
	private String	phone3;
	private String	email1;
	private String	email2;
	
	private String	gender;
	private String	newsletter;
	private Date	birthday;
	private int		grade;
	private Date	last_login;
	private int		login_cnt;
	private Date	account_created;
	
	private boolean	on_line;

	public CustomerVO()	{};
	
	public CustomerVO(int idx, String username, String password, String firstname, String lastname, int country_idx,
			String postcode, String address1, String address2, String phone1, String phone2, String phone3,
			String email1, String email2, String gender, String newsletter, Date birthday, int grade, Date last_login,
			int login_cnt, Date account_created, boolean on_line)
	{
		super();
		this.idx				= idx;
		this.username			= username;
		this.password			= password;
		this.firstname			= firstname;
		this.lastname			= lastname;
		this.country_idx		= country_idx;
		this.postcode			= postcode;
		this.address1			= address1;
		this.address2			= address2;
		this.phone1				= phone1;
		this.phone2				= phone2;
		this.phone3				= phone3;
		this.email1				= email1;
		this.email2				= email2;
		this.gender				= gender;
		this.newsletter			= newsletter;
		this.birthday			= birthday;
		this.grade				= grade;
		this.last_login			= last_login;
		this.login_cnt			= login_cnt;
		this.account_created	= account_created;
		this.on_line			= on_line;
	}

	public int getIdx()
	{
		return idx;
	}
	public void setIdx(int idx)
	{
		this.idx = idx;
	}
	
	public String getUsername()
	{
		return username;
	}
	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getPassword()
	{
		return password;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getFirstname()
	{
		return firstname;
	}
	public void setFirstname(String firstname)
	{
		this.firstname = firstname;
	}

	public String getLastname()
	{
		return lastname;
	}
	public void setLastname(String lastname)
	{
		this.lastname = lastname;
	}

	public int getCountry_idx()
	{
		return country_idx;
	}
	public void setCountry_idx(int country_idx)
	{
		this.country_idx = country_idx;
	}

	public String getPostcode()
	{
		return postcode;
	}
	public void setPostcode(String postcode)
	{
		this.postcode = postcode;
	}

	public String getAddress1()
	{
		return address1;
	}
	public void setAddress1(String address1)
	{
		this.address1 = address1;
	}

	public String getAddress2()
	{
		return address2;
	}
	public void setAddress2(String address2)
	{
		this.address2 = address2;
	}

	public String getPhone1()
	{
		return phone1;
	}
	public void setPhone1(String phone1)
	{
		this.phone1 = phone1;
	}

	public String getPhone2()
	{
		return phone2;
	}
	public void setPhone2(String phone2)
	{
		this.phone2 = phone2;
	}

	public String getPhone3()
	{
		return phone3;
	}
	public void setPhone3(String phone3)
	{
		this.phone3 = phone3;
	}

	public String getEmail1()
	{
		return email1;
	}
	public void setEmail1(String email1)
	{
		this.email1 = email1;
	}

	public String getEmail2()
	{
		return email2;
	}
	public void setEmail2(String email2)
	{
		this.email2 = email2;
	}

	public String getGender()
	{
		return gender;
	}
	public void setGender(String gender)
	{
		this.gender = gender;
	}

	public String getNewsletter()
	{
		return newsletter;
	}
	public void setNewsletter(String newsletter)
	{
		this.newsletter = newsletter;
	}

	public Date getBirthday()
	{
		return birthday;
	}
	public void setBirthday(Date birthday)
	{
		this.birthday = birthday;
	}

	public int getGrade()
	{
		return grade;
	}
	public void setGrade(int grade)
	{
		this.grade = grade;
	}

	public Date getLast_login()
	{
		return last_login;
	}
	public void setLast_login(Date last_login)
	{
		this.last_login = last_login;
	}

	public int getLogin_cnt()
	{
		return login_cnt;
	}
	public void setLogin_cnt(int login_cnt)
	{
		this.login_cnt = login_cnt;
	}

	public Date getAccount_created()
	{
		return account_created;
	}
	public void setAccount_created(Date account_created)
	{
		this.account_created = account_created;
	}

	public boolean isOn_line()
	{
		return on_line;
	}
	public void setOn_line(boolean on_line)
	{
		this.on_line = on_line;
	}
	
}
