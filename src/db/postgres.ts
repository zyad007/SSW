import { Pool } from "pg";

const pool = new Pool({
    host: 'localhost',
    port: 5432,
    user: 'postgres',
    password: 'postgres',
    database: 'sw-2'
});

export default pool;