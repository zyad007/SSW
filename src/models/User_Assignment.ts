import pool from "../db/postgres";
import AssignmentType from "../types/Assignemnt";
import User_AssginmentType from "../types/User_Assignment";
import Assignment from "./Assignment";
import Course from "./Course";

class User_Assginment {
    id: Number;
    user_id: Number;
    course_id: Number;
    assignment_id: Number;
    user_course_id: Number;

    grade: Number;
    comments: String;
    sub_url: String;

    constructor(userAssignment: User_AssginmentType) {
        this.id = userAssignment.id as Number;
        this.user_id = userAssignment.user_id as Number;
        this.course_id = userAssignment.course_id as Number;
        this.assignment_id = userAssignment.assignment_id as Number;
        this.user_course_id = userAssignment.user_course_id as Number;

        this.grade = userAssignment.grade as Number;
        this.comments = userAssignment.comments as String;
        this.sub_url = userAssignment.sub_url as String;
    }

    static async save(userAssignment: User_AssginmentType): Promise<User_Assginment> {
        const {rows} = await pool.query('INSERT INTO user_assignment (user_id,course_id,assignment_id,user_course_id,comments,sub_url) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *', 
        [
            userAssignment.user_id,
            userAssignment.course_id,
            userAssignment.assignment_id,
            userAssignment.user_course_id,
            userAssignment.comments,
            userAssignment.sub_url,
        ]);
        
        const userAssignDb = rows[0];
        
        return new User_Assginment(userAssignDb);
    } 

    async save(): Promise<void> {
        await pool.query('UPDATE user_assignment SET comments = $1, sub_url = $2, grade = $3 WHERE id = $4'
        ,[this.comments, this.sub_url, this.grade, this.id]);
    }

    static async findAllAssignmentForUser(user_id:Number, course_id: Number): Promise<Assignment[]> {
        const assignments: Assignment[] = [];

        const {rows} = await pool.query('SELECT * FROM assignment WHERE id = (SELECT assignment_id FROM user_assignment WHERE user_id = $1 AND course_id =$2 )'
        ,[user_id, course_id]);

        rows.forEach(row => {
            const assignDb: AssignmentType = row;
            assignments.push(new Assignment(assignDb));
        })

        return assignments;
    }

    static async findAllAssignemntForCourse(course_id:Number): Promise<Assignment[]> {
        const assignments: Assignment[] = [];

        const {rows}  = await pool.query('SELECT * FROM assignment WHERE id = (SELECT course_id FROM user_assignment WHERE course_id = $1 )'
        , [course_id]);

        rows.forEach(row => {
            const assignDb: AssignmentType = row;
            assignments.push(new Assignment(assignDb));
        })

        return assignments;
    }

    static async findAvgGradeForCourseAssigment(course_id: Number, assignment_id: Number): Promise<Number> {
        const {rows} = await pool.query('SELECT AVG(grade) FROM user_assignment WHERE course_id = $1 AND assignment_id = $2',
        [course_id, assignment_id]);

        return rows[0];
    }

    static async delete(id: Number): Promise<void> {
        await pool.query('DELETE FROM user_assignment WHERE id = $1', [id]);
    }

    async delete(): Promise<void> {
        await User_Assginment.delete(this.id);
    }
}