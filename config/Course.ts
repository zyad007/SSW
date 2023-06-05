import pool from "../db/postgres";
import CourseType from "../types/Course";

class Course {
    id: Number;
    name: String;
    description: String;
    no_participants: Number;

    constructor(course: CourseType) {
        this.id = course.id as Number;
        this.description = course.description as String;
        this.name = course.name as String;
        this.no_participants = course.no_participants as Number;
    }

    static async find(id: number): Promise<Course | null> {
        let courseDb : CourseType | undefined;
        
        const {rows} =  await pool.query('SELECT * FROM course WHERE id = $1', [id]);
        courseDb = rows[0];

        if(!courseDb) return null;

        return new Course(courseDb);
    }

    static async findAll(): Promise<Course[]> {
        const courses: Course[] = [];

        const {row} = await pool.query('SELECT * FROM course');
    }

}