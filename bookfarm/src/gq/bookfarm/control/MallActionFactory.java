package gq.bookfarm.control;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.model.AdminCategoryAddAction;
import gq.bookfarm.model.AdminCategoryAddViewAction;
import gq.bookfarm.model.AdminCategoryDeleteAction;
import gq.bookfarm.model.AdminCategoryListAction;
import gq.bookfarm.model.AdminCategoryModifyAction;
import gq.bookfarm.model.AdminCategoryModifyViewAction;
import gq.bookfarm.model.AdminCustomerDeleteAction;
import gq.bookfarm.model.AdminCustomerListAction;
import gq.bookfarm.model.AdminCustomerModifyAction;
import gq.bookfarm.model.AdminCustomerModifyViewAction;
import gq.bookfarm.model.AdminCustomerSearchAction;
import gq.bookfarm.model.AdminLoginAction;
import gq.bookfarm.model.AdminLogoutAction;
import gq.bookfarm.model.AdminProductListAction;
import gq.bookfarm.model.AdminProductModifyAction;
import gq.bookfarm.model.AdminProductSearchAction;
import gq.bookfarm.model.AdminProductViewAction;
import gq.bookfarm.model.AdminReviewsDeleteAction;
import gq.bookfarm.model.AdminReviewsInsertAction;
import gq.bookfarm.model.AdminReviewsListAction;
import gq.bookfarm.model.AdminReviewsModifyAction;
import gq.bookfarm.model.AdminReviewsSearchAction;
import gq.bookfarm.model.AdminReviewsViewAction;
import gq.bookfarm.model.AdminReviewsWriteAction;
import gq.bookfarm.model.BasketAddAction;
import gq.bookfarm.model.BasketDeleteAction;
import gq.bookfarm.model.BasketListAction;
import gq.bookfarm.model.AdminOrdersListAction;
import gq.bookfarm.model.AdminProductDeleteAction;
import gq.bookfarm.model.AdminProductInsertAction;
import gq.bookfarm.model.CustomerFindAction;
import gq.bookfarm.model.CustomerIdPwdCheckAction;
import gq.bookfarm.model.CustomerLogoutAction;
import gq.bookfarm.model.CustomerRegistAction;
import gq.bookfarm.model.CustomerRegistSettingAction;
import gq.bookfarm.model.FooterAction;
import gq.bookfarm.model.HeaderAction;
import gq.bookfarm.model.IndexAction;
import gq.bookfarm.model.OrderProductsAction;
import gq.bookfarm.model.OrdersConfirmAction;
import gq.bookfarm.model.ProductListAction;
import gq.bookfarm.model.ProductSearchAction;
import gq.bookfarm.model.ProductViewAction;
import gq.bookfarm.model.ReviewsDeleteAction;
import gq.bookfarm.model.ReviewsHitUpdateAction;
import gq.bookfarm.model.ReviewsIdPassChkAction;
import gq.bookfarm.model.ReviewsInsertAction;
import gq.bookfarm.model.ReviewsListAction;
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

		// Welcome Action
		if (cmd.equals("/index.do")) {
			log.debug("index.do action create Start.");
			action = new IndexAction("index2.jsp");
			log.debug("index.do action create End.");
		}
		
		// Admin Login Logout
		if (cmd.equals("/adminLogin.do")) {
			log.debug("adminLogin.do action create Start.");
			action = new AdminLoginAction("admin/adminLogin.jsp");
			log.debug("adminLogin.do action create End.");
		}
		if (cmd.equals("/adminLogout.do")) {
			log.debug("adminLogout.do action create Start.");
			action = new AdminLogoutAction("index.do");
			log.debug("adminLogout.do action create End.");
		}
		// Admin Customer Management
		if (cmd.equals("/adminCustomerList.do")) {
			log.debug("adminCustomerList.do action create Start.");
			action = new AdminCustomerListAction("admin/adminCustomerList.jsp");
			log.debug("adminCustomerList.do action create End.");
		}
		if (cmd.equals("/adminCustomerModifyView.do")) {
			log.debug("adminCustomerModifyView.do action create Start.");
			action = new AdminCustomerModifyViewAction("admin/adminCustomerModify.jsp");
			log.debug("adminCustomerModifyView.do action create End.");
		}
		if (cmd.equals("/adminCustomerModify.do")) {
			log.debug("adminCustomerModify.do action create Start.");
			action = new AdminCustomerModifyAction("adminCustomerList.do");
			log.debug("adminCustomerModify.do action create End.");
		}
		if (cmd.equals("/adminCustomerDelete.do")) {
			log.debug("adminCustomerDelete.do action create Start.");
			action = new AdminCustomerDeleteAction("adminCustomerList.do");
			log.debug("adminCustomerDelete.do action create End.");
		}
		if (cmd.equals("/adminCustomerSearch.do")) {
			log.debug("adminCustomerSearch.do action create Start.");
			action = new AdminCustomerSearchAction("admin/adminCustomerList.jsp");
			log.debug("adminCustomerSearch.do action create End.");
		}
		// Admin Product Management
		if (cmd.equals("/adminProductList.do")) {
			log.debug("adminProductList.do action create Start.");
			action = new AdminProductListAction("admin/adminProductList.jsp");
			log.debug("adminProductList.do action create End.");
		}
		if (cmd.equals("/adminProductView.do")) {
			log.debug("adminProductViewAction action create Start.");
			action = new AdminProductViewAction("admin/adminProductView.jsp");
			log.debug("adminProductViewAction action create End.");
		}
		if (cmd.equals("/adminProductModify.do")) {
			log.debug("adminProductModify action create Start.");
			action = new AdminProductModifyAction("adminProductList.do");
			log.debug("adminProductModify action create End.");
		}
		if (cmd.equals("/adminProductDelete.do")) {
			log.debug("adminProductDelete action create Start.");
			action = new AdminProductDeleteAction("adminProductList.do");
			log.debug("adminProductDelete action create End.");
		}
		if (cmd.equals("/adminProductInsert.do")) {
			log.debug("adminProductInsert action create Start.");
			action = new AdminProductInsertAction("adminProductList.do");
			log.debug("adminProductInsert action create End.");
		}
		if (cmd.equals("/adminProductSearch.do")) {
			log.debug("adminProductSearch action create Start.");
			action = new AdminProductSearchAction("admin/adminProductList.jsp");
			log.debug("adminProductSearch action create End.");
		}
		// Admin Orders Management
		if (cmd.equals("/adminOrdersList.do")) {
			log.debug("adminOrdersList.do action create Start.");
			action = new AdminOrdersListAction("admin/adminOrdersList.jsp");
			log.debug("adminOrdersList.do action create End.");
		}
		// Admin Category Management
		if (cmd.equals("/adminCategoryList.do")) {
			log.debug("adminCategoryList.do action create Start.");
			action = new AdminCategoryListAction("admin/adminCategoryList.jsp");
			log.debug("adminCategoryList.do action create End.");
		}
		if (cmd.equals("/adminCategoryAddView.do")) {
			log.debug("adminCategoryAddView.do action create Start.");
			action = new AdminCategoryAddViewAction("admin/adminCategoryAdd.jsp");
			log.debug("adminCategoryAddView.do action create End.");
		}
		if (cmd.equals("/adminCategoryAdd.do")) {
			log.debug("adminCategoryAdd.do action create Start.");
			action = new AdminCategoryAddAction("/adminCategoryList.do");
			log.debug("adminCategoryAdd.do action create End.");
		}
		if (cmd.equals("/adminCategoryModifyView.do")) {
			log.debug("adminCategoryModifyView.do action create Start.");
			action = new AdminCategoryModifyViewAction("admin/adminCategoryModify.jsp");
			log.debug("adminCategoryModifyView.do action create End.");
		}
		if (cmd.equals("/adminCategoryModify.do")) {
			log.debug("adminCategoryModify.do action create Start.");
			action = new AdminCategoryModifyAction("/adminCategoryList.do");
			log.debug("adminCategoryModify.do action create End.");
		}
		if (cmd.equals("/adminCategoryDelete.do")) {
			log.debug("adminCategoryDelete.do action create Start.");
			action = new AdminCategoryDeleteAction("/adminCategoryList.do");
			log.debug("adminCategoryDelete.do action create End.");
		}
		if (cmd.equals("/adminCategoryDelete.do")) {
			log.debug("adminCategoryDelete.do action create Start.");
			action = new AdminCategoryDeleteAction("/adminCategoryList.do");
			log.debug("adminCategoryDelete.do action create End.");
		}
		// Admin review Management
		//hansol's administrator control commend list....
		if(cmd.equals("/adminReviewsList.do"))
		{
			log.debug("qAdminReviewsList.do action create Start.");
			action = new AdminReviewsListAction("./admin/adminReviewsList.jsp");
			log.debug("qAdminReviewsList.do action create End.");
		}
		else if(cmd.equals("/adminReviewsView.do"))
		{
			log.debug("qAdminReviewsView.do action create Start.");
			action = new AdminReviewsViewAction("./admin/adminReviewsView.jsp");
			log.debug("qAdminReviewsView.do action create End.");
		}
		else if(cmd.equals("/adminReviewsWrite.do"))
		{
			log.debug("qAdminReviewsWrite.do action create Start.");
			action = new AdminReviewsWriteAction("./admin/adminReviewsWrite.jsp");
			log.debug("qAdminReviewsWrite.do action create End.");
		}
		else if(cmd.equals("/adminReviewsInsert.do"))
		{
			log.debug("qAdminReviewsInsert.do action create Start.");
			action = new AdminReviewsInsertAction("/adminReviewsList.do");
			log.debug("qAdminReviewsInsert.do action create End.");
		}
		else if(cmd.equals("/adminReviewsDelete.do"))
		{
			log.debug("qAdminReviewsDelete.do action create Start.");
			action = new AdminReviewsDeleteAction("/adminReviewsList.do");
			log.debug("qAdminReviewsDelete.do action create End.");
		}
		else if(cmd.equals("/adminReviewsModify.do"))
		{
			log.debug("qAdminReviewsModify.do action create Start.");
			action = new AdminReviewsModifyAction("/adminReviewsView.do");
			log.debug("qAdminReviewsModify.do action create End.");
		}
		else if(cmd.equals("/adminReviewsSearch.do"))
		{
			log.debug("qAdminReviewsSearch.do action create Start.");
			action = new AdminReviewsSearchAction("./admin/adminReviewsList.jsp");
			log.debug("qAdminReviewsSearch.do action create End.");
		}
		// Product Windows
		if (cmd.equals("/productList.do")) {
			log.debug("productList.do action create Start.");
			action = new ProductListAction("product/productList.jsp");
			log.debug("productList.do action create End.");
		}
		if (cmd.equals("/productView.do")) {
			log.debug("productView.do action create Start.");
			action = new ProductViewAction("product/productView.jsp");
			log.debug("productView.do action create End.");
		}
		if (cmd.equals("/productSearch.do")) {
			log.debug("productSearch.do action create Start.");
			action = new ProductSearchAction("product/productList.jsp");
			log.debug("productSearch.do action create End.");
		}
		
		//From here, the code for the login were wrote... - hansol -
		//customerDB was used...
		if (cmd.equals("/qCustomerIdPwdCheck.do"))
		{
			log.debug("qCustomerIdPwdCheck.do action create Start.");
			action = new CustomerIdPwdCheckAction("index.do");
			log.debug("qCustomerIdPwdCheck.do action create End.");
		}
		else if (cmd.equals("/qCustomerRegist.do"))
		{
			log.debug("qCustomerRegist.do action create Start.");
			action = new CustomerRegistAction("index.do");
			log.debug("qCustomerRegist.do action create End.");
		}
		else if (cmd.equals("/qCustomerFind.do"))
		{
			log.debug("qCustomerFind.do action create Start.");
			action = new CustomerFindAction("./member/find.jsp");
			log.debug("qCustomerFind.do action create End.");
		}
		else if (cmd.equals("/qCustomerLogout.do"))
		{
			log.debug("qCustomerLogout.do action create Start.");
			action = new CustomerLogoutAction("index.do");
			log.debug("qCustomerLogout.do action create End.");
		}
		else if (cmd.equals("/CustomerRegistSetting.do"))
		{
			log.debug("CustomerRegistSetting.do action create Start.");
			action = new CustomerRegistSettingAction("/member/regist_v2.jsp");
			log.debug("CustomerRegistSetting.do action create End.");
		}
		
		//From here, I wrote the code for actions related OrdersConfirm... - hansol -
		if (cmd.equals("/qOrdersConfirm.do"))
		{
			log.debug("qOrdersConfirm.do action create Start.");
			action = new OrdersConfirmAction("member/order_confirm.jsp");
			log.debug("qOrdersConfirm.do action create End.");
		}
		else if (cmd.equals("/qOrderView.do"))
		{
			log.debug("qOrderView.do action create Start.");
			action = new OrdersConfirmAction("member/order_view.jsp");
			log.debug("qOrderView.do action create End.");
		}
		
		//From here, I wrote code for review action... - hansol -
		//control code for reviewsDB
		if (cmd.equals("/qReviewsLists.do"))
		{
			log.debug("qReviewsLists.do action create Start.");
			action = new ReviewsListAction("review/ReviewsList.jsp");
			log.debug("qReviewsLists.do action create End.");
		}
		else if(cmd.equals("/qReviewsSearch.do"))
		{
			log.debug("qReviewsSearch.do action create Start.");
			action = new ReviewsSearchAction("review/ReviewsList.jsp");
			log.debug("qReviewsSearch.do action create End.");
		}
		else if(cmd.equals("/qReviewsHitUpdate.do"))
		{
			log.debug("qReviewsHitUpdate.do action create Start.");
			action = new ReviewsHitUpdateAction("qReviewsView.do");
			log.debug("qReviewsHitUpdate.do action create End.");
		}
		else if(cmd.equals("/qReviewsView.do"))
		{
			log.debug("qReviewsView.do action create Start.");
			action = new ReviewsViewAction("review/ReviewsWrite.jsp");
			log.debug("qReviewsView.do action create End.");
		}
		else if(cmd.equals("/qReviewsIdPassChk.do"))
		{
			log.debug("qReviewsIdPassChk.do action create Start.");
			action = new ReviewsIdPassChkAction("qReviewsView.do");
			log.debug("qReviewsIdPassChk.do action create End.");
		}
		else if(cmd.equals("/qReviewsInsert.do"))
		{
			log.debug("qReviewsInsert.do action create Start.");
			action = new ReviewsInsertAction("qReviewsLists.do");
			log.debug("qReviewsInsert.do action create End.");
		}
		else if(cmd.equals("/qReviewsDelete.do"))
		{
			log.debug("qReviewsDelete.do action create Start.");
			action = new ReviewsDeleteAction("qReviewsLists.do");
			log.debug("qReviewsDelete.do action create End.");
		}
		
		//Basket Management
		if (cmd.equals("/basketAdd.do")) {
			log.debug("basketAdd.do action create Start.");
			action = new BasketAddAction("basketList.do");
			log.debug("basketAdd.do action create End.");
		}
		if (cmd.equals("/basketList.do")) {
			log.debug("basketList.do action create Start.");
			action = new BasketListAction("product/basketList.jsp");
			log.debug("basketList.do action create End.");
		}
		if (cmd.equals("/basketDelete.do")) {
			log.debug("basketDelete.do action create Start.");
			action = new BasketDeleteAction("basketList.do");
			log.debug("basketDelete.do action create End.");
		}
		
		// hansol...
		if (cmd.equals("/OrderProducts.do")) {
			log.debug("OrderProducts.do action create Start.");
			action = new OrderProductsAction("index.do");
			log.debug("OrderProducts.do action create End.");
		}
		if (cmd.equals("/footer.do")) {
			log.debug("footer.do action create Start.");
			action = new FooterAction("footer.jsp");
			log.debug("footer.do action create End.");
		}
		
		return action;
	}
}

