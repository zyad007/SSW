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

    //CRUD
    static async find(id: number): Promise<Course | null> {
        let courseDb : CourseType | undefined;
        
        const {rows} =  await pool.query('SELECT * FROM course WHERE id = $1', [id]);
        courseDb = rows[0];

        if(!courseDb) return null;

        return new Course(courseDb);
    }

    static async findAll(): Promise<Course[]> {
        const courses: Course[] = [];

        const {rows} = await pool.query('SELECT * FROM course');

        rows.forEach(row => {
            const course: CourseType = row;
            courses.push(new Course(course));
        })
        
        return courses;
    }

    static async save(course: CourseType): Promise<Course> {

        const {rows} = await pool.query('INSERT INTO course (name,description,no_participants) VALUES ($1,$2,$3) RETURNING *', 
        [course.name,course.description,0]);
        
        const courseDb = rows[0];

        return new Course(courseDb);
    }

    async save(): Promise<void> {
        await pool.query('UPDATE course SET name = $1, description = $2, no_participants = $3   WHERE id = $4'
        ,[this.name, this.description, this.no_participants, this.id]);
    }

    static async delete(id: Number): Promise<void> {
        await pool.query('DELETE FROM course WHERE id = $1', [id]);
    }

    async delete(): Promise<void> {
        await Course.delete(this.id);
    }

    //User Relation


    toJSON() {
        return {
            id: this.id,
            name: this.name,
            description: this.description,
            no_participants:this.no_participants
        }
    }

}

export default Course;