package gq.bookfarm.model;

import java.sql.Date;
import java.util.Hashtable;


import gq.bookfarm.vo.ProductVO;

public class BasketManager {

	//Hashtable : key, value 형식으로 데이터를 처리

	private Hashtable<String,ProductVO> Basket = new Hashtable<String,ProductVO>();

	

	//카트에 추가

	public void addBasket(ProductVO list){

		

		//key값 : product_no, value값 : OrderBean

		int category_idx = list.getCategory_idx();

		int product_quantity = list.getProduct_quantity();

		

		//주문수량이 0보다 크면

		if(product_quantity >0){ 

			

			//카트에 동일상품이 있으면

			if(Basket.containsKey(category_idx)){

				

				//카트의 기존 상품번호의 orderbean을 가져옴

				ProductVO tempBean = (ProductVO)Basket.get(category_idx);

				

				//현재 갯수 + 기존 상품의 갯수

				product_quantity += tempBean.getProduct_price();

				

				//기존상품 갯수 = 현재갯수 + 기존상품 갯수

				tempBean.setProduct_quantity(product_quantity);

				

				//카트에 추가

				Basket.get(getBasketList());

				



			//카트에 동일상품이 없으면

			} else {

				Basket.get(getBasketList());

			}

		}

	}

	

	//카트 목록 출력

	public Hashtable<String,ProductVO> getBasketList() {

		return Basket;

	}

	

	//카트 내용 수정

	public void updateBasket(ProductVO list) {

		int category_idx = list.getCategory_idx();

		Basket.get(getBasketList());

	}

	

	//카트 내용 삭제

	public void deleteBasket(ProductVO list) {

		int category_idx = list.getCategory_idx();

		Basket.remove(category_idx);

	}

}



