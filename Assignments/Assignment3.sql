SELECT * FROM dbo.Jomato;


-- 1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not null).
CREATE PROCEDURE Display_Details
	AS
		SELECT RestaurantName, RestaurantType, CuisinesType
		FROM dbo.Jomato
		WHERE TableBooking is NOT NULL

EXECUTE Display_Details;

-- 2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.
BEGIN TRANSACTION
	UPDATE dbo.Jomato
	SET RestaurantType = 'Cafeteria'
	WHERE RestaurantType = 'Cafe';

	SELECT * FROM dbo.Jomato;

	ROLLBACK;

-- 3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.
SELECT distinct top 5 ROW_NUMBER() OVER (ORDER BY Rating desc) as rankNumber,
Area, Rating
FROM dbo.Jomato

-- 4. Use the while loop to display to the 1 to 50
declare @counter int
set @counter = 1
while @counter <= 50
	begin 
		print @counter
		set @counter = @counter + 1
	end

-- 5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.
create view Top_Rating as
SELECT Top 5 * from dbo.Jomato
order by rating desc;

SELECT * FROM Top_Rating;


-- 6. Create a trigger that give an message whenever a new record is inserted
CREATE TRIGGER insert_trigger 
ON dbo.Jomato
AFTER INSERT
AS
BEGIN 
	print 'New Record inserted'
END;

-- Testing trigger 
Insert into dbo.Jomato
values(7105,'L-81 Cafe', 'Quick Bites', 3.90000009536743, 48, 400,'Yes',0,'Fast Food, Beverages','Byresandra,Tavarekere,Madiwala',	'HSR',	59,	'Good')

select * from dbo.Jomato;