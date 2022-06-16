--GGV_02--
--khách hàng--

CREATE DATABASE CGV_02
GO

CREATE TABLE User_ (
    UserID INT IDENTITY PRIMARY KEY ,--khách hàng id-
    UserName NVARCHAR(50) NOT NULL,--tên khách hàng--
    Userbod DATE,--sinh ngày?-
    Tel NVARCHAR(10) NOT NULL,--sdt-
    Email NVARCHAR(50) NOT NULL,--email--
    Addres NVARCHAR(50)
)
GO
--thông tin phim-
CREATE TABLE Movie (
    MovieID INT IDENTITY PRIMARY KEY , --idphim--
    MovieName NVARCHAR(50) NOT NULL,--tên phim--
    Director NVARCHAR(50) NOT NULL,--đạo tiễn-
    Category NVARCHAR(50) NOT NULL,--thể loại phim-
    MovieLanguege NVARCHAR(20)  NOT NULL,--ngôn ngữ phim--
    SuitableAge NVARCHAR(3) NOT NULL --độ tuôi phù hợp--
)
GO
--ngày đặt vé-
CREATE TABLE BookingDate (
    DateID INT IDENTITY PRIMARY KEY ,
    Date_ date check (Date_>=getdate() and Date_ < (getdate() + 30))--NGÀY ĐẶT VÉ --
)
GO
--thành phố --
CREATE TABLE City (
    DateID INT CONSTRAINT fk_date FOREIGN KEY (DateID) REFERENCES BookingDate(DateID),
    CityID INT IDENTITY PRIMARY KEY , 
    CityName NVARCHAR(20) NOT NULL -- TÊN THÀNH PHỐ--
)
GO
--tên phòng vé--
CREATE TABLE MovieTheater (
    CityID INT CONSTRAINT fk_city FOREIGN KEY (CityID) REFERENCES City(CityID),
    TheaterID INT IDENTITY PRIMARY KEY NOT NULL,
    TheaterName NVARCHAR(50) NOT NULL, --PHÒNG VÉ--
)
GO
--loại phòng--
CREATE TABLE RoomMovie (
    TheaterID INT CONSTRAINT fk_theater FOREIGN KEY (TheaterID) REFERENCES MovieTheater(TheaterID),
    MovieTypeID INT IDENTITY PRIMARY KEY NOT NULL,
    MovieType NVARCHAR(20) NOT NULL, -- LOẠI PHÒNG --
    MoviePrice MONEY NOT NULL
)
GO

--loại ghế --
CREATE TABLE Seats (
    MovieTypeID INT CONSTRAINT fk_roommovie FOREIGN KEY (MovieTypeID) REFERENCES RoomMovie(MovieTypeID),
    SeatsID INT IDENTITY PRIMARY KEY , 
    Seats NVARCHAR(50), --TÊN LOẠI GHẾ--
    SeatsPrice MONEY  -- GIÁ GHẾ --
)
GO
--xuất chiếu--
CREATE TABLE Premiere (
    MovieTypeID INT CONSTRAINT fk_movietype FOREIGN KEY (MovieTypeID) REFERENCES RoomMovie(MovieTypeID),--loại phim 3d 4d--
    MovieID INT CONSTRAINT fk_movie FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),--tên phim--
    PremiereID INT IDENTITY PRIMARY KEY NOT NULL,--id xuất chiếu--
    PremiereTime TIME NOT NULL,--giờ chiếu--
    EndTime TIME NOT NULL --giờ kết thúc--
)
GO

--Service--
CREATE TABLE MovieService (
    ProductID INT IDENTITY(20,1) PRIMARY KEY ,
    ProductName NVARCHAR(50) NOT NULL,
    ProductType INT DEFAULT 0 CHECK (ProductType IN(0,1)),--0 :drick , 1 : bỏng--
    Unit NVARCHAR(10) NOT NULL,
    Price MONEY NOT NULL,
    Qty NVARCHAR(5) NOT NULL,
    Status NVARCHAR(50)

)

--Order đồ ăn --
CREATE TABLE Order_(
    OrderID INT IDENTITY(10,1) PRIMARY KEY ,
    UserID INT CONSTRAINT fk_user_order FOREIGN KEY (UserID) REFERENCES User_(UserID) ,
    OrderDate DATE CONSTRAINT fk_orderDate CHECK (OrderDate>=GETDATE()),
    Status NVARCHAR(50)
)
GO

--Order Chi Tiết--
CREATE TABLE Orderdetails_ (
    OrderID INT CONSTRAINT fk_oder FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
    ProductID INT CONSTRAINT fk_product FOREIGN KEY (ProductID) REFERENCES MovieService(ProductID),
    Price MONEY,
    Qty INT ,
) 
GO

--BẢNG VÉ 
CREATE TABLE Ticket (
    TickitID INT IDENTITY(100,1) PRIMARY KEY ,
    OrderID INT CONSTRAINT fk_order_ticket FOREIGN KEY (OrderID) REFERENCES Order_(OrderID),
    UserID INT CONSTRAINT fk_user_ticket FOREIGN KEY (UserID) REFERENCES User_(UserID),
    TicketDate DATE  NOT NULL
)
GO

--CHI TIẾT VÉ
CREATE TABLE TicketFULL (
    TicketFullID INT IDENTITY(10000,1) PRIMARY KEY ,
    TickitID INT CONSTRAINT fk_Ticket FOREIGN KEY (TickitID) REFERENCES Ticket(TickitID),
    MovieID INT CONSTRAINT fk_movie2 FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
    TicketReleaseDate DATE CONSTRAINT fk_dateticket CHECK(TicketReleaseDate <= getdate())
)
GO

