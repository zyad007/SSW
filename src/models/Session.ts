import pool from "../db/postgres";
import SessionType from "../types/Session";

class Session {
    id: Number;
    title: String;
    description: String;
    course_id: Number;

    constructor(session: SessionType) {
        this.id = session.id as Number;
        this.title = session.title as String;
        this.description = session.description as String;
        this.course_id = session.course_id as Number;
    }

    static async save(session: SessionType): Promise<Session> {

        const {rows} = await pool.query('INSERT INTO session (title,description,course_id) VALUES ($1,$2,$3) RETURNING *', 
        [session.title, session.description, session.course_id ]);
        
        const userCourseDb = rows[0];

        return new Session(userCourseDb);
    }

    async save(): Promise<void> {
        await pool.query('UPDATE session SET title = $1, description = $2 WHERE id = $4'
        ,[this.title, this.description , this.id]);
    }

    static async delete(id: Number): Promise<void> {
        await pool.query('DELETE FROM session WHERE id = $1', 
        [id]);
    }

    async delete(): Promise<void> {
        Session.delete(this.id);
    }


}

export default Session;