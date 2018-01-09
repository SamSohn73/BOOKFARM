package gq.bookfarm.model;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddBasket {
	private void addCart(HttpServletRequest request,

        HttpServletResponse response) throws Exception{



int no = Integer.parseInt(request.getParameter("no"));

int amount = Integer.parseInt(request.getParameter("amount"));



HttpSession session = request.getSession();

// 장바구니 확인

HashMap<Integer,OrderProduct> cart =

                          (HashMap<Integer,OrderProduct>)session.getAttribute("cart");



// 없다면

if(cart == null){

        // 장바구니 생성

        cart = new HashMap<Integer,OrderProduct>();

        session.setAttribute("cart", cart);

        // 장바구니에 상품을 추가

        Product p = productDao.productSearch(no);

        OrderProduct product = new OrderProduct(p, amount);

       

        cart.put(no, product);

       

}else{

// 있다면

        // 상품이 장바구니에 존재하는 지 확인

        OrderProduct product = cart.get(no);

        if(product==null){

                          // 없다면

                          // 장바구니에 상품을 추가

                          Product p = productDao.productSearch(no);

                          product = new OrderProduct(p, amount);

                          cart.put(no, product);

                          }else{

                          // 있다면

                          // 상품 수량 변경

                                           product.setAmount(product.getAmount() + amount);

        }

}

// 장바구니 목록으로 페이지 이동

response.sendRedirect("cart.jsp");



}
}


