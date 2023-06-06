import pool from "../db/postgres";
import NoteType from "../types/Note";

class Note {
    id: Number;
    time_in_sec: Number;
    content: String;
    session_id: Number;
    course_id: Number;
	user_id: Number;
	user_course_id: Number;

    constructor(note: NoteType) {
        this.id = note.id as Number
        this.time_in_sec = note.time_in_sec as Number
        this.content = note.content as String
        this.session_id = note.session_id as Number
        this.course_id = note.course_id as Number
        this.user_id = note.user_id as Number
        this.user_course_id = note.user_course_id as Number
    }

    static async save(note: NoteType): Promise<Note> {
        const {rows} = await pool.query('INSERT INTO note (time_in_sec, content, session_id, course_id, user_id, user_course_id) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *'
        ,[note.time_in_sec, note.content, note.session_id, note.course_id, note.user_id, note.user_course_id]);

        return new Note(rows[0]);
    }

    static async findNoteForSession(session_id:Number): Promise<Note[]> {
        const {rows} = await pool.query('SELECT * FROM note WHERE session_id ORDER BY time_in_sec ASC',
        [session_id]);

        rows.map(row => new Note(row));

        return rows;
    }

    
    static async delete(id: Number): Promise<void> {
        await pool.query('DELETE FROM note WHERE id = $1', [id]);
    }

    async delete(): Promise<void> {
        await Note.delete(this.id);
    }
}