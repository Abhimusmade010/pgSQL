-- create a table named users with columns id, username, email, password, created_at

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- insert data into users table
insert into users (username, email, password) values ('abhishek','abhishek@example.com','password123');

-- get all users from users table
select * from users;


-- update the username of the user with id 1
update users set username = 'abhishek123' where id = 1;

-- update the password of the user with email 'abhishek@example.com'
UPDATE users
SET password = 'new_password'
WHERE email = 'abhishek@example.com';


-- delete the user with id 1
delete from users where id = 1;


-- drop the users table
drop table users;
