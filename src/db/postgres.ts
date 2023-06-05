import { Pool } from "pg";

const pool = new Pool({
    host: 'localhost',
    port: 5432,
    user: 'postgres',
    password: 'postgres',
    database: 'db-poject'
});

export default pool;