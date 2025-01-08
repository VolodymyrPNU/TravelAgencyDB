-- ��������� ���� �����
CREATE DATABASE TravelAgencyDB;
GO

-- ������������ �� �������� ���� �����
USE TravelAgencyDB;
GO

-- ��������� ������� �볺���
CREATE TABLE Clients (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,      -- ��������� ������������� �볺���
    FirstName NVARCHAR(50) NOT NULL,             -- ��'� �볺���
    LastName NVARCHAR(50) NOT NULL,              -- ������� �볺���
    Email NVARCHAR(100) NOT NULL UNIQUE,         -- Email �볺��� (���������)
    PhoneNumber NVARCHAR(15),                    -- ����� ��������
    DateOfBirth DATE,                            -- ���� ����������
    PassportNumber NVARCHAR(20),                 -- ����� �������� (��� ���������� ���������)
    Address NVARCHAR(255),                       -- ������ �볺���
    DateAdded DATETIME DEFAULT GETDATE()         -- ���� ��������� �볺��� �� ����
);
GO

-- ��������� ������� ���������� (������������)
CREATE TABLE Admins (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,       -- ��������� ������������� ����������
    FirstName NVARCHAR(50) NOT NULL,            -- ��'� ����������
    LastName NVARCHAR(50) NOT NULL,             -- ������� ����������
    Email NVARCHAR(100) NOT NULL UNIQUE,        -- Email ���������� (���������)
    PhoneNumber NVARCHAR(15),                   -- ����� ��������
);
GO

-- ��������� ������� ���� ����������
CREATE TABLE TransportTypes (
    TransportID INT IDENTITY(1,1) PRIMARY KEY,  -- ��������� ������������� ����������
    TransportName NVARCHAR(50) NOT NULL UNIQUE, -- ����� ���� ���������� (���������, ����, �������)
    Description NVARCHAR(255),                  -- ���� ���������� (�� ��������)
    DateAdded DATETIME DEFAULT GETDATE()        -- ���� ��������� ������ �� ����
);
GO

-- ��������� ������� ������
CREATE TABLE Hotels (
    HotelID INT IDENTITY(1,1) PRIMARY KEY,         -- ��������� ������������� ������
    HotelName NVARCHAR(100) NOT NULL,              -- ����� ������
    Location NVARCHAR(255) NOT NULL,               -- ̳��� ������������ (����, �����)
    StarRating INT CHECK (StarRating BETWEEN 1 AND 5), -- ������� ������ (1-5 ����)
    Description NVARCHAR(MAX),                     -- ���� ������
    ContactInfo NVARCHAR(255),                     -- ��������� ���������� ������
    DateAdded DATETIME DEFAULT GETDATE()           -- ���� ��������� ������
);
GO

-- ��������� ������� ����
CREATE TABLE Countries (
    CountryID INT IDENTITY(1,1) PRIMARY KEY,     -- ��������� ������������� �����
    CountryName NVARCHAR(100) NOT NULL UNIQUE,  -- ����� ����� (��������)
    CountryCode NVARCHAR(10) UNIQUE,            -- ��� ����� (���������, UA, US)
);
GO

-- ��������� ������� ���
CREATE TABLE Cities (
    CityID INT IDENTITY(1,1) PRIMARY KEY,       -- ��������� ������������� ����
    CityName NVARCHAR(100) NOT NULL,            -- ����� ����
    CountryID INT NOT NULL,                     -- ������������� ����� (������� ����)
    Population INT,                             -- ��������� ���� (�� ��������)
    CONSTRAINT FK_Cities_Countries FOREIGN KEY (CountryID) REFERENCES Countries(CountryID) 
        ON DELETE CASCADE                       -- ��������� ����� ������� �� ����
);
GO

-- ��������� ������� ����
CREATE TABLE Tours (
    TourID INT IDENTITY(1,1) PRIMARY KEY,               -- ��������� ������������� ����
    TourName NVARCHAR(100) NOT NULL,                    -- ����� ����
    DurationDays INT NOT NULL,                          -- ��������� ���� � ����
    Price DECIMAL(10, 2) NOT NULL,                      -- ֳ�� ����
    StartDate DATETIME NOT NULL,                        -- ���� ������� ����
    EndDate DATETIME NOT NULL,                          -- ���� ��������� ����
    CityID INT NOT NULL,                                -- ������������� ���� (������� ����)
    CountryID INT NOT NULL,                             -- ������������� ����� (������� ����)
    HotelID INT NULL,                                   -- ������������� ������ (������� ����)
    DateAdded DATETIME DEFAULT GETDATE(),               -- ���� ��������� ����
    CONSTRAINT FK_Tours_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID),   -- ��'���� � �������� ���
    CONSTRAINT FK_Tours_Countries FOREIGN KEY (CountryID) REFERENCES Countries(CountryID), -- ��'���� � �������� ����
    CONSTRAINT FK_Tours_Hotels FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)   -- ��'���� � �������� ������
);
GO

-- ��������� ������� ���������
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,       -- ��������� ������������� ����������
    ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID), -- �볺��
    AdminID INT NOT NULL FOREIGN KEY REFERENCES Admins(AdminID),    -- �����������, ���� ������� ����������
    TourID INT NOT NULL FOREIGN KEY REFERENCES Tours(TourID),       -- ���
    TransportID INT NOT NULL FOREIGN KEY REFERENCES TransportTypes(TransportID), -- ���������
    OrderDate DATETIME DEFAULT GETDATE(),       -- ���� ��������� ����������
    TotalPrice DECIMAL(10, 2) NOT NULL,         -- �������� ������� ����������
    Status NVARCHAR(50) DEFAULT 'Pending',      -- ������ ���������� (Pending, Confirmed, Canceled)
    Notes NVARCHAR(MAX),                        -- �������� �������
    DateModified DATETIME DEFAULT GETDATE()     -- ���� �������� ����������� ����������
);
GO
