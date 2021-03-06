USE [TabMe]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 10/15/2017 11:30:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[AddressId] [bigint] IDENTITY(1,1) NOT NULL,
	[EntityType] [int] NULL,
	[EntityId] [int] NULL,
	[FlatNo] [nvarchar](100) NULL,
	[BuildingName] [nvarchar](100) NULL,
	[StreetName] [nvarchar](100) NULL,
	[Landmark] [nvarchar](100) NULL,
	[CountryId] [int] NULL,
	[StateId] [int] NULL,
	[City] [nvarchar](100) NULL,
	[Zipcode] [nchar](10) NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Picture]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Picture](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EntityType] [int] NULL,
	[EntityId] [int] NULL,
	[FileExtension] [nvarchar](20) NULL,
 CONSTRAINT [PK_Picture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Room]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomTypeId] [smallint] NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Capacity] [smallint] NULL,
	[Rate] [decimal](18, 2) NULL,
	[PackageId] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsMinSpend] [bit] NULL,
	[MinSpendRate] [decimal](18, 2) NULL,
	[IsPeak] [bit] NULL,
	[PeakOpenTime] [nvarchar](10) NULL,
	[PeakCloseTime] [nvarchar](10) NULL,
	[PeakRate] [decimal](18, 2) NULL,
	[IsCustomRateTiming] [bit] NULL,
	[CRTOpenTime] [nvarchar](10) NULL,
	[CRTCloseTime] [nvarchar](10) NULL,
	[CRTRate] [decimal](18, 2) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[Address_Delete]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Address_Delete]
@AddressId BIGINT
, @ErrorCode int OUTPUT
AS

DELETE FROM Address
WHERE AddressId = @AddressId
     
	  
 -- Get the Error Code for the statment just executed
SET @ErrorCode = @@ERROR

GO
/****** Object:  StoredProcedure [dbo].[Address_GetByEntityType_Id]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Address_GetByEntityType_Id]
@EntityType INT = NULL,
@EntityId INT = NULL
AS
BEGIN
	
SELECT * FROM Address
WHERE EntityType = @EntityType AND EntityId = @EntityId

END

GO
/****** Object:  StoredProcedure [dbo].[Address_GetById]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Address_GetById]
@AddressId BIGINT
, @ErrorCode int OUTPUT
AS

SELECT * FROM Address
WHERE AddressId = @AddressId
     
	  
 -- Get the Error Code for the statment just executed
SET @ErrorCode = @@ERROR

GO
/****** Object:  StoredProcedure [dbo].[Address_InsertUpdate]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Address_InsertUpdate]
    @AddressId BIGINT,
    @EntityType INT = NULL,
    @EntityId INT = NULL,
	@FlatNo NVARCHAR(100) = NULL,
    @BuildingName NVARCHAR(100) = NULL,
    @StreetName NVARCHAR(100) = NULL,
    @Landmark NVARCHAR(100) = NULL,
    @CountryId INT = NULL,
    @StateId INT = NULL,
    @City NVARCHAR(100) = NULL,
    @Zipcode NCHAR = NULL
   
AS

    IF NOT EXISTS ( SELECT  *
                    FROM    [Address]
                    WHERE   [AddressId] = @AddressId)

BEGIN
     INSERT  INTO [dbo].[Address] 
                    (  [EntityType],
                       [EntityId],
					   [FlatNo],
                       [BuildingName],
                       [StreetName],
                       [Landmark],
                       [CountryId],
                       [StateId],
                       [City],
                       [Zipcode] ) 
     VALUES( @EntityType,
					 @EntityId,
                     @FlatNo,
                     @BuildingName,
                     @StreetName,
                     @Landmark,
                     @CountryId,
                     @StateId,
                     @City,
                     @Zipcode )

SET @AddressId = SCOPE_IDENTITY()
END
ELSE
BEGIN
UPDATE [dbo].[Address] 
SET        [EntityType] = @EntityType, 
			   [EntityId] = @EntityId,
               [FlatNo] = @FlatNo, 
               [BuildingName] = @BuildingName, 
               [StreetName] = @StreetName, 
               [Landmark] = @Landmark, 
               [CountryId] = @CountryId, 
               [StateId] = @StateId, 
               [City] = @City, 
               [Zipcode] = @Zipcode 
               WHERE AddressId= @AddressId
END

SELECT @AddressId AS AddressId

GO
/****** Object:  StoredProcedure [dbo].[Address_SelectAll]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Address_SelectAll]
--Default Param
-- Please do not changes this parameter
@Page INT,
@PageRecord INT,
@SortByColumn NVARCHAR(50),
@Orderby NVARCHAR(10)
--Default Param
--Additional Param
--Here you can add additional parameter you required

--Additional Param
AS
BEGIN

SELECT * , COUNT(*) OVER ( PARTITION BY '''' ) TotalRecords
FROM Address

ORDER BY  
CASE WHEN ( @SortByColumn = 'EntityType' AND @Orderby = 'ASC' ) THEN Address.EntityType END ASC ,
CASE WHEN ( @SortByColumn = 'EntityType' AND @Orderby = 'DESC') THEN Address.EntityType END DESC,  
CASE WHEN ( @SortByColumn = 'EntityId' AND @Orderby = 'ASC' ) THEN Address.EntityId END ASC ,
CASE WHEN ( @SortByColumn = 'EntityId' AND @Orderby = 'DESC') THEN Address.EntityId END DESC,
CASE WHEN ( @SortByColumn = 'FlatNo' AND @Orderby = 'ASC' ) THEN Address.FlatNo END ASC ,
CASE WHEN ( @SortByColumn = 'FlatNo' AND @Orderby = 'DESC') THEN Address.FlatNo END DESC,  
CASE WHEN ( @SortByColumn = 'BuildingName' AND @Orderby = 'ASC' ) THEN Address.BuildingName END ASC ,
CASE WHEN ( @SortByColumn = 'BuildingName' AND @Orderby = 'DESC') THEN Address.BuildingName END DESC,  
CASE WHEN ( @SortByColumn = 'StreetName' AND @Orderby = 'ASC' ) THEN Address.StreetName END ASC ,
CASE WHEN ( @SortByColumn = 'StreetName' AND @Orderby = 'DESC') THEN Address.StreetName END DESC,  
CASE WHEN ( @SortByColumn = 'Landmark' AND @Orderby = 'ASC' ) THEN Address.Landmark END ASC ,
CASE WHEN ( @SortByColumn = 'Landmark' AND @Orderby = 'DESC') THEN Address.Landmark END DESC,  
CASE WHEN ( @SortByColumn = 'CountryId' AND @Orderby = 'ASC' ) THEN Address.CountryId END ASC ,
CASE WHEN ( @SortByColumn = 'CountryId' AND @Orderby = 'DESC') THEN Address.CountryId END DESC,  
CASE WHEN ( @SortByColumn = 'StateId' AND @Orderby = 'ASC' ) THEN Address.StateId END ASC ,
CASE WHEN ( @SortByColumn = 'StateId' AND @Orderby = 'DESC') THEN Address.StateId END DESC,  
CASE WHEN ( @SortByColumn = 'City' AND @Orderby = 'ASC' ) THEN Address.City END ASC ,
CASE WHEN ( @SortByColumn = 'City' AND @Orderby = 'DESC') THEN Address.City END DESC,  
CASE WHEN ( @SortByColumn = 'Zipcode' AND @Orderby = 'ASC' ) THEN Address.Zipcode END ASC ,
CASE WHEN ( @SortByColumn = 'Zipcode' AND @Orderby = 'DESC') THEN Address.Zipcode END DESC
OFFSET ( ( @Page - 1 ) * @PageRecord ) ROWS
FETCH NEXT @PageRecord ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[Picture_Delete]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Picture_Delete]
@Id BIGINT
, @ErrorCode int OUTPUT
AS

DELETE FROM Picture
WHERE Id = @Id
     
	  
 -- Get the Error Code for the statment just executed
SET @ErrorCode = @@ERROR

GO
/****** Object:  StoredProcedure [dbo].[Picture_GetByEntityType_Id]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Picture_GetByEntityType_Id]
@EntityType INT = NULL,
@EntityId INT = NULL
AS
BEGIN
	
SELECT * FROM Picture
WHERE EntityType = @EntityType AND EntityId = @EntityId

END

GO
/****** Object:  StoredProcedure [dbo].[Picture_GetById]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Picture_GetById]
@Id BIGINT
, @ErrorCode int OUTPUT
AS

SELECT * FROM Picture
WHERE Id = @Id
     
	  
 -- Get the Error Code for the statment just executed
SET @ErrorCode = @@ERROR

GO
/****** Object:  StoredProcedure [dbo].[Picture_InsertUpdate]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Picture_InsertUpdate]
    @Id BIGINT,
    @EntityType INT = NULL,
	@EntityId INT = NULL,
    @FileExtension NVARCHAR(20) = NULL
   
AS

    IF NOT EXISTS ( SELECT  *
                    FROM    [Picture]
                    WHERE   [Id] = @Id)

BEGIN
     INSERT  INTO [dbo].[Picture] 
                    (  [EntityType],
						[EntityId],
                       [FileExtension] ) 
     VALUES( @EntityType,@EntityId,
                     @FileExtension )

SET @Id = SCOPE_IDENTITY()
END
ELSE
BEGIN
UPDATE [dbo].[Picture] 
SET        [EntityType] = @EntityType, 
			[EntityId] = @EntityId
               --,[FileExtension] = @FileExtension
               

               WHERE Id= @Id
END

SELECT @Id AS Id

GO
/****** Object:  StoredProcedure [dbo].[Picture_SelectAll]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Picture_SelectAll]
--Default Param
-- Please do not changes this parameter
@Page INT,
@PageRecord INT,
@SortByColumn NVARCHAR(50),
@Orderby NVARCHAR(10)
--Default Param
--Additional Param
--Here you can add additional parameter you required

--Additional Param
AS
BEGIN

SELECT * , COUNT(*) OVER ( PARTITION BY '''' ) TotalRecords
FROM Picture

ORDER BY  
CASE WHEN ( @SortByColumn = 'EntityType' AND @Orderby = 'ASC' ) THEN Picture.EntityType END ASC ,
CASE WHEN ( @SortByColumn = 'EntityType' AND @Orderby = 'DESC') THEN Picture.EntityType END DESC,  
CASE WHEN ( @SortByColumn = 'EntityId' AND @Orderby = 'ASC' ) THEN Picture.EntityId END ASC ,
CASE WHEN ( @SortByColumn = 'EntityId' AND @Orderby = 'DESC') THEN Picture.EntityId END DESC,  
CASE WHEN ( @SortByColumn = 'FileExtension' AND @Orderby = 'ASC' ) THEN Picture.FileExtension END ASC ,
CASE WHEN ( @SortByColumn = 'FileExtension' AND @Orderby = 'DESC') THEN Picture.FileExtension END DESC
OFFSET ( ( @Page - 1 ) * @PageRecord ) ROWS
FETCH NEXT @PageRecord ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[Room_Delete]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Room_Delete]
@Id INT
, @ErrorCode int OUTPUT
AS

DELETE FROM Room
WHERE Id = @Id
     
	  
 -- Get the Error Code for the statment just executed
SET @ErrorCode = @@ERROR

GO
/****** Object:  StoredProcedure [dbo].[Room_GetById]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Room_GetById]
@Id INT
, @ErrorCode int OUTPUT
AS

SELECT * FROM Room
WHERE Id = @Id
     
	  
 -- Get the Error Code for the statment just executed
SET @ErrorCode = @@ERROR

GO
/****** Object:  StoredProcedure [dbo].[Room_InsertUpdate]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Room_InsertUpdate]
    @Id INT,
    @RoomTypeId SMALLINT = NULL,
    @Code NVARCHAR(50) = NULL,
    @Name NVARCHAR(50) = NULL,
    @Capacity SMALLINT = NULL,
    @Rate DECIMAL(18,2) = NULL,
    @PackageId INT = NULL,
    @Description NVARCHAR(MAX) = NULL,
    @Remarks NVARCHAR(MAX) = NULL,
    @IsMinSpend BIT = NULL,
    @MinSpendRate DECIMAL(18,2) = NULL,
	@IsPeak BIT = NULL,
	@PeakOpenTime nvarchar(10) = NULL,
	@PeakCloseTime nvarchar(10) = NULL,
	@PeakRate DECIMAL(18,2) = NULL,
	@IsCustomRateTiming BIT = NULL,
	@CRTOpenTime nvarchar(10) = NULL,
	@CRTCloseTime nvarchar(10) = NULL,
	@CRTRate DECIMAL(18,2) = NULL,
    @Status BIT = NULL
   
AS

    IF NOT EXISTS ( SELECT  *
                    FROM    [Room]
                    WHERE   [Id] = @Id)

BEGIN
     INSERT  INTO [dbo].[Room] 
                    (  [RoomTypeId],
                       [Code],
                       [Name],
                       [Capacity],
                       [Rate],
                       [PackageId],
                       [Description],
                       [Remarks],
                       [IsMinSpend],
					   [MinSpendRate],
                       [IsPeak],
					   [PeakOpenTime],
					   [PeakCloseTime],
					   [PeakRate],
					   [IsCustomRateTiming],
					   [CRTOpenTime],
					   [CRTCloseTime],
					   [CRTRate],
                       [Status] ) 
     VALUES( @RoomTypeId,
                     @Code,
                     @Name,
                     @Capacity,
                     @Rate,
                     @PackageId,
                     @Description,
                     @Remarks,
                     @IsMinSpend,
					 @MinSpendRate,
					 @IsPeak,
					 @PeakOpenTime,
					 @PeakCloseTime,
					 @PeakRate,
					 @IsCustomRateTiming,
					 @CRTOpenTime,
					 @CRTCloseTime,
					 @CRTRate,
                     @Status )

SET @Id = SCOPE_IDENTITY()
END
ELSE
BEGIN
UPDATE [dbo].[Room] 
SET        [RoomTypeId] = @RoomTypeId, 
               [Code] = @Code, 
               [Name] = @Name, 
               [Capacity] = @Capacity, 
               [Rate] = @Rate, 
               [PackageId] = @PackageId, 
               [Description] = @Description, 
               [Remarks] = @Remarks, 
               [IsMinSpend] = @IsMinSpend, 
               [IsPeak] = @IsPeak, 
               [Status] = @Status 
               

               WHERE Id= @Id
END

SELECT @Id AS Id

GO
/****** Object:  StoredProcedure [dbo].[Room_SelectAll]    Script Date: 10/15/2017 11:30:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Room_SelectAll]
--Default Param
-- Please do not changes this parameter
@Page INT,
@PageRecord INT,
@SortByColumn NVARCHAR(50),
@Orderby NVARCHAR(10)
--Default Param
--Additional Param
--Here you can add additional parameter you required

--Additional Param
AS
BEGIN

SELECT * , COUNT(*) OVER ( PARTITION BY '''' ) TotalRecords
FROM Room

ORDER BY  Id DESC
--CASE WHEN ( @SortByColumn = 'RoomTypeId' AND @Orderby = 'ASC' ) THEN Room.RoomTypeId END ASC ,
--CASE WHEN ( @SortByColumn = 'RoomTypeId' AND @Orderby = 'DESC') THEN Room.RoomTypeId END DESC,  
--CASE WHEN ( @SortByColumn = 'Code' AND @Orderby = 'ASC' ) THEN Room.Code END ASC ,
--CASE WHEN ( @SortByColumn = 'Code' AND @Orderby = 'DESC') THEN Room.Code END DESC,  
--CASE WHEN ( @SortByColumn = 'Name' AND @Orderby = 'ASC' ) THEN Room.Name END ASC ,
--CASE WHEN ( @SortByColumn = 'Name' AND @Orderby = 'DESC') THEN Room.Name END DESC,  
--CASE WHEN ( @SortByColumn = 'Capacity' AND @Orderby = 'ASC' ) THEN Room.Capacity END ASC ,
--CASE WHEN ( @SortByColumn = 'Capacity' AND @Orderby = 'DESC') THEN Room.Capacity END DESC,  
--CASE WHEN ( @SortByColumn = 'Rate' AND @Orderby = 'ASC' ) THEN Room.Rate END ASC ,
--CASE WHEN ( @SortByColumn = 'Rate' AND @Orderby = 'DESC') THEN Room.Rate END DESC,  
--CASE WHEN ( @SortByColumn = 'PackageId' AND @Orderby = 'ASC' ) THEN Room.PackageId END ASC ,
--CASE WHEN ( @SortByColumn = 'PackageId' AND @Orderby = 'DESC') THEN Room.PackageId END DESC,  
--CASE WHEN ( @SortByColumn = 'Description' AND @Orderby = 'ASC' ) THEN Room.Description END ASC ,
--CASE WHEN ( @SortByColumn = 'Description' AND @Orderby = 'DESC') THEN Room.Description END DESC,  
--CASE WHEN ( @SortByColumn = 'Remarks' AND @Orderby = 'ASC' ) THEN Room.Remarks END ASC ,
--CASE WHEN ( @SortByColumn = 'Remarks' AND @Orderby = 'DESC') THEN Room.Remarks END DESC,  
--CASE WHEN ( @SortByColumn = 'IsMinSpend' AND @Orderby = 'ASC' ) THEN Room.IsMinSpend END ASC ,
--CASE WHEN ( @SortByColumn = 'IsMinSpend' AND @Orderby = 'DESC') THEN Room.IsMinSpend END DESC,  
--CASE WHEN ( @SortByColumn = 'IsPeak' AND @Orderby = 'ASC' ) THEN Room.IsPeak END ASC ,
--CASE WHEN ( @SortByColumn = 'IsPeak' AND @Orderby = 'DESC') THEN Room.IsPeak END DESC,  
--CASE WHEN ( @SortByColumn = 'Status' AND @Orderby = 'ASC' ) THEN Room.Status END ASC ,
--CASE WHEN ( @SortByColumn = 'Status' AND @Orderby = 'DESC') THEN Room.Status END DESC
OFFSET ( ( @Page - 1 ) * @PageRecord ) ROWS
FETCH NEXT @PageRecord ROWS ONLY
END
GO
