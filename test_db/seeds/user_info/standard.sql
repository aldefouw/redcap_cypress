#SHOULD WORK PRE V10.1.0
INSERT INTO redcap_user_information (ui_id, username, user_email, user_firstname, user_lastname, super_user) VALUES
(2,'Test_User1','Test_User1@test.edu','Test','User1', 0),
(3,'Test_User2','Test_User2@test.edu','Test','User2', 0),
(4,'Test_User3','Test_User3@test.edu','Test','User3', 0),
(5,'Test_User4','Test_User4@test.edu','Test','User4', 0),
(6,'Test_Admin','Test_Admin@test.edu','Admin','User', 1, 1, 1, 1, 1, 1);