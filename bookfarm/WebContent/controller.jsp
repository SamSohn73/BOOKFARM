<%@page import="shopping.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*"%>
<jsp:useBean id="db" class="shopping.Database"/>
<% 
request.setCharacterEncoding("EUC-KR");
if(request.getParameter("jangs")!=null){//jangbaguni.jsp에서 옴
	//if(request.getParameterValues("checkOn")!=null){
		//String[] cbox = request.getParameterValues("checkOn");
				
		//상품번호 백터에 담기
		Vector<Vector<Object>> vv = db.getDB();
		Vector<String> vs = new Vector<String>();
		for(int i = 0 ; i < vv.size();i++){
			Vector<Object> v = vv.get(i); 
			vs.add(v.get(0).toString());
		}		
		
		
		String goods;
		int gnum,amount,price;
		
		//for(int i = 0 ; i < cbox.length ; i++){
			for(int j = 0 ; j < vs.size() ; j++){
				//if(cbox[i].equals(vs.get(j))){
					try{
						if(!request.getParameter("amount_"+vs.get(j)).equals("0")){//0개는 안되
							amount = Integer.parseInt(request.getParameter("amount_"+vs.get(j)));
							gnum = Integer.parseInt(request.getParameter("gnum_"+vs.get(j)));
							goods = request.getParameter("goods_"+vs.get(j));
							price = Integer.parseInt(request.getParameter("price_"+vs.get(j)));				
				
							session.setAttribute("goods"+gnum,new Goods(gnum,goods,price,amount));
						}
					}catch(Exception e){}
				//}			
			}
		//}
		response.sendRedirect("result.jsp");
	//}else{response.sendRedirect("jangbaguni.jsp");}
	
	
}else if(request.getParameter("delnum")!=null){//del.jsp에서 옴
	int delGoodsNum = Integer.parseInt(request.getParameter("delnum"));
	session.removeAttribute("goods"+delGoodsNum);
	response.sendRedirect("result.jsp");
}else if(request.getParameter("contype").equals("수정")){//del.jsp에서 온 수정
	String[] nums = request.getParameterValues("gnums");
	
	String goods;
	int amount,price;
	for(int i = 0 ; i < nums.length ; i++){
		amount = Integer.parseInt(request.getParameter("amount_"+nums[i]));
		if(!request.getParameter("amount_"+nums[i]).equals("0")){			
			goods = request.getParameter("goods_"+nums[i]);
			price = Integer.parseInt(request.getParameter("price_"+nums[i]));				
			session.setAttribute("goods"+nums[i],new Goods(Integer.parseInt(nums[i]),goods,price,amount));
		}else session.removeAttribute("goods"+nums[i]);
	}
	response.sendRedirect("result.jsp");
}
%>
