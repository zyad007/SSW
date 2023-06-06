import pool from "../db/postgres"
import MessageType from "../types/Message"

class Message {
    id: Number
    content: String
    user_name: String

    course_id: Number

    constructor(message: MessageType) {
        this.id = message.id as Number;
        this.content = message.content as String;
        this.user_name = message.user_name as String;
        this.course_id = message.course_id as Number;        
    }

    static async save(message: MessageType): Promise<void> {
        await pool.query('INSERT INTO chat_message (content, user_name, course_id) VALUES ($1,$2,$3)',
        [message.content, message.user_name, message.course_id]);
    }

    static async getAllCourseMessages(course_id: Number, search: String): Promise<Message[]> {
        const message: Message[] = [];

        const {rows} = await pool.query('SELECT * FROM chat_message WHERE course_id = $1 AND (content LIKE %$2% OR user_name LIKE %$2%)'
        ,[course_id, search]);

        rows.map(row => new Message(row));

        return rows;
    }

    static async delete(id: Number): Promise<void> {
        await pool.query('DELETE FROM chat_message WHERE id = $1', [id]);
    }

    async delete(): Promise<void> {
        await Message.delete(this.id);
    }
}