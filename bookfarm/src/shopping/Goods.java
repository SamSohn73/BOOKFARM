package shopping;

public class Goods {
	private String goods;
	private int price;
	private int amount;
	private int gnum;
	
	public Goods(int gnum,String goods,int price,int amount){
		this.gnum=gnum;
		this.goods=goods;
		this.price=price;
		this.amount=amount;
	}
	public int getGnum() {
		return gnum;
	}
	
	public int getAmount() {
		return amount;
	}

	public String getGoods() {
		return goods;
	}

	public int getPrice() {
		return price;
	}

}
