import pool from "../db/postgres";
import SessionType from "../types/Session";
import User_SessionType from "../types/User_Session";
import Session from "./Session";

class User_Session {
    id: Number;
    user_id: Number;
    course_id: Number;
    session_id: Number;
    user_course_id: Number;

    constructor(user_session: User_SessionType) {
    this.id = user_session.id as Number;
    this.user_id = user_session.user_id as Number;    
    this.course_id = user_session.course_id as Number;
    this.session_id = user_session.session_id as Number;
    this.user_course_id = user_session.user_course_id as Number;    
    }

    static async save(userSession: User_SessionType): Promise<User_Session> {
        const {rows} = await pool.query('INSERT INTO user_assignment (user_id,course_id,session_id,user_course_id) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *', 
        [
            userSession.user_id,
            userSession.course_id,
            userSession.session_id,
            userSession.user_course_id,
        ]);
        
        const userSessionDb = rows[0];
        
        return new User_Session(userSessionDb);
    } 

    static async findAllSessionForUser(user_id:Number, course_id: Number): Promise<Session[]> {
        const assignments: Session[] = [];

        const {rows} = await pool.query('SELECT * FROM session WHERE id = (SELECT session_id FROM user_session WHERE user_id = $1 AND course_id =$2 )'
        ,[user_id, course_id]);

        rows.forEach(row => {
            const assignDb: SessionType = row;
            assignments.push(new Session(assignDb));
        })

        return assignments;
    }

    static async findAllSessionForCourse(course_id:Number): Promise<Session[]> {
        const sessions: Session[] = [];

        const {rows}  = await pool.query('SELECT * FROM session WHERE id = (SELECT course_id FROM user_session WHERE course_id = $1 )'
        , [course_id]);

        rows.forEach(row => {
            const assignDb: SessionType = row;
            sessions.push(new Session(assignDb));
        })

        return sessions;
    }

    static async delete(id: Number): Promise<void> {
        await pool.query('DELETE FROM user_session WHERE id = $1', [id]);
    }

    async delete(): Promise<void> {
        await User_Session.delete(this.id);
    }
}