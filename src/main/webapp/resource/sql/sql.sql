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