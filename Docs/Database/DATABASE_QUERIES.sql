USE mydb;

/*
*****************************
CUSTOMER QUERIES
*****************************
*/


/*
Customer cart view

need to replace CART_ID with ID
generated from cart selection in the customer cart view
*/
SELECT ITEM_NAME, DESCRIPTION_ITEM, PRICE
FROM MENU
JOIN ITEMS_MENU USING (MENU_ID)
JOIN ITEMS USING (ITEM_ID)
JOIN CART USING (MENU_ID)
WHERE CART_ID = 1
ORDER BY CART_ID
;

/*
Add item popup insert query

Requires Name, category, cost, and description (optional)
Uses sample data, replace with formatted JS strings `${}`

`INSERT INTO ITEMS(ITEM_NAME, ITEM CATEGORY, PRICE)
	VALUES	(${newItem}, ${category}, ${price}, ${description})
;`

*/

INSERT INTO ITEMS (ITEM_NAME, ITEM_CATEGORY, PRICE, DESCRIPTION_ITEM)
	VALUES	("New Food Item", "Food", 2.49, "This is the latest and greatest new item")
;

/*
*****************************
ADMIN QUERIES
*****************************
*/

/*
Add new Cart

`INSERT INTO CART(LOCATION, MENU_ID)
VALUES 	(${lat},${long}, ${menuId})
;`

*/

INSERT INTO CART(LOCATION, MENU_ID)
VALUES 	("47.6828977,-122.3917439", 1)
;

/*
Add account
`INSERT INTO USERS (EMAIL, PASSWORD, FIRST_NAME, LAST_NAME, PERMISSION)
VALUES 	(${userID}, ${password}, ${firstName}, ${lastName}, ${permission})
;`

*/
INSERT INTO USERS (EMAIL, PASSWORD, FIRST_NAME, LAST_NAME, PERMISSION)
VALUES 	("userId", "pass", "firstName", "lastName", "CUSTOMER")
;

/*
*****************************
LOGGING QUERIES
*****************************
*/

-- Get ID of latest log item
SELECT LOG_ITEM_ID
FROM LOG
ORDER BY LOG_ITEM_ID DESC
LIMIT 1;

/*
*****************************
OTHER QUERIES
*****************************
*/

-- show menu's and available items
SELECT * FROM MENU
JOIN ITEMS_MENU USING (MENU_ID)
JOIN ITEMS USING (ITEM_ID)
WHERE MENU_ID = 1
ORDER BY MENU_ID;

-- show history of user actions
SELECT * FROM USERS
JOIN USER_LOGS USING (USER_ID)
JOIN LOG USING (LOG_ITEM_ID);

-- show items odrdered by users
select FIRST_NAME AS `First Name`, LAST_NAME AS `Last Name`, ITEM_NAME AS `Item`, PRICE, DATE
FROM USERS
JOIN ORDER_USERS USING (USER_ID)
JOIN ORDERS USING (ORDER_ID)
JOIN ORDERS_ITEMS USING (ORDER_ID)
JOIN ITEMS USING (ITEM_ID)
JOIN CART_ORDERS USING (ORDER_ID)
JOIN CART USING (CART_ID)
WHERE CART_ID = 1
ORDER BY DATE
;
