--HELPFUL STATEMENTS

--delete from customer where accountid >= 1;
select * from customer where accountid >= 1;
--delete from product;
select * from product;
--delete from address;
select * from address;
--delete from payment;
select * from payment;
--delete from cart_items;
select * from cart; 
--delete from invoice;
select * from invoice;
--delete from invoice_record_deleted_account;
select * from invoice_record_deleted_account;
select * from reviews;

SELECT i.invoiceid, i.totalprice, pp.pname, c.fname || ' ' ||c.lname from invoice i join invoice_products p on i.invoiceid =p.invoiceid join product pp on pp.productid = p.productid join customer c on c.accountid= i.accountid;

SELECT i.invoiceid, pp.pname from invoice i join invoice_products p on i.invoiceid =p.invoiceid join product pp on pp.productid = p.productid;

SELECT i.invoiceid, i.fname || ' ' ||i.lname from invoice_record_deleted_account i;

-------------------------------------------------------------------------------------------
--BELLA ACCOUNT 

--create account 
INSERT into customer VALUES(seqID.nextVal, 'Isabella', 'Attisano', 'iattisan@villanova.edu', '0123456789');

--Address add / delete / view

--delete from address where accountid = 1 and street = '250 Spring Mill Road';
INSERT INTO address VALUES(1, '27 W 53 Street', 'Bayonne', 'NJ', '07002');
INSERT INTO address VALUES(1, '250 Spring Mill Road', 'Villanova', 'PA', '19085');

SELECT Street || ' ' || City || ', '|| State || ', ' || Zip as Addresses FROM address WHERE accountID = 1; 

--Payment add / delete / view

INSERT into payment Values(1, 5, 2024, '1234567891011123', '123');
INSERT into payment Values(1, 8, 2028, '1234123412341234', '180');

delete from payment where accountid =1 and cardnumber = '1234567891011123';

select expMonth ||'/'|| expYear AS Expiration_Date, '************'||''||SUBSTR(cardnumber, 13, 4) AS Card_Number 
FROM payment WHERE accountID = 1;

--add / remove items to cart

INSERT INTO cart_items VALUES(1, 30, 'medium', 1, 19.95);
INSERT INTO cart_items VALUES(1, 31, 'large', 1, 25);
INSERT INTO cart_items VALUES(1, 40, 'onesize', 2, 12.99);
INSERT INTO cart_items VALUES(1, 41, 'onesize', 1, 37);

SELECT * from cart_items where cartid =1;

-- total price of cart 
select sum(c.price*c.pquantity) from cart_items c where cartid =1;

--see product review 

select age, feet ||' foot '|| inches as height, rating ||''|| ' out of 5' as Overall_Rating, sizedesc, recommend from reviews where productid = 11;
 
DELETE FROM cart_items where cartid =1 and productid = 4;

UPDATE cart_items set pquantity = 1 where cartid = 1 and productid = 10;
UPDATE cart_items set psize = 'large' where cartid = 1 and productid = 1;

--place order

UPDATE cart set cartid = 1 where cartid = 1;

-- view invoice history 

select * from invoice where accountid =1;

--view invoice products 
select i.invoiceid, p.pname, ip.psize, ip.pquanity, p.price 
from invoice_products ip join invoice i on ip.invoiceid = i.invoiceid join product p on p.productid = ip.productid 
where i.accountid = 1 
order by i.invoiceid;

--add review

INSERT into reviews Values(1, 11, 20, 5, 6, 5, 'One Size', 'Yes');

--add items to favorites / get all favorited items 

INSERT into favorites Values(1,2);
INSERT into favorites Values(1,30);
INSERT into favorites Values(1,26);

SELECT pname, ptype, productid, price FROM favorites NATURAL JOIN product WHERE accountid = 1;

--delete account

Delete from customer where accountid = 1;

--invoice history should still be found

select ird.fname, ird.lname, ird.invoiceid from invoice_record_deleted_account ird where fname = 'Isabella' and lname = 'Attisano'; 

-------------------------------------------------------------------------------------------

-- KAYLEIGH ACCOUNT 
-- Create accounts with ID 6, 7
INSERT INTO customer VALUES(seqID.nextVal, 'Kayleigh', 'DiNatale', 'kwd@villanova.edu', '9141234567');
INSERT INTO customer VALUES(seqID.nextVal, 'Regan', 'DiNatale', 'rdin@ohiostate.edu', '9178342938');

-- Add addresses to Kayleigh's account
INSERT INTO address VALUES(2, '123 Green St', 'Philadelphia', 'PA', '10456');
INSERT INTO address VALUES(2, '50 Highbrook Rd', 'Binghamton', 'NY', '45231');


-- View Kayleigh's address options
SELECT Street ||' '|| City ||' '|| State ||' '|| Zip as Addresses 
FROM address 
WHERE accountID = 2;

-- ADD payments to Kayleigh's account
INSERT INTO payment VALUES(6, 2, 2028, '5555444433332222', '123');
INSERT INTO payment VALUES(6, 1, 2021, '1234567891234567', '423');

-- View Kayleigh's payment options
select expMonth ||'/'|| expYear AS Expiration_Date, '************'||''||SUBSTR(cardnumber, 13, 4) AS Card_Number 
FROM payment 
WHERE accountID = 2;

-- Add items to cart
INSERT INTO cart_items VALUES(2, 1, 'medium', 1, 19.95);
INSERT INTO cart_items VALUES(2, 3, 'medium', 1, 49.95);
INSERT INTO cart_items VALUES(2, 4, 'medium', 3, 25);

-- View Kayleigh's current cart
select * from cart_items where cartid = 2;

--fix total price input 
Update cart_items set price = 75 where cartid = 2 and productid = 4;

-- Change quantity, change price
Update cart_items set pquantity = 2 where cartid = 2 and productid = 4;
Update cart_items set price = 50 where cartid = 2 and productid = 4;

select * from cart_items where cartid = 2

--Update kayleigh cart to cause purchase and store in invoice
Update cart set cartid = 6 where cartid = 2;

-- Check trigger worked for kayleigh's invoice
select * from invoice where accountid = 2

--Check invoice products purchased
select * from invoice_products where invoiceid = 1

select * from product
--Create a review for Kayleigh
INSERT into reviews Values(2, 11, 20, 5, 9, 4, 'True to Size', 'Yes');

--Check Kayleigh's reviews
select age, feet ||' foot '|| inches as height, rating ||''|| ' out of 5' as Overall_Rating, sizedesc, recommend from reviews where accountid = 2;

--Check all reviews for a product
select age, feet ||' foot '|| inches as height, rating ||''|| ' out of 5' as Overall_Rating, sizedesc, recommend from reviews where productid = 14;

--Select statement to show items in Kayleigh's Cart
select Pname, ProductID Psize, Pquantity, Price from cart_items NATURAL JOIN product where cartID = 2;

--Cart total price, number of items, number of different types of products
select SUM(Price) as Total_Price, SUM(pquantity) as Total_Quantity_of_Items, COUNT( DISTINCT ProductID) as Product_Variety 
FROM cart_items NATURAL JOIN product 
where CartID = 2;

-- Remove item from Kayleigh's cart
DELETE FROM cart_items where cartid = 2 AND productID = 3;

-- Add to favorites
INSERT INTO favorites VALUES(2, 2);
INSERT INTO favorites VALUES(2, 5);

-- Shows Kayleigh's favorited items
SELECT pname, ptype, productid, price FROM favorites NATURAL JOIN product WHERE accountid = 2;

--Delete Kayleigh's account 
delete from customer where accountid = 2

-------------------------------------------------------------------------------------------

--CAMRYN ACCOUNT 

--create account 
INSERT into customer VALUES(seqID.nextVal, 'Camryn', 'Taylor', 'camtaylor245@gmail.com', '12312345');

-------------------------------------------------------------------------------------------

--CAITLIN ACCOUNT 

--create account with account number 8
 INSERT into customer VALUES(seqID.nextVal, 'Caitlin', 'van Goeverden', 'cvg@gmail.com', '4562348908');
 --Add address
 INSERT INTO address VALUES(8, '250 Spring Mill Road', 'Villanova', 'PA', '19085');

 --add payment methods
 INSERT into payment Values(8, 3, 2025, '3456789089867654', '556');
 INSERT into payment Values(8, 9, 2023, '3748536394756382', '002');

 -- View Caitlin's address options
 SELECT Street ||' '|| City ||' '|| State ||' '|| Zip as Addresses 
 FROM address 
 WHERE accountID = 8;

 --view Caitlin's payment options
 select expMonth ||'/'|| expYear AS Expiration_Date, '************'||''||SUBSTR(cardnumber, 12, 4) AS Card_Number 
 FROM payment WHERE accountID = 8;

 -- Add items to cart
 INSERT INTO cart_items VALUES(8, 2, 'small', 1, 49.95);
 INSERT INTO cart_items VALUES(8, 201, 'small', 1, 19.95);
 INSERT INTO cart_items VALUES(8, 184, 'medium', 2, 25);
 
 SELECT * from cart_items where cartid =8;

-- total price of cart 
select sum(c.price*c.pquantity) from cart_items c where cartid =8;

--see product review 

select age, feet ||' foot '|| inches as height, rating ||''|| ' out of 5' as Overall_Rating, sizedesc, recommend from reviews where productid = 2;
 
DELETE FROM cart_items where cartid =8 and productid = 201;

UPDATE cart_items set pquantity = 3 where cartid = 8 and productid = 2;
UPDATE cart_items set psize = 'medium' where cartid = 8 and productid = 184;

--place order

UPDATE cart set cartid = 8 where cartid = 8;

-- view invoice history 

select * from invoice where accountid =8;

--view invoice products 
select i.invoiceid, p.pname, ip.psize, ip.pquanity, p.price 
from invoice_products ip join invoice i on ip.invoiceid = i.invoiceid join product p on p.productid = ip.productid 
where i.accountid = 8
order by i.invoiceid;
 
--add review
INSERT into reviews Values(8, 2, 22, 5, 4, 4, 'small', 'Yes');

--add items to Caitlin's favorites / get all favorited items 

INSERT into favorites Values(8,2);
INSERT into favorites Values(8, 201);

SELECT pname, ptype, productid, price FROM favorites NATURAL JOIN product WHERE accountid = 8;

--delete Caitlin's account
Delete from customer where accountid = 8;

--invoice history should still be found
select ird.fname, ird.lname, ird.invoiceid from invoice_record_deleted_account ird where fname = 'Caitlin' and lname = 'van Goeverden'; 

-------------------------------------------------------------------------------------------
--Additional Accounts

INSERT into customer VALUES(seqID.nextVal, 'Mary', 'Smith', 'Mary234@icloud.com', '1923347659');

--Sarah's Account
INSERT into customer VALUES(seqID.nextVal, 'Sarah', 'Jones', 'Sjones@me.com', '3274828342');

INSERT into payment Values(5, 4, 2025, '1111222233334444', '012');
INSERT into payment Values(5, 9, 2032, '1234123412341234', '914');

--View Sarah's payment options
select expMonth ||'/'|| expYear AS Expiration_Date, '************'||''||SUBSTR(cardnumber, 12, 4) AS Card_Number 
FROM payment 
WHERE accountID = 5;

--View How many forms of payment Sarah has
select count(cardnumber) as Number_of_payments from payment where accountid = 5

--Sarah's addresses
INSERT into address Values(5, '398 Brick Road', 'Tampa', 'FL', '25013');
INSERT into address Values(5, '511 Greenwich Ave', 'New York', 'NY', '82315');

-- View Sarah's addresses
SELECT Street ||' '|| City ||' '|| State ||' '|| Zip as Addresses 
FROM address 
WHERE accountID = 5;

-- Add items to cart 
INSERT into cart_items Values(5, 6, 'small', 1, 14.95);
INSERT into cart_items Values(5, 1, 'medium', 2, 39.90);

-- View cart items
select * from cart_items where cartid = 4;

