import pool from "./db/postgres";

pool.query('SELECT * FROM "user"')
.then(res => {
    console.log(res.rows);
}).catch(e => {
    console.log(e);
});