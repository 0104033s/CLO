CREATE TABLE user (
userNum int,
userID varchar(20),
userPW varchar(20),
userName varchar(10),
userNickname varchar(20),
userTel varchar(20),
userEmail varchar(50),
userGender varchar(20),
admin int,
primary key(userID)
)default charset=utf8;

create table notice(
nNum int,
nTitle varchar(20),
userID varchar(20),
nText text,
nDate datetime,
nCount int,
nDelete int,
primary key(nNum)
)default charset=utf8;

create table noticeR (
nNum int,
rNum int,
rReply text,
rDate datetime,
userID varchar(20),
primary key(rnum)
)default charset=utf8;

create table question(
qNum int,
qTitle varchar(20),
qText text,
qDate datetime,
qCount int,
qDelete int,
userID varchar(20),
primary key(qNum)
)default charset=utf8;

create table questionR (
qNum int,
rNum int,
rReply text,
rDate datetime,
userID varchar(20),
primary key(rnum)
)default charset=utf8;

drop table brand;
create table brand(
bNum int,
bName varchar(20),
bInfo text,
bUrl varchar(30),
bImg varchar(20),
origin varchar(20),
primary key (bNum)
)default charset=utf8;

drop table board;
create table board(
bNum int,
bTitle varchar(20),
bText text,
brand varchar(20),
userID varchar(20),
bImg varchar(20),
bDelete int,
bCnt int,
primary key(bNum)
)default charset=utf8;
select * from board;