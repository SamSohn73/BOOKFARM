package gq.bookfarm.model;

import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import gq.bookfarm.action.Action;
import gq.bookfarm.action.ActionForward;
import gq.bookfarm.dao.CategoryDAO;
import gq.bookfarm.dao.CustomerDAO;
import gq.bookfarm.dao.ProductDAO;
import gq.bookfarm.dao.ReviewDAO;
import gq.bookfarm.vo.CategoryVO;
import gq.bookfarm.vo.CustomerVO;
import gq.bookfarm.vo.PageVO;
import gq.bookfarm.vo.ProductVO;
import gq.bookfarm.vo.ReviewVO;

public class AdminReviewsSearchAction implements Action {
	private final	Logger				log		= Logger.getLogger(this.getClass());
	private String path;
	public AdminReviewsSearchAction(String path) {
		super();
		this.path = path;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
			int		page			=	1;
			int		products_idx	=	0;
			int		parent_idx		=	0;
			int		category_idx	=	0;
			
			
			String	searchCondition	=	req.getParameter("searchCondition");
			String	searchWord		=	req.getParameter("searchWord");
			Vector<CustomerVO> VcVo	=	new Vector<CustomerVO>();
			if(searchCondition.equals("customers_idx"))
			{
				CustomerDAO cDao	=	new CustomerDAO();
							VcVo	=	cDao.findIdx(searchWord);
										
			}
			
			
			Vector<ReviewVO> list	=	new Vector<ReviewVO>();
			
			if(req.getParameter("products_idx")!=null)	
					products_idx	=	Integer.parseInt(req.getParameter("products_idx"));
			if(req.getParameter("parent_idx")!=null)	
					parent_idx		=	Integer.parseInt(req.getParameter("parent_idx"));
			if(req.getParameter("category_idx")!=null)	
					category_idx	=	Integer.parseInt(req.getParameter("category_idx"));
		
			CategoryDAO catDao		=	new CategoryDAO();
			ProductDAO	pDao		=	new ProductDAO();
			Vector<CategoryVO> catVo1=	catDao.categoryGetTotalRow(0);
			Vector<ProductVO> VpVo	=	new Vector<ProductVO>();
			Vector<CategoryVO> catVo2=	new Vector<CategoryVO>();
			if(category_idx!=0)
					VpVo			=	pDao.productTotalIdx(category_idx);
			if(parent_idx!=0)
					catVo2			=	catDao.categoryGetTotalRow(parent_idx);
			
			
			if(req.getParameter("page")!=null)
						page		=	Integer.parseInt(req.getParameter("page"));
				ReviewDAO dao		=	new ReviewDAO();
				PageVO	info		=	new PageVO();
		
				int		limit		=	10;
				int		totalRows	=	0;
		
			if(parent_idx!=0)
			{
				if(category_idx!=0)
				{
					if(products_idx!=0)
					{
						if(searchCondition.equals("customers_idx"))
						{
							for(CustomerVO cVo : VcVo)
							{
								list.addAll(dao.getProductSearchList(products_idx, page, limit, searchCondition, cVo.getIdx()));
								totalRows	+=	dao.searchOneProductList(products_idx, searchCondition, cVo.getIdx());
							}
						}
						else
						{
							list		=	dao.getProductSearchList(products_idx, page, limit, searchCondition, searchWord);
							totalRows	=	dao.searchOneProductList(products_idx, searchCondition, searchWord);
						}
					}
					else
					{
						Vector<ProductVO> VpVo1 = pDao.productTotalIdx(category_idx);
						for(ProductVO pVo1 : VpVo1)
						{
							if(searchCondition.equals("customers_idx"))
							{
								for(CustomerVO cVo : VcVo)
								{
									list.addAll(dao.getProductSearchList(pVo1.getIdx(), page, limit, searchCondition, cVo.getIdx()));
									totalRows	+=	dao.searchOneProductList(products_idx, searchCondition, cVo.getIdx());
								}
							}
							else
							{
								list.addAll(dao.getProductSearchList(pVo1.getIdx(), page, limit, searchCondition, searchWord));
								totalRows	+=	dao.searchOneProductList(products_idx, searchCondition, searchWord);
							}
						}
						
					}
				}
				else
				{
					Vector<CategoryVO> VcatVo1 = catDao.categoryGetTotalRow(parent_idx);
					for(CategoryVO catVo3 : VcatVo1)
					{
						Vector<ProductVO> VpVo1 = pDao.productTotalIdx(catVo3.getIdx());
						for(ProductVO pVo1 : VpVo1)
						{
							if(searchCondition.equals("customers_idx"))
							{
								for(CustomerVO cVo : VcVo)
								{
									list.addAll(dao.getProductSearchList(pVo1.getIdx(), page, limit, searchCondition, cVo.getIdx()));
									totalRows	+=	dao.searchOneProductList(products_idx, searchCondition, cVo.getIdx());
								}
							}
							else
							{
								list.addAll(dao.getProductSearchList(pVo1.getIdx(), page, limit, searchCondition, searchWord));
								totalRows	+=	dao.searchOneProductList(products_idx, searchCondition, searchWord);
							}
						}
					}
				}
			}
			else
			{
				if(searchCondition.equals("customers_idx"))
				{
					for(CustomerVO cVo : VcVo)
					{
						list.addAll(dao.getSearchList(page, limit, searchCondition, cVo.getIdx()));
						totalRows	+=	dao.searchList(searchCondition, cVo.getIdx());
					}
				}
				else
				{
					list		=	dao.getSearchList(page, limit, searchCondition, searchWord);
					totalRows	=	dao.searchList(searchCondition, searchWord);
				}
			}
			
			
				int		totalPages	=	(int)((double)totalRows/limit+0.95);
				int		startPage	=	((int)((double)page/10+0.9)-1)*10+1;
				int		endPage		=	startPage+10-1;
					
			if(endPage>totalPages)
						endPage		=	totalPages;
									info.setPage(page);
									info.setTotalPages(totalPages);
									info.setTotalRows(totalRows);
									info.setStartPage(startPage);
									info.setEndPage(endPage);
									
									
			if(list!=null) 
			{
									req.setAttribute("list", list);
									req.setAttribute("info", info);
									req.setAttribute("VpVo", VpVo);
									req.setAttribute("catVo1", catVo1);
									req.setAttribute("catVo2", catVo2);
									req.setAttribute("searchCondition", searchCondition);
									req.setAttribute("searchWord", searchWord);
					path		+=	"?products_idx="+products_idx
									+"&parent_idx="+parent_idx+"&category_idx="+category_idx;
			}
			else
			{ 
									log.error("QQQQQQQQ AdminReviewsSearchAction - error");
									//path="";
			}
		return new ActionForward(path, false);
	}

}
