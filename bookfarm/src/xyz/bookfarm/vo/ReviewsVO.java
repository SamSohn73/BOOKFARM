package xyz.bookfarm.vo;

import java.sql.Date;

public class ReviewsVO {
	int		idx;
	int		products_idx;
	int		customers_idx;
	int		reviews_rating;
	String	review_title;
	String	review_text;
	Date	date_added;
	Date	last_modified;
	int		reviews_read;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getProducts_idx() {
		return products_idx;
	}
	public void setProducts_idx(int products_idx) {
		this.products_idx = products_idx;
	}
	public int getCustomers_idx() {
		return customers_idx;
	}
	public void setCustomers_idx(int customers_idx) {
		this.customers_idx = customers_idx;
	}
	public int getReviews_rating() {
		return reviews_rating;
	}
	public void setReviews_rating(int reviews_rating) {
		this.reviews_rating = reviews_rating;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getReview_text() {
		return review_text;
	}
	public void setReview_text(String review_text) {
		this.review_text = review_text;
	}
	public Date getDate_added() {
		return date_added;
	}
	public void setDate_added(Date date_added) {
		this.date_added = date_added;
	}
	public Date getLast_modified() {
		return last_modified;
	}
	public void setLast_modified(Date last_modified) {
		this.last_modified = last_modified;
	}
	public int getReviews_read() {
		return reviews_read;
	}
	public void setReviews_read(int reviews_read) {
		this.reviews_read = reviews_read;
	}
	public ReviewsVO(int idx, int products_idx, int customers_idx, int reviews_rating, String review_title,
			String review_text, Date date_added, Date last_modified, int reviews_read) {
		super();
		this.idx = idx;
		this.products_idx = products_idx;
		this.customers_idx = customers_idx;
		this.reviews_rating = reviews_rating;
		this.review_title = review_title;
		this.review_text = review_text;
		this.date_added = date_added;
		this.last_modified = last_modified;
		this.reviews_read = reviews_read;
	}
	public ReviewsVO() {
		super();
	}
}
