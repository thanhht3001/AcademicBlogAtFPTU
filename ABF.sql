create database ABF
use ABF
--------Tạo bảng------------

--Bảng Blog
create table Blog(
blogID int identity(1,1) primary key,
userID int not null,
userApproveID int,
subjectID int not null,
title nvarchar(50) not null,
content nvarchar(max) not null,
date nvarchar(100) not null,
image nvarchar(max),
video nvarchar(max),
numberOfVotes int not null,
numberOfComments int,
award int,
status nvarchar(10) not null)

--Bảng User
create table [User](
userID int identity(1,1) primary key,
password nvarchar(50) not null,
fullName nvarchar(250) not null,
roleID int not null,
email nvarchar(255) not null,
image nvarchar(max),
numberOfBlogs int not null,
gender nvarchar(50),
dateOfBirth nvarchar(50),
address nvarchar(250),
contact nvarchar(50),
aboutme nvarchar(50),
status nvarchar(10) not null)

--Bảng Role
create table Role(
roleID int identity(1,1) primary key,
roleName nvarchar(50) not null)

--Bảng Comment
create table Comment(
commentID int identity(1,1) primary key,
blogID int not null,
userID int not null,
content nvarchar(max) not null,
date nvarchar(50) not null,
image nvarchar(max),
video nvarchar(max),
status nvarchar(10) not null)

--Bảng Subject
create table Subject(
subjectID int identity(1,1) primary key,
subjectName nvarchar(250) not null,
majorID int not null,
status nvarchar(10) not null)

--Bảng Major
create table Major(
majorID int identity(1,1) primary key,
majorName nvarchar(50) not null,
status nvarchar(10) not null)

--Bảng Registration
--create table RegistrationDetail(
--subjectID int not null,
--registrationID int not null,
--date nvarchar(50) not null)

--Bảng RegistrationDetails
--create table Registration(
--registrationID int identity(1,1) primary key,
--userID int not null,
--certificate image not null)

--Bảng Feedback
create table Feedback(
feedbackID int identity(1,1) primary key,
userID int not null,
feedbackTypeID int not null,
description nvarchar(max) not null,
date nvarchar(50) not null)

--Bảng FeedbackType
create table FeedbackType(
feedbackTypeID int identity(1,1) primary key,
feedbackName nvarchar(50) not null
)

--Bảng HistoryActivity
create table HistoryActivity(
historyActivityID int identity(1,1) primary key,
userID int not null,
date nvarchar(50),
activityTypeID int,
blogID int,
status int
)

--Bảng ActivityType
create table ActivityType(
activityTypeID int identity(1,1) primary key,
activity nvarchar(50) not null,
)

--Bảng Registration
create table Registration(
registrationID int identity(1,1) primary key,
userID int not null,
subjectID int not null,
date nvarchar(50) not null,
certificate nvarchar(max) not null,
status int not null
)
--------Thêm khoá ngoại------------
alter table Blog add foreign key (userID) references [User](userID)
alter table Blog add foreign key (subjectID) references Subject(subjectID)
alter table [User] add foreign key (roleID) references Role(roleID)
alter table Comment add foreign key (blogID) references Blog(blogID)
alter table Comment add foreign key (userID) references [User](userID)
alter table Subject add foreign key (majorID) references Major(majorID)
alter table Registration add foreign key (subjectID) references Subject(subjectID)
alter table Registration add foreign key (userID) references [User](userID)
alter table Feedback add foreign key (userID) references [User](userID)
alter table Feedback add foreign key (feedbackTypeID) references FeedbackType(feedbackTypeID)
alter table HistoryActivity add foreign key (userID) references [User](userID)
alter table HistoryActivity add foreign key (activityTypeID) references ActivityType(activityTypeID)

-------------------------------------------------------------------------------------------------------------------
--Xem dữ liệu--
select * from Feedback
select * from [User]
select * from Role
select * from Major
select * from Subject
select * from Blog
select * from HistoryActivity
select * from ActivityType
select * from Registration
--Insert dữ liệu vào bảng--

--Bảng Major--
insert into Major(majorName, status) values ('Software Engineering', 1)

--Bảng Subject--
insert into Subject(subjectName, majorID, status) values('PRJ301', 1, 1)
insert into Subject(subjectName, majorID, status) values('SWP391', 1, 1)
insert into Subject(subjectName, majorID, status) values('SWT301', 1, 1)
insert into Subject(subjectName, majorID, status) values('JPD201', 1, 1)
insert into Subject(subjectName, majorID, status) values('SSL101', 1, 1)
insert into Subject(subjectName, majorID, status) values('ITE123', 1, 1)

--Bảng Role--
insert into Role(roleName) values('Admin')
insert into Role(roleName) values('Student')
insert into Role(roleName) values('Mentor')

--Bảng User--
insert into [User](password,fullName,roleID,email,image,numberOfBlogs,gender,dateOfBirth,
address,contact,aboutme,status) values ('123','Phan Thi To Quyen', 1, 'quyenlh01@gmail.com',
null, 0,null, null,null,null,null, 1)
insert into [User](password,fullName,roleID,email,image,numberOfBlogs,gender,dateOfBirth,
address,contact,aboutme,status) values ('123','Phan Thi To Quyen', 2, 'quyenlh012@gmail.com',
null, 0,null, null,null,null,null, 1)
insert into [User](password,fullName,roleID,email,image,numberOfBlogs,gender,dateOfBirth,
address,contact,aboutme,status) values ('123','Phan Thi To Quyen', 3, 'quyenlh0123@gmail.com',
null, 0,null, null,null,null,null, 1)

--Bảng FeedbackType--
insert into FeedbackType(feedbackName) values('About System')
insert into FeedbackType(feedbackName) values('About Student')
insert into FeedbackType(feedbackName) values('About Mentor')

--Bảng Blog--
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','8/6/2022 11:22:02','image/bg6.jpg','video/123',4,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/3/2022 11:23:02',null,null,0,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/2/2022 11:22:02',null, null,0,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 2,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','8/6/2022 11:22:02','image/bg6.jpg','video/123',4,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 2,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/3/2022 11:23:02',null,null,0,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 2,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/2/2022 11:22:02',null, null,0,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','8/6/2022 11:22:02','image/bg6.jpg','video/123',4,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/3/2022 11:23:02',null,null,0,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/2/2022 11:22:02',null, null,0,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','8/6/2022 11:22:02','image/bg6.jpg','video/123',4,0,'waiting')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/3/2022 11:23:02',null,null,0,0,'waiting')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/2/2022 11:22:02',null, null,0,0,'waiting')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,6,'123asd','akjshfksnnvoiewrwqurfjckanc','30/7/2022 11:22:02',null, null,0,0,'waiting')

--Bảng ActivityType
insert into ActivityType(activity) values('You voted a blog.')
insert into ActivityType(activity) values('You posted a blog.')
insert into ActivityType(activity) values('You commented a blog.')

--Bảng HistoryActivity--
insert into HistoryActivity(userID, date, activityTypeID, blogID, status) 
values(2, '11/12/2011 11:30:02', 1, 1,1) 
insert into HistoryActivity(userID, date, activityTypeID, blogID, status) 
values(2, '11/12/2011 11:33:02', 1, 1,1)
insert into HistoryActivity(userID, date, activityTypeID, blogID, status) 
values(2, '11/12/2011 11:32:02', 1, 1,1)

--Bảng Registration
insert into Registration(userID, subjectID, date, certificate, status) values(2, 2, '11/12/2011 11:32:02', 'abc', 1)
insert into Registration(userID, subjectID, date, certificate, status) values(3, 2, '11/12/2011 11:32:02', 'abc', 1)
insert into Registration(userID, subjectID, date, certificate, status) values(3, 6, '11/12/2011 11:32:02', 'abc', 1)


delete HistoryActivity where userID = 2 AND blogID = 1 AND activityTypeID = 1
Update [User] SET roleID = 2 where userID = 1
SELECT userID, fullName, roleID, gender, dateOfBirth, image, status 
select historyActivityID from HistoryActivity where blogID = 1 AND activityTypeID = 1 AND userID = 2
FROM [User] WHERE email like 'quyenlh01@gmail.com' AND password like '123'
SELECT userID, fullName, roleID, email, gender, dateOfBirth, image, status
            FROM [User] WHERE email like 'quyenpttse150351@fpt.edu.vn'
			delete from [User] where email like 'quyenpttse150351@fpt.edu.vn'
INSERT INTO [User](password, fullName, roleID, email, gender, dateOfBirth, image, status)
            VALUES('123','Phan Thi To Quyen',1,'quyenlh01@gmail.com',null,null,null,1)
INSERT INTO [User](fullName, roleID, email, gender, dateOfBirth, image, status)
            VALUES('thanhhtse150412',1,'thanhhtse150412@fpt.edu.vn',null,null,null,1)

INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','8/6/2022 11:22:02','image/bg6.jpg','video/123',4,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/3/2022 11:23:02','img/123','video/123',0,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/2/2022 11:22:02','img/123','video/123',0,0,'approved')
INSERT INTO [Blog](userID, userApproveID, subjectID, title, content, date, image, video, numberOfVotes, numberOfComments, status) 
			VALUES( 1,null,2,'123asd','akjshfksnnvoiewrwqurfjckanc','6/2/2022 11:22:02','img/123','video/123',0,0,'saved')
Insert into [User](password,fullName,roleID,email,image,numberOfBlogs,
gender,dateOfBirth,address,contact,aboutme,status) values
('123','To Quyen',1,'quyenlh01@gmail.com',null,0,null,null,null,null,null,1)
SELECT blogID,Blog.userID,userApproveID,subjectID,title,content,date, Blog.image,video,numberOfVotes,numberOfComments,Blog.status, fullName from Blog JOIN [USER] ON Blog.userID = [User].userID where Blog.status LIKE 'approved'
SELECT blogID,Blog.userID,userApproveID,subjectID,title,content,date, Blog.image,video,
            numberOfVotes,numberOfComments,Blog.status, fullName FROM Blog JOIN [USER] ON Blog.userID = [User].userID 
            WHERE title LIKE '123asd' AND Blog.status LIKE 'approved'
			select [User].userID, numberOfBlogs from [User] Join  ON [User].userID = Blog.userID where Blog.status = 'approved' and [User].userID = 1
UPDATE [User] SET numberOfBlogs = 6 WHERE userID = 1
UPDATE Blog SET status = 'approved' WHERE blogID = 21
SELECT blogID,Blog.userID,userApproveID,subjectID,title,content,date, Blog.image,video,
            numberOfVotes,numberOfComments,Blog.status, fullName FROM Blog JOIN [USER] ON Blog.userID = [User]
--Sự giải thoát
use master
drop database ABF
update [User] set roleID = 2 where userID = 2
SELECT historyActivityID, date, activity FROM HistoryActivity 
JOIN ActivityType ON  = ActivityType.activityTypeID 
WHERE userID = 2

UPDATE [Registration]
            SET status = 3
            WHERE registrationID = 4
            UPDATE [User]
             SET roleID = 2
             WHERE userID = 2
