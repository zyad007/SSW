import pool from "../db/postgres";
import TimeStampType from "../types/TimeStamp";

class TimeStamp {
    id: Number;
    time_in_sec: Number;
    content: String;
    session_id: Number;

    constructor(time: TimeStampType) {
        this.id = time.id as Number;
        this.time_in_sec = time.time_in_sec as Number;
        this.content = time.content as String;
        this.session_id = time.session_id as Number;
    }

    static async save(time: TimeStampType): Promise<void> {
        await pool.query('ISERT INTO time_stamp (time_in_sec, content, session_id) VALUES ($1,$2,$3)'
        ,[time.time_in_sec, time.content, time.session_id]);
    }

    static async getSessionConent(session_id: Number): Promise<any> {
        const {rows} = await pool.query('SELECT * FROM time_stamp WHERE session_id = $1 ORDER BY time_in_sec ASC',
        [session_id]);

        rows.map(row => new TimeStamp(row));

        return rows;
    }

    static async delete(id: Number): Promise<void> {
        await pool.query('DELETE FROM time_stamp WHERE id = $1', [id]);
    }

    async delete(): Promise<void> {
        await TimeStamp.delete(this.id);
    }
}