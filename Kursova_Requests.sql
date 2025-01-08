-- 1. Додавання даних у таблиці
-- Додавання клієнта
INSERT INTO Clients (FirstName, LastName, Email, PhoneNumber, DateOfBirth, PassportNumber, Address) 
VALUES 
('Іван', 'Петренко', 'ivan.petrenko@gmail.com', '+380631234567', '1985-02-15', 'AA1234567', 'вул. Шевченка, 12, Київ'),
('Марія', 'Коваленко', 'maria.kovalenko@gmail.com', '+380671234567', '1990-06-25', 'BB2345678', 'вул. Лесі Українки, 5, Львів');

-- Додавання адміністратора
INSERT INTO Admins (FirstName, LastName, Email, PhoneNumber)
VALUES 
('Олександр', 'Кравченко', 'alex.kravchenko@agency.com', '+380981234567');

-- Додавання виду транспорту
INSERT INTO TransportTypes (TransportName, Description)
VALUES 
('Літак', 'Переліт на далекі відстані'),
('Автобус', 'Подорож на короткі відстані');

-- Додавання готелю
INSERT INTO Hotels (HotelName, Location, StarRating, Description, ContactInfo)
VALUES 
('Hotel Paradise', 'Париж, Франція', 5, 'Розкішний готель у центрі Парижа', '+33123456789');

-- Додавання країни
INSERT INTO Countries (CountryName, CountryCode)
VALUES 
('Франція', 'FR'),
('Україна', 'UA');

-- Додавання міста
INSERT INTO Cities (CityName, CountryID, Population)
VALUES 
('Київ', 2, 3000000),
('Париж', 1, 2161000);

-- Додавання туру
INSERT INTO Tours (TourName, DurationDays, Price, StartDate, EndDate, CityID, CountryID, HotelID)
VALUES 
('Романтичний Париж', 5, 1200.50, '2025-02-01', '2025-02-05', 2, 1, 1);

-- Додавання замовлення
INSERT INTO Orders (ClientID, AdminID, TourID, TransportID, TotalPrice, Notes)
VALUES 
(1, 1, 1, 1, 1300.50, 'Додаткове місце для багажу');

-- 2. Вибірка даних
-- Вибір всіх клієнтів
SELECT * FROM Clients;

-- Вибір турів з ціною більше 1000
SELECT * 
FROM Tours 
WHERE Price > 1000;

-- Вибір замовлень зі статусом "Pending"
SELECT * 
FROM Orders 
WHERE Status = 'Pending';

-- Вибір турів, які починаються у лютому 2025
SELECT * 
FROM Tours 
WHERE StartDate BETWEEN '2025-02-01' AND '2025-02-28';

-- Вибір замовлень разом із даними про клієнта та тур
SELECT 
    O.OrderID, 
    C.FirstName + ' ' + C.LastName AS ClientName, 
    T.TourName, 
    O.TotalPrice, 
    O.Status 
FROM Orders O
JOIN Clients C ON O.ClientID = C.ClientID
JOIN Tours T ON O.TourID = T.TourID;

--3. Оновлення даних
-- Оновлення статусу замовлення
UPDATE Orders
SET Status = 'Confirmed'
WHERE OrderID = 7;

-- Оновлення контактної інформації клієнта
UPDATE Clients
SET PhoneNumber = '+380661234567'
WHERE ClientID = 1;

-- Оновлення ціни туру
UPDATE Tours
SET Price = 1100.00
WHERE TourID = 1;

--4. Видалення даних
-- Видалення клієнта
DELETE FROM Clients
WHERE ClientID = 2;

-- Видалення туру
DELETE FROM Tours
WHERE TourID = 2;

-- Видалення замовлення
DELETE FROM Orders
WHERE OrderID = 1;

--5. Запити з агрегатними функціями
-- Кількість клієнтів
SELECT COUNT(*) AS ClientCount 
FROM Clients;

-- Середня ціна турів
SELECT AVG(Price) AS AveragePrice 
FROM Tours;

-- Загальна сума всіх замовлень
SELECT SUM(TotalPrice) AS TotalRevenue 
FROM Orders;

-- Максимальна ціна туру
SELECT MAX(Price) AS MaxPrice 
FROM Tours;

-- 6. Запити з групуванням
-- Кількість замовлень за статусом
SELECT Status, COUNT(*) AS OrderCount
FROM Orders
GROUP BY Status;

---- Середня ціна туру по країнах
SELECT Co.CountryName, AVG(T.Price) AS AverageTourPrice
FROM Tours T
JOIN Countries Co ON T.CountryID = Co.CountryID
GROUP BY Co.CountryName;
