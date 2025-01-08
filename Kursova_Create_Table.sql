-- Створення бази даних
CREATE DATABASE TravelAgencyDB;
GO

-- Переключення на створену базу даних
USE TravelAgencyDB;
GO

-- Створення таблиці клієнтів
CREATE TABLE Clients (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,      -- Унікальний ідентифікатор клієнта
    FirstName NVARCHAR(50) NOT NULL,             -- Ім'я клієнта
    LastName NVARCHAR(50) NOT NULL,              -- Прізвище клієнта
    Email NVARCHAR(100) NOT NULL UNIQUE,         -- Email клієнта (унікальний)
    PhoneNumber NVARCHAR(15),                    -- Номер телефону
    DateOfBirth DATE,                            -- Дата народження
    PassportNumber NVARCHAR(20),                 -- Номер паспорта (для міжнародних подорожей)
    Address NVARCHAR(255),                       -- Адреса клієнта
    DateAdded DATETIME DEFAULT GETDATE()         -- Дата додавання клієнта до бази
);
GO

-- Створення таблиці працівників (адміністраторів)
CREATE TABLE Admins (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,       -- Унікальний ідентифікатор працівника
    FirstName NVARCHAR(50) NOT NULL,            -- Ім'я працівника
    LastName NVARCHAR(50) NOT NULL,             -- Прізвище працівника
    Email NVARCHAR(100) NOT NULL UNIQUE,        -- Email працівника (унікальний)
    PhoneNumber NVARCHAR(15),                   -- Номер телефону
);
GO

-- Створення таблиці видів транспорту
CREATE TABLE TransportTypes (
    TransportID INT IDENTITY(1,1) PRIMARY KEY,  -- Унікальний ідентифікатор транспорту
    TransportName NVARCHAR(50) NOT NULL UNIQUE, -- Назва виду транспорту (наприклад, літак, автобус)
    Description NVARCHAR(255),                  -- Опис транспорту (за бажанням)
    DateAdded DATETIME DEFAULT GETDATE()        -- Дата додавання запису до бази
);
GO

-- Створення таблиці готелів
CREATE TABLE Hotels (
    HotelID INT IDENTITY(1,1) PRIMARY KEY,         -- Унікальний ідентифікатор готелю
    HotelName NVARCHAR(100) NOT NULL,              -- Назва готелю
    Location NVARCHAR(255) NOT NULL,               -- Місце розташування (місто, країна)
    StarRating INT CHECK (StarRating BETWEEN 1 AND 5), -- Рейтинг готелю (1-5 зірок)
    Description NVARCHAR(MAX),                     -- Опис готелю
    ContactInfo NVARCHAR(255),                     -- Контактна інформація готелю
    DateAdded DATETIME DEFAULT GETDATE()           -- Дата додавання запису
);
GO

-- Створення таблиці країн
CREATE TABLE Countries (
    CountryID INT IDENTITY(1,1) PRIMARY KEY,     -- Унікальний ідентифікатор країни
    CountryName NVARCHAR(100) NOT NULL UNIQUE,  -- Назва країни (унікальна)
    CountryCode NVARCHAR(10) UNIQUE,            -- Код країни (наприклад, UA, US)
);
GO

-- Створення таблиці міст
CREATE TABLE Cities (
    CityID INT IDENTITY(1,1) PRIMARY KEY,       -- Унікальний ідентифікатор міста
    CityName NVARCHAR(100) NOT NULL,            -- Назва міста
    CountryID INT NOT NULL,                     -- Ідентифікатор країни (зовнішній ключ)
    Population INT,                             -- Населення міста (за бажанням)
    CONSTRAINT FK_Cities_Countries FOREIGN KEY (CountryID) REFERENCES Countries(CountryID) 
        ON DELETE CASCADE                       -- Видалення країни видаляє її міста
);
GO

-- Створення таблиці турів
CREATE TABLE Tours (
    TourID INT IDENTITY(1,1) PRIMARY KEY,               -- Унікальний ідентифікатор туру
    TourName NVARCHAR(100) NOT NULL,                    -- Назва туру
    DurationDays INT NOT NULL,                          -- Тривалість туру в днях
    Price DECIMAL(10, 2) NOT NULL,                      -- Ціна туру
    StartDate DATETIME NOT NULL,                        -- Дата початку туру
    EndDate DATETIME NOT NULL,                          -- Дата закінчення туру
    CityID INT NOT NULL,                                -- Ідентифікатор міста (зовнішній ключ)
    CountryID INT NOT NULL,                             -- Ідентифікатор країни (зовнішній ключ)
    HotelID INT NULL,                                   -- Ідентифікатор готелю (зовнішній ключ)
    DateAdded DATETIME DEFAULT GETDATE(),               -- Дата додавання туру
    CONSTRAINT FK_Tours_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID),   -- Зв'язок з таблицею міст
    CONSTRAINT FK_Tours_Countries FOREIGN KEY (CountryID) REFERENCES Countries(CountryID), -- Зв'язок з таблицею країн
    CONSTRAINT FK_Tours_Hotels FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)   -- Зв'язок з таблицею готелів
);
GO

-- Створення таблиці замовлень
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,       -- Унікальний ідентифікатор замовлення
    ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID), -- Клієнт
    AdminID INT NOT NULL FOREIGN KEY REFERENCES Admins(AdminID),    -- Адміністратор, який створив замовлення
    TourID INT NOT NULL FOREIGN KEY REFERENCES Tours(TourID),       -- Тур
    TransportID INT NOT NULL FOREIGN KEY REFERENCES TransportTypes(TransportID), -- Транспорт
    OrderDate DATETIME DEFAULT GETDATE(),       -- Дата створення замовлення
    TotalPrice DECIMAL(10, 2) NOT NULL,         -- Загальна вартість замовлення
    Status NVARCHAR(50) DEFAULT 'Pending',      -- Статус замовлення (Pending, Confirmed, Canceled)
    Notes NVARCHAR(MAX),                        -- Додаткові нотатки
    DateModified DATETIME DEFAULT GETDATE()     -- Дата останньої модифікації замовлення
);
GO
