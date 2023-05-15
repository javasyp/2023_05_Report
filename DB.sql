# DB 생성
DROP DATABASE IF EXISTS SYP_Exam;
CREATE DATABASE SYP_Exam;
USE SYP_Exam;

# 회원 테이블 생성
CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    loginId CHAR(30) NOT NULL,
    loginPw CHAR(60) NOT NULL,
    `name` CHAR(20) NOT NULL,
    nickname CHAR(20) NOT NULL,
    cellphoneNum CHAR(20) NOT NULL,
    email CHAR(50) NOT NULL
);

# 회원 테스트데이터 생성
INSERT INTO `member` 
SET regDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '회원1',
nickname = '회원1',
cellphoneNum = '01012345678',
email = 'abcdef@gmail.com';

# 회원 테스트 데이터 생성
INSERT INTO `member` 
SET regDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '회원2',
nickname = '회원2',
cellphoneNum = '01098765432',
email = 'abcd@gmail.com';

INSERT INTO `member` 
SET regDate = NOW(),
loginId = 'test3',
loginPw = 'test3',
`name` = '회원3',
nickname = '회원3',
cellphoneNum = '01012344321',
email = 'test@gmail.com';