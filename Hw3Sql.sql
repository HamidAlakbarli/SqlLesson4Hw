Create Database Kitabxana

Use Kitabxana

Create Table Books
(
  Id int primary key identity,
  Name nvarchar(100) check(len(Name)>=2) not Null unique ,
  PageCount int check((PageCount)>=10),
  AuthorsId int not null Foreign Key References Authors(Id)
)

Insert into Books Values
('Crime and Punishment',200,1),
('War and Peace',230,2),
('Alice in Wonderland',150,3),
('Lord of the Files',220,4),
('Vahana Masterclass',120,5),
('Right Under Our Nose',440,6),
('The Little Book of Encouragement',320,7),
('Beautiful Things’ A Memoir',201,8),
('The Christmas Pig',310,9)
Create Table Authors
(
  Id int primary key identity,
  Name nvarchar(50) not Null unique,
  Surname nvarchar(50) not Null unique
)


Insert into Authors Values
('Fyodor','Dostoevsky'),
('Leo','Tolstoy'),
('Lewis','Carroll'),
('William','Golding'),
('Alfredo','Covelli'),
('R','Giridharan'),
('Dalai','Lama'),
('Hunter','Biden'),
('Jk','Rowling')

--Id, Name, PageCount ve AuthorFullName columnlarinin valuelarini qaytaran bir view yaradin
Create View usv_GetIDNamePageCountFullName
As
Select b.Id,b.Name,b.PageCount,a.Name+''+a.Surname as'FullName' from Books b inner Join Authors a on a.Id =b.AuthorsId

Select * From  usv_GetIDNamePageCountFullName 

--Gonderilmis axtaris deyirene gore hemin axtaris deyeri name ve ya authorFullNamelerinde olan 
--Booklari Id, Name, PageCount, AuthorFullName columnlari seklinde gostern procedure yazin

  Create Procedure usp_GetbookNameandauthorFullName 
  @Name nvarchar(25),
  @AuthorFullName nvarchar(25)
  As
  Begin
  Select * From  usv_GetIDNamePageCountFullName 
  Where name like '%'+@Name+'%'and FullName like '%'+@AuthorFullName+'%'
  End
  
  exec usp_GetbookNameandauthorFullName 'C','F'


  --Authors tableinin insert, update ve deleti ucun (her biri ucun ayrica) procedure yaradin

  Create procedure InsertUpdateDelete
  (
   @id int,
   @Name nvarchar(50),
   @Surname nvarchar(50),
   @StatementType NVARCHAR(50) = ''
  )
  As
  Begin
  If @StatementType = 'Insert'
  Begin 
   Insert into Authors
   (
     Id,
   	 Name,
	 Surname
   )
   Values
   (
   @id,
   @Name,
   @Surname
   )
 End

	IF @StatementType = 'Select'
	Begin 
	Select * from Authors
	End

	If @StatementType = 'Update'
	Begin
	Update Authors Set
	Name = @Name,
	Surname = @Surname
	Where id = @id
	End
	End

	Create procedure Deletea
	(
	 @id int,
	 @StatementType nvarchar(25) = '' 
	)
	as begin If @StatementType = 'Delete'
	Begin
	delete from Authors Where id = @id 
	End
	End


 
 
  





	


