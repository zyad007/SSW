import pool from "../db/postgres";
import User_AssginmentType from "../types/User_Assignment";

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
            userAssignment.id,
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
}