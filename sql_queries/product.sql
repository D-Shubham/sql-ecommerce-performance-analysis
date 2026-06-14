create table product (
	product_id varchar(10) primary key,
	product_name varchar(100),
	brand varchar(50),
	category varchar(50),
	subcategory varchar(50),
	price decimal(10,2) not null,
	currency varchar(3) default 'INR',
	discount_percentage int default 0,
	discounted_price decimal(10,2),
	rating decimal(3,1),
	reviews_count int default 0,
	popularity_score decimal(10,2),
	stock_status varchar(20),
	date_added date,
	description varchar(255)
);

select*from product
;

---------------------------------------------------------------
--Top 10 products by popularity score--
select 
product_name as name,
brand,
popularity_score as popular
from product
order by popularity_score desc
limit 10
;

--Top 10 product by review count--
select
product_name as product,
reviews_count as review
from product
order by reviews_count desc
limit 10
;

--Top 10 products by rating with minimum review treshold--
select
product_name as name,
brand,
reviews_count as total_people_review,
rating
from product
where reviews_count>500  --this is the "minimum review treshold"
order by rating desc
limit 10
;

--Brand wise average rating,reviews,popularity and stock distribution--
select
brand,
--Performing average--
round(avg(rating),2) as average_rating,
round(avg(reviews_count),2) as review,
round(avg(popularity_score),2) as popularity,
--stock distribution(counting items in each status)--
sum(case when stock_status= 'In Stock' then 1 else 0 end) as count_in_stock,
sum(case when stock_status= 'Limited Stock' then 1 else 0 end) as count_limited_stock,
sum(case when stock_status= 'Out of Stock' then 1 else 0 end) as count_out_of_stock
from product
group by brand
order by average_rating desc
;

--category wise average price,discount,and popularity--
select
category,
round(avg(price),2) as average_price,
round(avg(discount_percentage),2) as average_discount_percentage,
round(avg(discounted_price),2) as average_discount_price,
round(avg(popularity_score),2) as average_popularity
from product
group by category
order by average_price desc
;

--sub-category wise product performance ranking--
with subcategory as(
	select
		subcategory,
		round(avg(popularity_score),2) as popular,
		sum(reviews_count) as total_review,
		round(avg(rating),2) as average_rating
from product
group by subcategory
)
select
--this create leaderboard rank--
rank()over(order by popular desc) as performer_rank,
subcategory, popular,total_review,average_rating
from subcategory
;

--product with high price and low popularity--
select 
product_name as product,
category,
price,popularity_score
from product
where price > (select avg(price) from product)
and popularity_score < (select avg(popularity_score) from product)
order by price desc
;

--product with high discount but low rating--
select
product_name as product,
category,
discount_percentage,
price,
rating
from product
where discount_percentage>(select avg(discount_percentage) from product)
and rating<(select avg(rating) from product )
order by rating asc,discount_percentage desc
;

--Out-Of-Stock products with high popularity or high reviews--
select 
product_name as product,
stock_status,popularity_score,reviews_count
from product
where stock_status='Out of Stock'
and (popularity_score>(select avg(popularity_score)from product)
or  reviews_count>(select avg(reviews_count)from product))
order by popularity_score desc,reviews_count desc
;

--monthly product additionsa nd trend by category--
select
      --extract the month and year from the date--
TO_CHAR(date_added,'YYYY-mm') as uploaded_month,
category,
       --count the total products added for that category in that month--
count(product_id) as product_added
from product
group by TO_CHAR(date_added,'YYYY-mm'),category
order by uploaded_month asc,product_added desc
;

--product added recently but already performing well--
select
 product_name as product,
 rating,
 popularity_score as popular
from product
where date_added>=(select max(date_added) from product)- INTERVAL'90 days'
and(rating>(select avg(rating)from product)
or popularity_score>(select avg(popularity_score)from product))
group by product_name,rating,popularity_score
order by rating desc,popularity_score desc
;

--product with the biggest gap between price and discounted price--
select
product_name as product,
price,
discounted_price,
(price-discounted_price) as gap
from product
order by gap desc
limit 10
;

--Brand with the highest share of out-of-stock items--
select
brand,
count(product_id),  --count total products belonging to the brand--
sum(case when stock_status='Out of Stock' then 1 else 0 end) as out_of_stock_count,
      --count the product which is out of stock--
round(sum(case when stock_status='Out of Stock' then 1 else 0 end)*100.0/count(product_id),2) as out_of_stock_percentage
from product
group by brand
order by out_of_stock_percentage desc
;

--categories with the weakest average rating--
select
category,
round(avg(rating),2) as weakest_rating,
count(product_id) as toital_product
from product
group by category
order by weakest_rating asc
;

--Best and worst product in each brand--
with rankedproduct as(
	select 
	brand,product_name,rating,
	--rank 1 will be the highest rated item for this brand--
	row_number() over(partition by brand order by rating desc,popularity_score desc) as best_rank,
	--rank 1 will be the lowest rated item for this brand--
	row_number() over(partition by brand order by rating asc,popularity_score asc) as worst_rank
	from product	
)
select
	r.brand,
	r.product_name as product,
	r.rating as best_rating,
	p.product_name as worst_product,
	p.rating as worst_rating
from rankedproduct r
join rankedproduct p 
on r.brand=p.brand
where r.best_rank=1 and p.worst_rank=1
order by p.brand asc
;

------------------------------------------------------------------
