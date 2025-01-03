USE [master]
GO
/****** Object:  Database [tradedb]    Script Date: 12/26/2024 2:38:40 PM ******/
CREATE DATABASE [tradedb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tradedb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\tradedb.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tradedb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\tradedb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [tradedb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tradedb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tradedb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tradedb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tradedb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tradedb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tradedb] SET ARITHABORT OFF 
GO
ALTER DATABASE [tradedb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tradedb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tradedb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tradedb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tradedb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tradedb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tradedb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tradedb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tradedb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tradedb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tradedb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tradedb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tradedb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tradedb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tradedb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tradedb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tradedb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tradedb] SET RECOVERY FULL 
GO
ALTER DATABASE [tradedb] SET  MULTI_USER 
GO
ALTER DATABASE [tradedb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tradedb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tradedb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tradedb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [tradedb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [tradedb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'tradedb', N'ON'
GO
ALTER DATABASE [tradedb] SET QUERY_STORE = ON
GO
ALTER DATABASE [tradedb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [tradedb]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 12/26/2024 2:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](30) NOT NULL,
	[DeliveryDate] [date] NOT NULL,
	[UserId] [int] NULL,
	[PickupPointId] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Order__C3905BAFEA8B9369] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 12/26/2024 2:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[OrderId] [int] NOT NULL,
	[ProductArticleNumber] [nvarchar](30) NOT NULL,
	[Amount] [int] NOT NULL,
 CONSTRAINT [PK__OrderPro__817A2662651DFEFA] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PickupPoint]    Script Date: 12/26/2024 2:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PickupPoint](
	[PickupPointId] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[ZipCode] [int] NOT NULL,
 CONSTRAINT [PK_PickupPoint] PRIMARY KEY CLUSTERED 
(
	[PickupPointId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/26/2024 2:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductArticleNumber] [nvarchar](30) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[Category] [nvarchar](20) NOT NULL,
	[Photo] [image] NULL,
	[Manufacturer] [nvarchar](20) NOT NULL,
	[Cost] [decimal](19, 4) NOT NULL,
	[DiscountAmount] [tinyint] NULL,
	[QuantityInStock] [int] NOT NULL,
	[Status] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK__Product__2EA7DCD53CA7D863] PRIMARY KEY CLUSTERED 
(
	[ProductArticleNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 12/26/2024 2:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK__Role__8AFACE3A9C95F12A] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 12/26/2024 2:38:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](50) NOT NULL,
	[Login] [nvarchar](30) NOT NULL,
	[Password] [nvarchar](30) NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK__User__1788CCAC29940AA2] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (1, N'Новый ', CAST(N'2022-05-10' AS Date), 1, 24, CAST(N'2022-05-04' AS Date), N'201')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (2, N'Новый ', CAST(N'2022-05-11' AS Date), NULL, 25, CAST(N'2022-05-05' AS Date), N'202')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (3, N'Новый ', CAST(N'2022-05-12' AS Date), 2, 26, CAST(N'2022-05-06' AS Date), N'203')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (4, N'Новый ', CAST(N'2022-05-13' AS Date), NULL, 27, CAST(N'2022-05-07' AS Date), N'204')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (5, N'Новый ', CAST(N'2022-05-14' AS Date), 3, 28, CAST(N'2022-05-08' AS Date), N'205')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (6, N'Новый ', CAST(N'2022-05-15' AS Date), NULL, 29, CAST(N'2022-05-09' AS Date), N'206')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (7, N'Новый ', CAST(N'2022-05-16' AS Date), NULL, 30, CAST(N'2022-05-10' AS Date), N'207')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (8, N'Новый ', CAST(N'2022-05-17' AS Date), NULL, 31, CAST(N'2022-05-11' AS Date), N'208')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (9, N'Новый ', CAST(N'2022-05-18' AS Date), 4, 32, CAST(N'2022-05-12' AS Date), N'209')
INSERT [dbo].[Order] ([OrderId], [Status], [DeliveryDate], [UserId], [PickupPointId], [OrderDate], [Code]) VALUES (10, N'Завершен', CAST(N'2022-05-19' AS Date), NULL, 33, CAST(N'2022-05-13' AS Date), N'210')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (1, N'F893T5', 2)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (1, N'А112Т4', 2)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (2, N'E530Y6', 1)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (2, N'F346G5', 2)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (3, N'D344Y7', 2)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (3, N'J432E4', 1)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (4, N'D378D3', 2)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (4, N'E245R5', 1)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (5, N'H732R5', 3)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (5, N'R464G6', 2)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (6, N'E573G6', 3)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (6, N'K535G6', 3)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (7, N'F344S4', 6)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (7, N'G532R5', 5)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (8, N'D526R4', 5)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (8, N'S753T5', 4)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (9, N'A436H7', 3)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (9, N'V472S3', 3)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (10, N'E479G6', 1)
INSERT [dbo].[OrderProduct] ([OrderId], [ProductArticleNumber], [Amount]) VALUES (10, N'O875F6', 4)
GO
SET IDENTITY_INSERT [dbo].[PickupPoint] ON 

INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (1, N' г. Ангарск, ул. Чехова, 1', 344288)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (2, N' г.Ангарск,  ул. Степная, 30', 614164)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (3, N' г. Ангарск, ул. Коммунистическая, 43', 394242)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (4, N' г. Ангарск, ул. Солнечная, 25', 660540)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (5, N' г. Ангарск, ул. Шоссейная, 40', 125837)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (6, N' г. Ангарск, ул. Партизанская, 49', 125703)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (7, N' г. Ангарск, ул. Победы, 46', 625283)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (8, N' г. Ангарск, ул. Молодежная, 50', 614611)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (9, N' г.Ангарск, ул. Новая, 19', 454311)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (10, N' г.Ангарск, ул. Октябрьская, 19', 660007)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (11, N' г. Ангарск, ул. Садовая, 4', 603036)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (12, N' г.Ангарск, ул. Комсомольская, 26', 450983)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (13, N' г. Ангарск, ул. Чехова, 3', 394782)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (14, N' г. Ангарск, ул. Дзержинского, 28', 603002)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (15, N' г. Ангарск, ул. Набережная, 30', 450558)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (16, N' г.Ангарск, ул. Фрунзе, 43', 394060)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (17, N' г. Ангарск, ул. Школьная, 50', 410661)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (18, N' г. Ангарск, ул. Коммунистическая, 20', 625590)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (19, N' г. Ангарск, ул. 8 Марта', 625683)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (20, N' г. Ангарск, ул. Зеленая, 32', 400562)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (21, N' г. Ангарск, ул. Маяковского, 47', 614510)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (22, N' г. Ангарск, ул. Светлая, 46', 410542)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (23, N' г. Ангарск, ул. Цветочная, 8', 620839)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (24, N' г. Ангарск, ул. Коммунистическая, 1', 443890)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (25, N' г. Ангарск, ул. Спортивная, 46', 603379)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (26, N' г. Ангарск, ул. Гоголя, 41', 603721)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (27, N' г. Ангарск, ул. Северная, 13', 410172)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (28, N' г. Ангарск, ул. Вишневая, 32', 420151)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (29, N' г. Ангарск, ул. Подгорная, 8', 125061)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (30, N' г. Ангарск, ул. Шоссейная, 24', 630370)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (31, N' г. Ангарск, ул. Полевая, 35', 614753)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (32, N' г. Ангарск, ул. Маяковского, 44', 426030)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (33, N' г. Ангарск ул. Клубная, 44', 450375)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (34, N' г. Ангарск, ул. Некрасова, 12', 625560)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (35, N' г. Ангарск, ул. Комсомольская, 17', 630201)
INSERT [dbo].[PickupPoint] ([PickupPointId], [Address], [ZipCode]) VALUES (36, N' г. Ангарск, ул. Мичурина, 26', 190949)
SET IDENTITY_INSERT [dbo].[PickupPoint] OFF
GO
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'A436H7', N'Opulent Aura', N'long-lasting matte lipstick', N'perfume', NULL, N'Cosmic Scents', CAST(4675.0000 AS Decimal(19, 4)), 0, 50, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'D344Y7', N'Luminous Glow', N'hydrating facial serum', N'perfume', NULL, N'Cosmic Scents', CAST(256.0000 AS Decimal(19, 4)), 37, 42, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'D378D3', N'Luminous Glow', N'hydrating facial serum', N'perfume', NULL, N'Cosmic Scents', CAST(256.0000 AS Decimal(19, 4)), 37, 42, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'D526R4', N'Radiant Bloom', N'elegant rose perfume', N'perfume', NULL, N'Cosmic Scents', CAST(4733.0000 AS Decimal(19, 4)), 0, 2, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'E245R5', N'Silk Whispers', N'floral and fruity scent', N'cosmetic', NULL, N'Stellar Cosmetics', CAST(1546.0000 AS Decimal(19, 4)), 0, 17, N'In stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'E479G6', N'Silk Whispers', N'elegant rose perfume', N'perfume', NULL, N'Celestial Fragrances', CAST(2185.0000 AS Decimal(19, 4)), 68, 25, N'In stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'E530Y6', N'Velvet Elegance', N'elegant rose perfume', N'cosmetic', NULL, N'Ethereal Beauty', CAST(3345.0000 AS Decimal(19, 4)), 0, 6, N'In stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'E573G6', N'Luminous Glow', N'sparkling citrus body mist', N'cosmetic', NULL, N'Celestial Fragrances', CAST(2607.0000 AS Decimal(19, 4)), 76, 29, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'F344S4', N'Velvet Elegance', N'floral and fruity scent', N'cosmetic', NULL, N'Cosmic Scents', CAST(172.0000 AS Decimal(19, 4)), 0, 35, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'F346G5', N'Opulent Aura', N'long-lasting matte lipstick', N'perfume', NULL, N'Cosmic Scents', CAST(4675.0000 AS Decimal(19, 4)), 0, 50, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'F893T5', N'Radiant Bloom0.5', N'floral and fruity scent', N'cosmetic', NULL, N'Ethereal Beauty', CAST(334.0000 AS Decimal(19, 4)), 0, 28, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'G532R5', N'Radiant Bloom', N'sparkling citrus body mist', N'cosmetic', NULL, N'Luminous Elegance', CAST(2885.0000 AS Decimal(19, 4)), 73, 2, N'In stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'H732R5', N'Opulent Aura', N'long-lasting matte lipstick', N'cosmetic', NULL, N'Ethereal Beauty', CAST(1168.0000 AS Decimal(19, 4)), 83, 38, N'In stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'J432E4', N'Radiant Bloom', N'elegant rose perfume', N'perfume', NULL, N'Cosmic Scents', CAST(4733.0000 AS Decimal(19, 4)), 0, 2, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'K535G6', N'Luminous Glow', N'sparkling citrus body mist', N'cosmetic', NULL, N'Celestial Fragrances', CAST(2607.0000 AS Decimal(19, 4)), 76, 29, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'O875F6', N'Silk Whispers', N'hydrating facial serum', N'cosmetic', NULL, N'Celestial Fragrances', CAST(869.0000 AS Decimal(19, 4)), 85, 25, N'In stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'R464G6', N'Velvet Elegance', N'floral and fruity scent', N'cosmetic', NULL, N'Cosmic Scents', CAST(172.0000 AS Decimal(19, 4)), 0, 35, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'S753T5', N'Silk Whispers', N'sparkling citrus body mist', N'perfume', NULL, N'Ethereal Beauty', CAST(2748.0000 AS Decimal(19, 4)), 0, 12, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'V472S3', N'Luminous Glow', N'floral and fruity scent', N'perfume', NULL, N'Stellar Cosmetics', CAST(2013.0000 AS Decimal(19, 4)), 0, 28, N'Not in stock')
INSERT [dbo].[Product] ([ProductArticleNumber], [Name], [Description], [Category], [Photo], [Manufacturer], [Cost], [DiscountAmount], [QuantityInStock], [Status]) VALUES (N'А112Т4', N'Radiant Bloom', N'long-lasting matte lipstick', N'perfume', NULL, N'Cosmic Scents', CAST(3389.0000 AS Decimal(19, 4)), 0, 49, N'Not in stock')
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [Name]) VALUES (1, N'Клиент')
INSERT [dbo].[Role] ([RoleId], [Name]) VALUES (2, N'Менеджер')
INSERT [dbo].[Role] ([RoleId], [Name]) VALUES (3, N'Администратор')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (1, N'Константинова', N'Вероника', N'Агафоновна', N'loginDEsgg2018', N'qhgYnW', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (2, N'Меркушев', N'Мартын', N'Федотович', N'loginDEdcd2018', N'LxR6YI', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (3, N'Казаков', N'Федот', N'Кондратович', N'loginDEisg2018', N'Cp8ddU', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (4, N'Карпов', N'Улеб', N'Леонидович', N'loginDEcph2018', N'7YpE0p', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (5, N'Королёв', N'Матвей', N'Вадимович', N'loginDEgco2018', N'nMr|ss', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (6, N'Юдин', N'Герман', N'Кондратович', N'loginDEwjg2018', N'9UfqWQ', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (7, N'Беляева', N'Анна', N'Вячеславовна', N'loginDEjbz2018', N'xIAWNI', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (8, N'Беляев', N'Валентин', N'Артёмович', N'loginDEmgu2018', N'0gC3bk', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (9, N'Семёнов', N'Герман', N'Дмитрьевич', N'loginDErdg2018', N'ni0ue0', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (10, N'Шестаков', N'Илья', N'Антонинович', N'loginDEjtv2018', N'f2ZaN6', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (11, N'Власов', N'Вадим', N'Васильевич', N'loginDEtfj2018', N'{{ksPn', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (12, N'Савельев', N'Арсений', N'Авксентьевич', N'loginDEpnb2018', N'{ADBdc', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (13, N'Ефимов', N'Руслан', N'Якунович', N'loginDEzer2018', N'5&R+zs', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (14, N'Бурова', N'Марфа', N'Федотовна', N'loginDEiin2018', N'y9l*b}', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (15, N'Селезнёв', N'Александр', N'Никитевич', N'loginDEqda2018', N'|h+r}I', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (16, N'Кулакова', N'Виктория', N'Георгьевна', N'loginDEbnj2018', N'#ИМЯ?', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (17, N'Дорофеева', N'Кира', N'Демьяновна', N'loginDEqte2018', N'dC8bDI', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (18, N'Сафонова', N'Нинель', N'Якововна', N'loginDEfeo2018', N'8cI7vq', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (19, N'Ситникова', N'София', N'Лукьевна', N'loginDEvni2018', N'e4pVIv', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (20, N'Медведев', N'Ириней', N'Геннадьевич', N'loginDEjis2018', N'A9K++2', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (21, N'Суханова', N'Евгения', N'Улебовна', N'loginDExvv2018', N'R1zh}|', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (22, N'Игнатьев', N'Владлен', N'Дамирович', N'loginDEadl2018', N'F&IWf4', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (23, N'Ефремов', N'Христофор', N'Владиславович', N'loginDEyzn2018', N'P1v24R', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (24, N'Кошелев', N'Ростислав', N'Куприянович', N'loginDEphn2018', N'F}jGsJ', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (25, N'Галкина', N'Тамара', N'Авксентьевна', N'loginDEdvk2018', N'NKNkup', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (26, N'Журавлёва', N'Вера', N'Арсеньевна', N'loginDEtld2018', N'c+CECK', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (27, N'Савина', N'Таисия', N'Глебовна', N'loginDEima2018', N'XK3sOA', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (28, N'Иванов', N'Яков', N'Мэлорович', N'loginDEyfe2018', N'4Bbzpa', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (29, N'Лыткин', N'Ким', N'Алексеевич', N'loginDEwqc2018', N'vRtAP*', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (30, N'Логинов', N'Федот', N'Святославович', N'loginDEgtt2018', N'7YD|BR', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (31, N'Русакова', N'Марина', N'Юлиановна', N'loginDEiwl2018', N'LhlmIl', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (32, N'Константинов', N'Пётр', N'Кондратович', N'loginDEyvi2018', N'22beR}', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (33, N'Поляков', N'Анатолий', N'Игоревич', N'loginDEtfz2018', N'uQY0ZQ', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (34, N'Панфилова', N'Василиса', N'Григорьевна', N'loginDEikb2018', N'*QkUxc', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (35, N'Воробьёв', N'Герман', N'Романович', N'loginDEdmi2018', N'HOGFbU', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (36, N'Андреев', N'Ростислав', N'Федосеевич', N'loginDEtlo2018', N'58Jxrg', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (37, N'Бобров', N'Агафон', N'Владимирович', N'loginDEsnd2018', N'lLHqZf', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (38, N'Лапин', N'Алексей', N'Витальевич', N'loginDEgno2018', N'4fqLiO', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (39, N'Шестаков', N'Авдей', N'Иванович', N'loginDEgnl2018', N'wdio{u', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (40, N'Гаврилова', N'Алина', N'Эдуардовна', N'loginDEzna2018', N'yz1iMB', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (41, N'Жуков', N'Юлиан', N'Валерьянович', N'loginDEsyh2018', N'&4jYGs', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (42, N'Пономарёв', N'Максим', N'Альвианович', N'loginDExex2018', N'rnh36{', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (43, N'Зиновьева', N'Мария', N'Лаврентьевна', N'loginDEdjm2018', N'KjI1JR', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (44, N'Осипов', N'Артём', N'Мэлорович', N'loginDEgup2018', N'36|KhF', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (45, N'Лапин', N'Вячеслав', N'Геласьевич', N'loginDEdat2018', N'ussd8Q', 3)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (46, N'Зуев', N'Ириней', N'Вадимович', N'loginDEffj2018', N'cJP+HC', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (47, N'Коновалова', N'Агафья', N'Митрофановна', N'loginDEisp2018', N'dfz5Ii', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (48, N'Исаев', N'Дмитрий', N'Аристархович', N'loginDEfrp2018', N'6dcR|9', 2)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (49, N'Белозёрова', N'Алевтина', N'Лаврентьевна', N'loginDEaee2018', N'5&qONH', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (50, N'Самсонов', N'Агафон', N'Максимович', N'loginDEthu2018', N'|0xWzV', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (55, N'Новиков', N'Матвей', N'Маркович', N'loginDEsrz2018', N'efX9)Xfv', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (56, N'Соловьев', N'Пётр', N'Никитич', N'loginDEjcq2018', N'dcXMNV', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (57, N'Васильева', N'Софья', N'Глебовна', N'loginDEcqp2018', N'cjkwzxxx', 1)
INSERT [dbo].[User] ([UserId], [Surname], [Name], [Patronymic], [Login], [Password], [RoleId]) VALUES (58, N'Львов', N'Роман', N'Павлович', N'loginDEopp2018', N'sd00xcSAJ', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PickupPoint] FOREIGN KEY([PickupPointId])
REFERENCES [dbo].[PickupPoint] ([PickupPointId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_PickupPoint]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Order__52593CB8] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Order__52593CB8]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK__OrderProd__Produ__534D60F1] FOREIGN KEY([ProductArticleNumber])
REFERENCES [dbo].[Product] ([ProductArticleNumber])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK__OrderProd__Produ__534D60F1]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK__User__UserRole__4BAC3F29] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK__User__UserRole__4BAC3F29]
GO
USE [master]
GO
ALTER DATABASE [tradedb] SET  READ_WRITE 
GO
