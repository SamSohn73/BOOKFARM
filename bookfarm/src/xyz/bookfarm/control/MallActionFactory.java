package xyz.bookfarm.control;

import org.apache.log4j.Logger;

import xyz.bookfarm.action.Action;
import xyz.bookfarm.model.AdminLoginAction;
import xyz.bookfarm.model.CustomerFindAction;
import xyz.bookfarm.model.CustomerIdPwdCheckAction;
import xyz.bookfarm.model.CustomerLogoutAction;
import xyz.bookfarm.model.CustomerRegistAction;
import xyz.bookfarm.model.OrdersConfirmAction;
import xyz.bookfarm.model.ReviewsDeleteAction;
import xyz.bookfarm.model.ReviewsHitUpdateAction;
import xyz.bookfarm.model.ReviewsIdPassChkAction;
import xyz.bookfarm.model.ReviewsInsertAction;
import xyz.bookfarm.model.ReviewsListAction;
import xyz.bookfarm.model.ReviewsModifyAction;
import xyz.bookfarm.model.ReviewsSearchAction;
import xyz.bookfarm.model.ReviewsViewAction;



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

		if (cmd.equals("/AdminLogin.do")) {
			log.debug("AdminLogin.do action create Start.");
			action = new AdminLoginAction("admin/adminLogin.jsp");
			log.debug("AdminLogin.do action create End.");
		}
		/*if (cmd.equals("/qWrite.do")) {
			log.debug("QQQQQQQQ qWrite.do action create Start.");
			action = new InsertAction("qList.do");
			log.debug("QQQQQQQQ qWrite.do action create End.");
		}
		if (cmd.equals("/qReplyView.do")) {
			log.debug("QQQQQQQQ qReplayView.do action create Start.");
			action = new ReplyViewAction("board/qna_board_reply.jsp");
			log.debug("QQQQQQQQ qReplayView.do action create End.");
		}	
		if (cmd.equals("/qReply.do")) {
			log.debug("QQQQQQQQ qReply.do action create Start.");
			action = new ReplyAction("qList.do");
			log.debug("QQQQQQQQ qReply.do action create End.");
		}
		
		if (cmd.equals("/qList.do")) {
			log.debug("QQQQQQQQ qList.do action create Start.");
			action = new SelectAction("board/qna_board_list.jsp");
			log.debug("QQQQQQQQ qList.do action create End.");
		}
		if (cmd.equals("/qHitUpdate.do")) {
			log.debug("QQQQQQQQ qHitUpdate.do action create Start.");
			action = new HitUpdateAction("qView.do");
			log.debug("QQQQQQQQ qHitUpdate.do action create End.");
		}
		if (cmd.equals("/qView.do")) {
			log.debug("QQQQQQQQ qView.do action create Start.");
			action = new ViewAction("board/qna_board_view.jsp");
			log.debug("QQQQQQQQ qView.do action create End.");
		}
		if (cmd.equals("/qDelPwdCheck.do")) {
			log.debug("QQQQQQQQ qDelPwdCheck.do action create Start.");
			action = new PwdCheckAction("qDelete.do");
			log.debug("QQQQQQQQ qDelPwdCheck.do action create End.");
		}
		if (cmd.equals("/qModPwdCheck.do")) {
			log.debug("QQQQQQQQ qModPwdCheck.do action create Start.");
			action = new PwdCheckAction("qModify.do");
			log.debug("QQQQQQQQ qModPwdCheck.do action create End.");
		}
		if (cmd.equals("/qDelete.do")) {
			log.debug("QQQQQQQQ qDelete.do action create Start.");
			action = new DeleteAction("qList.do");
			log.debug("QQQQQQQQ qDelete.do action create End.");
		}
		if (cmd.equals("/qModify.do")) {
			log.debug("QQQQQQQQQQ qModify.do action create Start.");
			action = new ModifyAction("board/qna_board_modify.jsp");
			log.debug("QQQQQQQQQQ qModify.do action create End.");
		}
		if (cmd.equals("/qUpdate.do")) {
			log.debug("QQQQQQQQQQ qUpdate.do action create Start.");
			action = new UpdateAction("qView.do");
			log.debug("QQQQQQQQQQ qUpdate.do action create End.");
		}
		
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
			System.out.println("ȸ����������������");
			log.debug("QQQQQQQQQQ qCustomerRegist.do action create Start.");
			action = new CustomerRegistAction("./index.jsp");
			log.debug("QQQQQQQQQQ qCustomerRegist.do action create End.");
			System.out.println("ȸ��������������");
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
			action = new OrdersConfirmAction("order_comfirm.jsp");
			log.debug("QQQQQQQQQQ qOrdersConfirm.do action create End.");
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
