-- 1. ��������� ����� � �������
-- ��������� �볺���
INSERT INTO Clients (FirstName, LastName, Email, PhoneNumber, DateOfBirth, PassportNumber, Address) 
VALUES 
('����', '��������', 'ivan.petrenko@gmail.com', '+380631234567', '1985-02-15', 'AA1234567', '���. ��������, 12, ���'),
('����', '���������', 'maria.kovalenko@gmail.com', '+380671234567', '1990-06-25', 'BB2345678', '���. ��� �������, 5, ����');

-- ��������� ������������
INSERT INTO Admins (FirstName, LastName, Email, PhoneNumber)
VALUES 
('���������', '���������', 'alex.kravchenko@agency.com', '+380981234567');

-- ��������� ���� ����������
INSERT INTO TransportTypes (TransportName, Description)
VALUES 
('˳���', '������ �� ����� ������'),
('�������', '������� �� ������ ������');

-- ��������� ������
INSERT INTO Hotels (HotelName, Location, StarRating, Description, ContactInfo)
VALUES 
('Hotel Paradise', '�����, �������', 5, '�������� ������ � ����� ������', '+33123456789');

-- ��������� �����
INSERT INTO Countries (CountryName, CountryCode)
VALUES 
('�������', 'FR'),
('������', 'UA');

-- ��������� ����
INSERT INTO Cities (CityName, CountryID, Population)
VALUES 
('���', 2, 3000000),
('�����', 1, 2161000);

-- ��������� ����
INSERT INTO Tours (TourName, DurationDays, Price, StartDate, EndDate, CityID, CountryID, HotelID)
VALUES 
('����������� �����', 5, 1200.50, '2025-02-01', '2025-02-05', 2, 1, 1);

-- ��������� ����������
INSERT INTO Orders (ClientID, AdminID, TourID, TransportID, TotalPrice, Notes)
VALUES 
(1, 1, 1, 1, 1300.50, '��������� ���� ��� ������');

-- 2. ������ �����
-- ���� ��� �볺���
SELECT * FROM Clients;

-- ���� ���� � ����� ����� 1000
SELECT * 
FROM Tours 
WHERE Price > 1000;

-- ���� ��������� � �������� "Pending"
SELECT * 
FROM Orders 
WHERE Status = 'Pending';

-- ���� ����, �� ����������� � ������ 2025
SELECT * 
FROM Tours 
WHERE StartDate BETWEEN '2025-02-01' AND '2025-02-28';

-- ���� ��������� ����� �� ������ ��� �볺��� �� ���
SELECT 
    O.OrderID, 
    C.FirstName + ' ' + C.LastName AS ClientName, 
    T.TourName, 
    O.TotalPrice, 
    O.Status 
FROM Orders O
JOIN Clients C ON O.ClientID = C.ClientID
JOIN Tours T ON O.TourID = T.TourID;

--3. ��������� �����
-- ��������� ������� ����������
UPDATE Orders
SET Status = 'Confirmed'
WHERE OrderID = 7;

-- ��������� ��������� ���������� �볺���
UPDATE Clients
SET PhoneNumber = '+380661234567'
WHERE ClientID = 1;

-- ��������� ���� ����
UPDATE Tours
SET Price = 1100.00
WHERE TourID = 1;

--4. ��������� �����
-- ��������� �볺���
DELETE FROM Clients
WHERE ClientID = 2;

-- ��������� ����
DELETE FROM Tours
WHERE TourID = 2;

-- ��������� ����������
DELETE FROM Orders
WHERE OrderID = 1;

--5. ������ � ����������� ���������
-- ʳ������ �볺���
SELECT COUNT(*) AS ClientCount 
FROM Clients;

-- ������� ���� ����
SELECT AVG(Price) AS AveragePrice 
FROM Tours;

-- �������� ���� ��� ���������
SELECT SUM(TotalPrice) AS TotalRevenue 
FROM Orders;

-- ����������� ���� ����
SELECT MAX(Price) AS MaxPrice 
FROM Tours;

-- 6. ������ � �����������
-- ʳ������ ��������� �� ��������
SELECT Status, COUNT(*) AS OrderCount
FROM Orders
GROUP BY Status;

---- ������� ���� ���� �� ������
SELECT Co.CountryName, AVG(T.Price) AS AverageTourPrice
FROM Tours T
JOIN Countries Co ON T.CountryID = Co.CountryID
GROUP BY Co.CountryName;
