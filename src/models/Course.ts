import pool from "../db/postgres";
import CourseType from "../types/Course";
import utils from "../utils/utils";

class Course {
    id: Number;
    name: String;
    description: String;
    no_participants: number;
    teacher_id: Number;
    code: String;

    constructor(course: CourseType) {
        this.id = course.id as Number;
        this.description = course.description as String;
        this.name = course.name as String;
        this.no_participants = course.no_participants as number;
        this.teacher_id = course.teacher_id as Number;
        this.code = course.code as String;
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

        const courses = await Course.findAll()
        let code = utils.makeid(8);
        
        let flag = true;

        while(flag) {
            code = utils.makeid(8);
            
            if(courses.length === 0) break;

            for(let i=0; i<courses.length; i++) {
                flag = false;
                if(courses[i].code === code){
                    code = utils.makeid(8);
                    flag = true;
                    break;
                }
            }
        }

        const {rows} = await pool.query('INSERT INTO course (name,description,no_participants,teacher_id,code) VALUES ($1,$2,$3,$4,$5) RETURNING *', 
        [course.name,course.description,0,course.teacher_id,code]);
        
        const courseDb = rows[0];

        return new Course(courseDb);
    }

    static async findByCode(code:string): Promise<Course> {
        const {rows} = await pool.query('SELECT * FROM course WHERE code = $1',
        [code]);

        return rows[0];
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
    static async getTeacherCourses(teacher_id:Number): Promise<Course[]> {
        const {rows} = await pool.query('SELECT * FROM course WHERE teacher_id = $1',
        [teacher_id]);

        rows.map(row => new Course(row as CourseType))

        return rows
    }

    toJSON() {
        return {
            id: this.id,
            name: this.name,
            description: this.description,
            no_participants:this.no_participants,
            teacher_id:this.teacher_id,
            code:this.code
        }
    }

}

export default Course;