#SHOULD WORK PRE V10.1.0
INSERT INTO redcap_user_information (ui_id, username, user_email, user_firstname, user_lastname, super_user) VALUES
(2,'test_user1_cypress','test_user1@example.com','Test','User1', 0),
(3,'test_user2_cypress','test_user2@example.com','Test','User2', 0),
(4,'test_user3_cypress','test_user3@example.com','Test','User3', 0),
(5,'test_user4_cypress','test_user4@example.com','Test','User4', 0),
(6,'delete_user_cypress','delete_user@example.com','User_firstname','User_lastname', 0),
(7,'test_admin_cypress','test_admin@example.com','Admin','User', 1, 1, 1, 1, 1, 1);