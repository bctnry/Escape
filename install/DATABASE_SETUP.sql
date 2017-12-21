CREATE TABLE Users (
    ID INT AUTO_INCREMENT NOT NULL,
    Name VARCHAR(64) UNIQUE,
    Password VARCHAR(60),
    PRIMARY KEY (ID)
);

CREATE TABLE Blogposts (
    ID INT AUTO_INCREMENT NOT NULL,
    Date DATETIME,
    UserID INT,
    Title VARCHAR(128),
    Body TEXT,
    PRIMARY KEY (ID),
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

CREATE TABLE Comments (
    ID INT AUTO_INCREMENT NOT NULL,
    PostID INT,
    Date DATETIME,
    Name VARCHAR(128),
    Body TEXT,
    PRIMARY KEY (ID),
    FOREIGN KEY (PostID) REFERENCES Blogposts(ID)
);

CREATE TABLE SessionControl (
    UserID INT,
    Hashval VARCHAR(60),
    FOREIGN KEY (UserID) REFERENCES Users(ID)
);

CREATE TABLE Configurations (
    Blogname VARCHAR(128),
    CurrentTemplate VARCHAR(64)
);

CREATE PROCEDURE RETRIEVE_BLOGPOSTS() READS SQL DATA
    SELECT * FROM Blogposts ORDER BY Date DESC;
CREATE PROCEDURE RETRIEVE_BLOGPOSTS_RAW() DETERMINISTIC READS SQL DATA
    SELECT * FROM Blogposts;
CREATE PROCEDURE RETRIEVE_BLOGPOST_BY_ID(IN id INT) READS SQL DATA
    SELECT * FROM Blogposts WHERE Blogposts.ID = id;
CREATE PROCEDURE RETRIEVE_COMMENTS_AT(IN id INT) NOT DETERMINISTIC READS SQL DATA
    SELECT * FROM Comments WHERE Comments.PostID = id;
CREATE PROCEDURE RETRIEVE_COMMENT_BY_ID(IN cid INT) NOT DETERMINISTIC READS SQL DATA
    SELECT * FROM Comments WHERE Comments.ID = cid;
CREATE PROCEDURE INSERT_COMMENT_FOR(
    IN id INT, IN date DATETIME, IN name VARCHAR(128), IN body TEXT
) NOT DETERMINISTIC MODIFIES SQL DATA
    INSERT INTO Comments VALUES (NULL, id, date, name, body);
CREATE PROCEDURE INSERT_POST(
    IN date DATETIME, IN userid INT, IN title VARCHAR(128), IN body TEXT
) MODIFIES SQL DATA
    INSERT INTO Blogposts VALUES (NULL, date, userid, title, body);
CREATE PROCEDURE RETRIEVE_BLOGPOST_TITLE(IN id INT) NOT DETERMINISTIC READS SQL DATA
    SELECT Blogposts.Title FROM Blogposts WHERE Blogposts.ID = id;
CREATE PROCEDURE RETRIEVE_BLOGPOST_ID_WITH_COMMENT_ID(IN cid INT) NOT DETERMINISTIC READS SQL DATA
    SELECT Comments.PostID FROM Comments WHERE Comments.ID = cid;
CREATE PROCEDURE MODIFY_BLOGPOST(
    IN id INT, IN title VARCHAR(128), IN body TEXT
) NOT DETERMINISTIC MODIFIES SQL DATA
    UPDATE Blogposts SET Blogposts.Title = title, Blogposts.Body = body
    WHERE Blogposts.ID = id;
CREATE PROCEDURE MODIFY_COMMENT(
    IN id INT, IN name VARCHAR(128), IN body TEXT
) NOT DETERMINISTIC MODIFIES SQL DATA
    UPDATE Comments SET Comments.Name = name, Comments.Body = body
    WHERE Comments.ID = id;
CREATE PROCEDURE MODIFY_COMMENT_WITH_DATE_UPDATE(
    IN cid INT, IN date DATETIME, IN name VARCHAR(128), IN body TEXT
) MODIFIES SQL DATA
    UPDATE Comments SET Comments.Name = name, Comments.Body = body, Comments.Date = date
    WHERE Comments.ID = cid;
CREATE PROCEDURE DELETE_BLOGPOST(IN id INT) MODIFIES SQL DATA
    DELETE FROM Blogposts WHERE Blogposts.ID = id;
CREATE PROCEDURE DELETE_COMMENT(IN cid INT) MODIFIES SQL DATA
    DELETE FROM Comments WHERE Comments.ID = cid;

CREATE PROCEDURE IF_COMMENT_EXISTS_UNDER(IN id INT) READS SQL DATA
    SELECT EXISTS (SELECT * FROM Comments WHERE Comments.PostID = id);

CREATE PROCEDURE CHECK_HASHVAL(IN userid INT, IN hashval VARCHAR(60)) READS SQL DATA
    SELECT EXISTS (SELECT * FROM SessionControl WHERE SessionControl.Hashval = hashval AND SessionControl.UserID = userid);
CREATE PROCEDURE CREATE_USER(IN name VARCHAR(64), IN password VARCHAR(60))
    INSERT INTO Users VALUES (NULL, name, password);
CREATE PROCEDURE DELETE_USER(IN userid INT)
    DELETE FROM Users WHERE Users.ID = userid;
CREATE PROCEDURE RETRIEVE_USER_PASSWORD(IN userid INT)
    SELECT Users.Password FROM Users WHERE Users.ID = userid;

CREATE PROCEDURE CLEAR_USER_SESSION(IN userid INT)
    DELETE FROM SessionControl WHERE SessionControl.UserID = userid;
CREATE PROCEDURE INSERT_LOGIN_HASH(IN userid INT, IN hashval VARCHAR(60))
    INSERT INTO SessionControl VALUES (userid, hashval);

CREATE PROCEDURE RETRIEVE_USER_PASSWORD_BY_NAME(IN username VARCHAR(64))
    SELECT Users.Password FROM Users WHERE Users.Name = username;

CREATE PROCEDURE INSERT_USER(IN username VARCHAR(64), IN password VARCHAR(60))
    INSERT INTO Users VALUES (NULL, username, password);

CREATE PROCEDURE RETRIEVE_USER_ID_BY_NAME(IN username VARCHAR(64))
    SELECT Users.ID FROM Users WHERE Users.Name = username;
CREATE PROCEDURE RETRIEVE_USERNAME(IN userid INT)
    SELECT Users.Name FROM Users WHERE Users.ID = userid;

CREATE PROCEDURE RETRIEVE_USERS()
    SELECT * FROM Users;

CREATE PROCEDURE MODIFY_USER_BY_ID(IN userid INT, IN username VARCHAR(64), IN hashval VARCHAR(60))
    UPDATE Users SET Users.Name = username, Users.Password = hashval
    WHERE Users.ID = userid;

CREATE PROCEDURE RETRIEVE_CURRENT_TEMPLATE()
    SELECT CurrentTemplate FROM Configurations;
CREATE PROCEDURE RETRIEVE_CURRENT_BLOGNAME()
    SELECT Blogname FROM Configurations;


CREATE PROCEDURE SET_BLOGNAME(IN newBlogName VARCHAR(128))
    UPDATE Configurations SET Configurations.Blogname = newBlogName
CREATE PROCEDURE SET_CURRENT_TEMPLATE(IN newTemplateName VARCHAR(64))
    UPDATE Configurations SET Configurations.CurrentTemplate = newTemplateName


DELIMITER //
CREATE PROCEDURE INSERT_POST_EXACT(
  IN newPostID INT, IN newPostDate DATETIME,
  IN newPostUserID INT, IN newPostTitle VARCHAR(128),
  IN newPostBody TEXT
) BEGIN
  DELETE FROM Blogposts WHERE BLogposts.ID = newPostID;
  INSERT INTO Blogposts(ID,Date,UserID,Title,Body)
    VALUES (newPostID,newPostDate,newPostUserID,newPostTitle,newPostBody);
END
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE INSERT_COMMENT_EXACT(
    IN newCommentID INT, IN newCommentPostID INT,
    IN newCommentDate DATETIME, IN newCommentName VARCHAR(128),
    IN newCommentBody TEXT
) BEGIN
  DELETE FROM Comments WHERE Comments.ID = newCommentID;
  INSERT INTO Comments(ID,PostID,Date,Name,Body)
    VALUES (newCommentID,newCommentPostID,newCommentDate,newCommentName,newCommentBody);
END
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE INSERT_USER_EXACT(
    IN userID INT, IN userName VARCHAR(64), IN userPassword VARCHAR(60)
) BEGIN
  DELETE FROM Users WHERE Users.ID = userID;
  INSERT INTO Users(ID,Name,Password) VALUES (userID,userName,userPassword);
END
//
DELIMITER ;