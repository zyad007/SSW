import { Pool } from "pg";

// const pool = new Pool({
//     host: 'localhost',
//     port: 5432,
//     user: 'postgres',
//     password: 'postgres',
//     database: 'sw-2'
// });

const pool = new Pool({
    host: 'surus.db.elephantsql.com',
    port: 5432,
    user: 'nysdhenx',
    password: '9PNYSlRuFQGeU4rKF2MeizbB5PEjHJ-N',
    database: 'nysdhenx'
});

export default pool;