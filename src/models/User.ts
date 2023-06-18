import pool from "../db/postgres";
import bcrypt from "bcrypt";
import UserType from "../types/User";
import validator from "validator";
import jwt from "jsonwebtoken"

class User {
    id: number;
    name: string;
    readonly email: string;
    private password: string;

    constructor(user: UserType) {
        this.id = user.id as number;
        this.email = user.email as string;
        this.name = user.name as string;
        this.password = user.password as string;
    }

    static async find(id: number): Promise<User>;
    static async find(email: string): Promise<User> 
    static async find(stringOrNumber: string | number): Promise<User | null>{
        let userDb: UserType | undefined;

        if(typeof stringOrNumber === 'string') {
            const email: string = stringOrNumber;
            const {rows} = await pool.query('SELECT * FROM "user" WHERE email = $1', [email])
            userDb = rows[0]
        }else {
            const id: number = stringOrNumber
            const {rows} = await pool.query('SELECT * FROM "user" WHERE id = $1', [id])
            userDb = rows[0]
        }

        if(!userDb) return null;

        const user = new User(userDb);
        
        return user;
    }

    static async getAll(search: String): Promise<User[]> {
        const users: User[] = [];
        const {rows} = await pool.query('SELECT * FROM "user" WHERE email LIKE %$1%',
        [search]);

        rows.forEach(row => {
            const user: UserType = row;
            users.push(new User(user));
        })
        
        return users;
    }

    static async save(user: UserType): Promise<User> {
        if(!validator.isEmail(user.email as string)) {
            throw new Error('Email not valid');
        }

        const passwordHash: string = await bcrypt.hash(user.password as string, 8);

        const {rows} = await pool.query('INSERT INTO "user" (email,password,name) VALUES ($1,$2,$3) RETURNING *', 
        [user.email,passwordHash,user.name]);
        
        const userModel: UserType = rows[0]; 
        const userDb: User = new User(userModel);

        return userDb;
    }

    async save(): Promise<void> {
        //TODO Add foregin keys
        await pool.query('UPDATE "user" SET name = $1 WHERE id = $2'
        ,[this.name, this.id]);
    }

    static async delete(id: number): Promise<void> {
        await pool.query('DELETE FROM "user" WHERE id = $1', [id]);
    }

    async delete(): Promise<void> {
        await User.delete(this.id);
    }

    async generateJWT(): Promise<String> {
        return jwt.sign({ id: this.id }, 'secret');
    }

    async checkPassword(password: string): Promise<boolean> {
        return await bcrypt.compare(password, this.password);
    }

    async changePassword(newPassword: string, oldPassword:string): Promise<boolean> {
        const isValid = await this.checkPassword(oldPassword);

        if(isValid) {
            this.password = await bcrypt.hash(newPassword, 8);
            pool.query('UPDATE "user" SET password=$1 WHERE id=$2',
            [this.password, this.id]);

            return true;
        }
        return false;
    }

    toJSON() {
        return {
            id: this.id,
            name: this.name,
            email: this.email
        }
    }
}

export default User