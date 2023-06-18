import express, {Express, Request, Response} from 'express';
import cors from 'cors'
import UserRouter from './router/UserRouter';
import CourseRouter from './router/CourseRouter';
const port = 3000;

const app: Express = express();

app.use(express.json());
app.use(cors());


app.use(UserRouter);
app.use(CourseRouter);

app.get('/', (req:Request, res:Response) => {
    res.send('test')
})

app.listen(port, () => {
    console.log('Server is running at http://localhost:' + port);
})
