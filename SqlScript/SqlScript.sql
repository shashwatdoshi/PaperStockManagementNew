﻿USE [master]
GO

/****** Object:  Database [PaperStockManagementDB]    Script Date: 1/3/2020 8:14:13 AM ******/
DROP DATABASE [PaperStockManagementDB]
GO

/****** Object:  Database [PaperStockManagementDB]    Script Date: 1/3/2020 8:14:13 AM ******/
CREATE DATABASE [PaperStockManagementDB]
GO

USE [PaperStockManagementDB]
GO

/****** Object:  Table [dbo].[BreakingForce]    Script Date: 1/3/2020 8:18:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BreakingForce](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [int] NOT NULL,
 CONSTRAINT [PK_BreakingForce] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[GSM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Value] [int] NOT NULL,
 CONSTRAINT [PK_GSM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Client](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](50) NOT NULL,
	[Contact] [decimal](10, 0) NULL,
	[Address] [nvarchar](300) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Stock](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GSM] [int] NOT NULL,
	[BreakingForce] [int] NOT NULL,
	[Size] [float] NOT NULL,
	[Weight] [float] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[AuthenticationUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nchar](20) NOT NULL,
	[Password] [char](128) NOT NULL,
 CONSTRAINT [PK_AuthenticationUser] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_AuthenticationUser] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[StockID] [int] NOT NULL,
	[AddedDate] [datetime] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO

ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Client] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ID])
GO

ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Client]
GO

ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Stock] FOREIGN KEY([StockID])
REFERENCES [dbo].[Stock] ([ID])
GO

ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Stock]
GO

CREATE TABLE [dbo].[AddOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
 CONSTRAINT [PK_AddOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AddOrder]  WITH CHECK ADD  CONSTRAINT [FK_AddOrder_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
GO

ALTER TABLE [dbo].[AddOrder] CHECK CONSTRAINT [FK_AddOrder_Order]
GO

CREATE TABLE [dbo].[DispatchOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[VehicleNumber] [nvarchar](15) NOT NULL,
	[DriverName] [nchar](50) NOT NULL,
	[DriverNumber] [nchar](12) NULL,
 CONSTRAINT [PK_DispatchOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DispatchOrder]  WITH CHECK ADD  CONSTRAINT [FK_DispatchOrder_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
GO

ALTER TABLE [dbo].[DispatchOrder] CHECK CONSTRAINT [FK_DispatchOrder_Order]
GO