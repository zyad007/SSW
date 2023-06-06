import pool from "../db/postgres";
import User_CoureType from "../types/User_Course";
import Course from "./Course";
import User from "./User";

class User_Course {
    id: Number;
    role: String;
    course_id: Number;
    user_id: Number;

    constructor(userCourse: User_CoureType) {
        this.id = userCourse.id as Number;
        this.role = userCourse.role as String;
        this.course_id = userCourse.course_id as Number;
        this.user_id = userCourse.user_id as Number;
    }

    static async save(userCourse: User_CoureType): Promise<User_Course> {

        const {rows} = await pool.query('INSERT INTO user_course (role,course_id,user_id) VALUES ($1,$2,$3) RETURNING *', 
        [userCourse.role, userCourse.course_id, userCourse.user_id ]);
        
        const userCourseDb = rows[0];

        return new User_Course(userCourseDb);
    }

    async save(): Promise<void> {
        await pool.query('UPDATE user_course SET role = $1 WHERE id = $2'
        ,[this.role, this.id]);
    }

    static async delete(id: Number): Promise<void> {
        await pool.query('DELETE FROM user_course WHERE id = $1', [id]);
    }

    async delete(): Promise<void> {
        await User_Course.delete(this.id);
    }

    static async findById(id: number): Promise<User_Course | null> {
        let userCourseDb : User_CoureType | undefined;
        
        const {rows} =  await pool.query('SELECT * FROM user_course WHERE id = $1', [id]);
        userCourseDb = rows[0];

        if(!userCourseDb) return null;

        return new User_Course(userCourseDb);
    }

    static async findAllByCourseId(courseId: number): Promise<User_Course[]> {
        const userCourses :User_Course[] = [];
        
        const {rows} = await pool.query('SELECT * FROM user_course WHERE course_id = $1'
        ,[courseId]);

        rows.forEach(row => {
            const userCourseDb: User_CoureType = row;
            userCourses.push(new User_Course(userCourseDb));
        });

        return userCourses;
    }

    static async findAllByUserId(courseId: number): Promise<User_Course[]> {
        const userCourses :User_Course[] = [];
        
        const {rows} = await pool.query('SELECT * FROM user_course WHERE user_id = $1'
        ,[courseId]);

        rows.forEach(row => {
            const userCourseDb: User_CoureType = row;
            userCourses.push(new User_Course(userCourseDb));
        });

        return userCourses;
    }

    static async findStudentsForCourse(courseId: Number): Promise<User[]> {
        const students: User[] = [];

        const {rows} = await pool.query('SELECT * FROM "user" WHERE id = (SELECT user_id FROM user_course WHERE course_id = $1 AND role = "STUDENT")',
        [courseId]);

        rows.forEach(row => {
            const userDb = row;
            students.push(new User(userDb));
        })

        return students;
    }

    static async findCoursesForUser(userId: Number): Promise<Course[]> {
        const courses: Course[] = [];

        const {rows} = await pool.query('SELECT * FROM course WHERE id = (SELECT course_id FROM user_course WHERE user_id = $1)',
        [userId]);

        rows.forEach(row => {
            const courseDb = row;
            courses.push(new Course(courseDb));
        })

        return courses;
    }

    static async isUSerInCourse(user_id: Number, course_id:Number): Promise<User> {
        const {rows} = await pool.query('SELECT * FROM "user" WHERE id IN (SELECT user_id FROM user_course WHERE course_id = $1 AND user_id = $2)',
        [user_id, course_id]);

        return new User(rows[0]);
    }

    
    
}

export default User_Course;