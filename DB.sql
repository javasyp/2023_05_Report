# DB 생성
DROP DATABASE IF EXISTS SYP_Exam;
CREATE DATABASE SYP_Exam;
USE SYP_Exam;

# 회원 테이블 생성
CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    email CHAR(50) NOT NULL,
    loginPw CHAR(60) NOT NULL,
    `name` CHAR(20) NOT NULL
);

# 회원 테스트 데이터 생성 1
INSERT INTO `member` 
SET regDate = NOW(),
updateDate = NOW(),
email = 'abcd@gmail.com',
loginPw = 'test1',
`name` = '회원1';

# 회원 테스트 데이터 생성 2
INSERT INTO `member` 
SET regDate = NOW(),
updateDate = NOW(),
email = 'abcdef@gmail.com',
loginPw = 'test2',
`name` = '회원2';

# 회원 테스트 데이터 생성 3
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
email = 'test@gmail.com',
loginPw = 'test',
`name` = '회원3';

# 게시판 테이블 생성
CREATE TABLE article(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

# 댓글 테이블 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relId INT(10) NOT NULL COMMENT '게시글 번호',
    `body`TEXT NOT NULL
);

# 게시판 테스트 데이터 생성 1
INSERT INTO article
SET regDate = NOW(),
memberId = 1,
title = 'title',
`body` = 'content';

# 게시판 테스트 데이터 생성 2
INSERT INTO article
SET regDate = NOW(),
memberId = 2,
title = '제목 1',
`body` = '내용 1';

# 게시판 테스트 데이터 생성 3
INSERT INTO article
SET regDate = NOW(),
memberId = 3,
title = '이것은 제목',
`body` = '이것은 내용';

##########################################

SELECT * FROM `member`;
SELECT * FROM article;

# 개시물 개수 늘리기
INSERT INTO article
( regDate, memberId, title, `body` )
SELECT NOW(), FLOOR(RAND() * 3) + 1, CONCAT('제목 ',RAND()), CONCAT('내용 ',RAND())
FROM article;

SELECT COUNT(*) FROM article;