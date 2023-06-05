-------------------------------- Creating Tables Schema for the Application -----------------------------------
---------------------------------------------------------------------------------------------------------------
-- USER:
-- is the main user of the system
---------------------------------------------------------------------------------------------------------------
CREATE TABLE "user" (
    id INT PRIMARY KEY NOT NULL,
    email VARCHAR(50) NOT NULL,
    name VARCHAR(50),
    password VARCHAR(255)
);
---------------------------------------------------------------------------------------------------------------
-- COURSE: 
-- is the course that contains all the students and instructors and allow the instructor
-- to create Code Sessions for students to watch and take Notes, and also allow the
-- instructor to add assigments for the students to be submitted.
---------------------------------------------------------------------------------------------------------------
CREATE TABLE course (
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(50),
    description VARCHAR(255),
    no_participants INT
);

-- Many To Many joint table between the Course and User
CREATE TABLE user_course (
    id INT PRIMARY KEY NOT NULL,
    role VARCHAR(50),

    course_id INT,
	CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES course(id) ON DELETE CASCADE,

	user_id INT,
	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES "user"(id) ON DELETE CASCADE
);

-- Many To One joint table between the Messages and Course
CREATE TABLE chat_message (
	id INT PRIMARY KEY NOT NULL,
    content VARCHAR(255),
    user_name VARCHAR(50),

    course_id INT,
	CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES course(id) ON DELETE CASCADE
)
---------------------------------------------------------------------------------------------------------------
-- ASSIGNEMNT:
-- is the assignment that the instructor assign for the students within the course, as the course 
-- will have multiple assigments and the user must submit all the assigment
---------------------------------------------------------------------------------------------------------------

-- Creating the Assignment Table that is Many to One with the Course
CREATE TABLE assignment (
	id INT PRIMARY KEY NOT NULL,
	title VARCHAR(50),
	description VARCHAR(255),
	file_url VARCHAR(255),

	course_id INT,
	CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES course(id) ON DELETE CASCADE
);

-- Many To Many joint table between the Assignment and User_Course
CREATE TABLE user_assignment (
	id INT PRIMARY KEY NOT NULL,
	comments VARCHAR(255),
	sub_url VARCHAR(255),

	course_id INT,
	CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES course(id) ON DELETE CASCADE,

	user_id INT,
	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES "user"(id) ON DELETE CASCADE,

	user_course_id INT,
	CONSTRAINT fk_user_course FOREIGN KEY(user_course_id) REFERENCES user_course(id) ON DELETE CASCADE,

	assignment_id INT,
	CONSTRAINT fk_assignment FOREIGN KEY(assignment_id) REFERENCES assignment(id) ON DELETE CASCADE
);

---------------------------------------------------------------------------------------------------------------
-- SESSION:
-- is the core entity of the application as it stores the IDE code in every second within the Session and
-- allow the IDE to preview the code as video format and allow the student to interact with code in every
-- second.
---------------------------------------------------------------------------------------------------------------

-- Creating the Session Table that is Many to One with the Course
CREATE TABLE session (
	id INT PRIMARY KEY NOT NULL,
	title VARCHAR(50),
	description VARCHAR(255),
    
	course_id INT,
	CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES course(id) ON DELETE CASCADE
);

-- Many To Many joint table between the Session and User_Course
CREATE TABLE user_session (
	id INT PRIMARY KEY NOT NULL,

	course_id INT,
	CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES course(id) ON DELETE CASCADE,

	user_id INT,
	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES "user"(id) ON DELETE CASCADE,

	user_course_id INT,
	CONSTRAINT fk_user_course FOREIGN KEY(user_course_id) REFERENCES user_course(id) ON DELETE CASCADE,

	session_id INT,
	CONSTRAINT fk_session FOREIGN KEY(session_id) REFERENCES session(id) ON DELETE CASCADE
);

-- Many To One joint table between the Time_Stamp and Session
CREATE TABLE time_stamp (
    id INT PRIMARY KEY NOT NULL,
    time_in_sec INT,
    content VARCHAR(255),

    session_id INT,
	CONSTRAINT fk_session FOREIGN KEY(session_id) REFERENCES session(id) ON DELETE CASCADE
);

---------------------------------------------------------------------------------------------------------------
-- NOTES:
-- this entity stores the Student Note of the code he edited with the time stamp when he edited
-- it allow the user to retrain the code notes he writed when he was in the Code Session.
---------------------------------------------------------------------------------------------------------------

-- Many To One joint table between the Note and User_Session
CREATE TABLE note (
    id INT PRIMARY KEY NOT NULL,
    time_in_sec INT,
    content VARCHAR(255),

    session_id INT,
	CONSTRAINT fk_session FOREIGN KEY(session_id) REFERENCES session(id) ON DELETE CASCADE,

    course_id INT,
	CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES course(id) ON DELETE CASCADE,

	user_id INT,
	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES "user"(id) ON DELETE CASCADE,

	user_course_id INT,
	CONSTRAINT fk_user_course FOREIGN KEY(user_course_id) REFERENCES user_course(id) ON DELETE CASCADE
);

---------------------------------------------------------------------------------------------------------------
----------------------------------------- Database Queries ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- USER
---------------------------------------------------------------------------------------------------------------
-- INSERT:
INSERT INTO "user" (email,password,name) VALUES ('zyad@mail.com','$teajasc#15727123sdasDSAQ','Zyad Sallem') RETURNING *   --ID = 1
INSERT INTO "user" (email,password,name) VALUES ('bichoy@mail.com','$teajasc#15727123sdasDSAQ','Bichoy Atef') RETURNING * --ID = 2
INSERT INTO "user" (email,password,name) VALUES ('ahmed@mail.com','$teajasc#15727123sdasDSAQ','Ahmed Osama') RETURNING *  --ID = 3

-- SELECT:
-- select by email or Id
SELECT * FROM "user" WHERE email = 'zyad@mail.com'
SELECT * FROM "user" WHERE id = 1

-- log in:
SELECT * FROM "user" WHERE email = 'zyad@mail.com' AND password = '$teajasc#15727123sdasDSAQ'

-- DELETE:
-- delete using email or Id
DELETE FROM "user" WHERE id = 1
DELETE FROM "user" WHERE email = 'zyad@mail.com'

-- UPDATE:
UPDATE "user" SET name = 'Zyad Abdel-Nasser' WHERE id = 1
---------------------------------------------------------------------------------------------------------------
-- COURSE
---------------------------------------------------------------------------------------------------------------
--INSERT:
INSERT INTO course (name, description, no_participants) VALUES ('C++','This is the C++ course', 0) RETURNING *                 --ID = 1
INSERT INTO course (name, description, no_participants) VALUES ('Javascript','This is the Javascript course', 0) RETURNING *   --ID = 1

-- ASSIGNING STUDENT AND REMOVING THEM:

-- asign student in the course using student_id and course_id:
INSERT INTO user_course (user_id, course_id, role) VALUES (1, 1, 'STUDENT')

-- remove student from course:
DELETE user_course WHERE user_id = 1 AND course_id = 1

-- CREATING SESSION WITHIN COURSE:
