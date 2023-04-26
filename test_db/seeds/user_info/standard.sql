#SHOULD WORK PRE V10.1.0
INSERT INTO redcap_user_information (ui_id, username, user_email, user_firstname, user_lastname, super_user) VALUES
(1,'test_user1','test_user1@example.com','Test','User1', 0),
(2,'test_user2','test_user2@example.com','Test','User2', 0),
(3,'test_user3','test_user3@example.com','Test','User3', 0),
(4,'test_user4','test_user4@example.com','Test','User4', 0),
(5,'delete_user','delete_user@example.com','User_firstname','User_lastname', 0),
(6,'test_admin','test_admin@example.com','Admin','User', 1);