

#SHOULD WORK PRE V10.1.0
INSERT INTO redcap_user_information (ui_id, username, user_email, user_firstname, user_lastname, super_user) VALUES
(2,'test_user','test_user@example.com','Test','User',0),
(4,'test_user2','test_user2@example.com', 'Test','User',0),
(6,'test_admin','test_admin@example.com','Test','User',1);
