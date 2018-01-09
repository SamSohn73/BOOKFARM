package gq.bookfarm.control;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.model.AdminCategoryListAction;
import gq.bookfarm.model.AdminCustomerListAction;
import gq.bookfarm.model.AdminLoginAction;
import gq.bookfarm.model.AdminLogoutAction;
import gq.bookfarm.model.AdminProductListAction;
import gq.bookfarm.model.AdminOrdersListAction;
import gq.bookfarm.model.CustomerFindAction;
import gq.bookfarm.model.CustomerIdPwdCheckAction;
import gq.bookfarm.model.CustomerLogoutAction;
import gq.bookfarm.model.CustomerRegistAction;
import gq.bookfarm.model.OrdersConfirmAction;
import gq.bookfarm.model.ReviewsDeleteAction;
import gq.bookfarm.model.ReviewsHitUpdateAction;
import gq.bookfarm.model.ReviewsIdPassChkAction;
import gq.bookfarm.model.ReviewsInsertAction;
import gq.bookfarm.model.ReviewsListAction;
import gq.bookfarm.model.ReviewsModifyAction;
import gq.bookfarm.model.ReviewsSearchAction;
import gq.bookfarm.model.ReviewsViewAction;



public class MallActionFactory
{
	private static MallActionFactory mallFactory;
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	private MallActionFactory() {
		log.debug("MallActionFactory() MallActionFactory Created.");
	}
	
	public static MallActionFactory getInstance()
	{
		if (mallFactory == null)		mallFactory = new MallActionFactory();
		
		return mallFactory;
	}
	
	public Action action(String cmd)
	{
		Action action = null;

		if (cmd.equals("/adminLogin.do")) {
			log.debug("AdminLogin.do action create Start.");
			action = new AdminLoginAction("admin/adminLogin.jsp");
			log.debug("AdminLogin.do action create End.");
		}
		if (cmd.equals("/adminLogout.do")) {
			log.debug("AdminLogout.do action create Start.");
			action = new AdminLogoutAction("index.jsp");
			log.debug("AdminLogout.do action create End.");
		}
		if (cmd.equals("/adminCustomerList.do")) {
			log.debug("adminCustomerList.do action create Start.");
			action = new AdminCustomerListAction("admin/adminCustomerList.jsp");
			log.debug("adminCustomerList.do action create End.");
		}
		if (cmd.equals("/adminProductList.do")) {
			log.debug("adminProductList.do action create Start.");
			action = new AdminProductListAction("admin/adminProductList.jsp");
			log.debug("adminProductList.do action create End.");
		}
		if (cmd.equals("/adminOrdersList.do")) {
			log.debug("adminOrdersList.do action create Start.");
			action = new AdminOrdersListAction("admin/adminOrdersList.jsp");
			log.debug("adminOrdersList.do action create End.");
		}
		if (cmd.equals("/adminCategoryList.do")) {
			log.debug("adminCategoryList.do action create Start.");
			action = new AdminCategoryListAction("admin/adminCategoryList.jsp");
			log.debug("adminCategoryList.do action create End.");
		}
		
		/*
		if (cmd.equals("/qSearch.do")) {
			log.debug("QQQQQQQQQQ qSearch.do action create Start.");
			action = new SearchAction("board/qna_board_list.jsp");
			log.debug("QQQQQQQQQQ qSearch.do action create End.");
		}*/
		
		
		//From here, the code for the login were wrote... - hansol -
		//customerDB was used...
		if (cmd.equals("/qCustomerIdPwdCheck.do"))
		{
			log.debug("QQQQQQQQQQ qCustomerIdPwdCheck.do action create Start.");
			action = new CustomerIdPwdCheckAction("member/hansol_main_example.jsp");
			log.debug("QQQQQQQQQQ qCustomerIdPwdCheck.do action create End.");
		}
		else if (cmd.equals("/qCustomerRegist.do"))
		{
			log.debug("QQQQQQQQQQ qCustomerRegist.do action create Start.");
			action = new CustomerRegistAction("./index.jsp");
			log.debug("QQQQQQQQQQ qCustomerRegist.do action create End.");
		}
		else if (cmd.equals("/qCustomerFind.do"))
		{
			log.debug("QQQQQQQQQQ qCustomerFind.do action create Start.");
			action = new CustomerFindAction("./member/find.jsp");
			log.debug("QQQQQQQQQQ qCustomerFind.do action create End.");
		}
		else if (cmd.equals("/qCustomerLogout.do"))
		{
			log.debug("QQQQQQQQQQ qCustomerLogout.do action create Start.");
			action = new CustomerLogoutAction("index.jsp");
			log.debug("QQQQQQQQQQ qCustomerLogout.do action create End.");
		}
		
		
		//From here, I wrote the code for actions related OrdersConfirm... - hansol -
		if (cmd.equals("/qOrdersConfirm.do"))
		{
			log.debug("QQQQQQQQQQ qOrdersConfirm.do action create Start.");
			action = new OrdersConfirmAction("member/order_confirm.jsp");
			log.debug("QQQQQQQQQQ qOrdersConfirm.do action create End.");
		}
		else if (cmd.equals("/qOrderView.do"))
		{
			log.debug("QQQQQQQQQQ qOrderView.do action create Start.");
			action = new OrdersConfirmAction("member/order_view.jsp");
			log.debug("QQQQQQQQQQ qOrderView.do action create End.");
		}
		
		//From here, I wrote code for review action... - hansol -
		//control code for reviewsDB
		if (cmd.equals("/qReviewsLists.do"))
		{
			log.debug("QQQQQQQQQQ qReviewsLists.do action create Start.");
			action = new ReviewsListAction("review/ReviewsList.jsp");
			log.debug("QQQQQQQQQQ qReviewsLists.do action create End.");
		}
		else if(cmd.equals("/qReviewsSearch.do"))
		{
			log.debug("QQQQQQQQQQ qReviewsSearch.do action create Start.");
			action = new ReviewsSearchAction("review/ReviewsList.jsp");
			log.debug("QQQQQQQQQQ qReviewsSearch.do action create End.");
		}
		else if(cmd.equals("/qReviewsHitUpdate.do"))
		{
			log.debug("QQQQQQQQQQ qReviewsHitUpdate.do action create Start.");
			action = new ReviewsHitUpdateAction("qReviewsView.do");
			log.debug("QQQQQQQQQQ qReviewsHitUpdate.do action create End.");
		}
		else if(cmd.equals("/qReviewsView.do"))
		{
			log.debug("QQQQQQQQQQ qReviewsView.do action create Start.");
			action = new ReviewsViewAction("review/ReviewsWrite.jsp");
			log.debug("QQQQQQQQQQ qReviewsView.do action create End.");
		}
		else if(cmd.equals("/qReviewsIdPassChk.do"))
		{
			log.debug("QQQQQQQQQQ qReviewsIdPassChk.do action create Start.");
			action = new ReviewsIdPassChkAction("qReviewsView.do");
			log.debug("QQQQQQQQQQ qReviewsIdPassChk.do action create End.");
		}
		else if(cmd.equals("/qReviewsInsert.do"))
		{
			log.debug("QQQQQQQQQQ qReviewsInsert.do action create Start.");
			action = new ReviewsInsertAction("qReviewsLists.do");
			log.debug("QQQQQQQQQQ qReviewsInsert.do action create End.");
		}
		else if(cmd.equals("/qReviewsDelete.do"))
		{
			log.debug("QQQQQQQQQQ qReviewsDelete.do action create Start.");
			action = new ReviewsDeleteAction("qReviewsLists.do");
			log.debug("QQQQQQQQQQ qReviewsDelete.do action create End.");
		}

		
		return action;
	}
}
