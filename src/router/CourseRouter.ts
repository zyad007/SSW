import { Request, Response, Router } from "express";
import auth from "../middleware/auth";
import Course from "../models/Course";
import CourseType from "../types/Course";
import User_Course from "../models/User_Course";
import User from "../models/User";

const CourseRouter = Router();

CourseRouter.use('/course', auth);

//CRUD
CourseRouter.post('/course', async (req:Request, res:Response) => {
    try {
        const course = await Course.save({
            name: req.body.name,
            description: req.body.description,
            teacher_id: req.body.user.id
        } as CourseType);

        return res.send({course})

    }catch(err:any) {
        res.status(500).send({error: err.message})
    }
})

CourseRouter.delete('/course/:id', async (req:Request, res:Response) => {
    try {
        const course = await Course.find(req.params.id as any);

        if(!course) return res.status(404).send({error: 'Course not found'});

        if(course.teacher_id !== req.body.user.id) return res.status(400).send({error: 'Action not allowed for you'});

        course.delete();

        return res.send({message: 'Deleted'});
    }catch(err:any) {
        res.status(500).send({error: err.message});
    }
})

CourseRouter.put('/course/:id', async (req:Request, res:Response) => {
    try {
        const course = await Course.find(req.params.id as any);

        if(!course) return res.status(404).send({error: 'Course not found'});

        if(course.teacher_id !== req.body.user.id) return res.status(400).send({error: 'Action not allowed for you'});

        course.name = req.body.name;
        course.description = req.body.description;
        
        await course.save()

        return res.send({message: 'Updated'});
    }catch(err:any) {
        res.status(500).send({error: err.message});
    }
})

CourseRouter.get('/course/:id', async (req:Request, res:Response) => {
    try {
        const course = await Course.find(req.params.id as any);

        if(!course) return res.status(404).send({error: 'Course not found'});

        return res.send({
            course,
            isTeacher: (course.teacher_id === req.body.user.id)
        })
    }catch(err:any) {
        res.status(500).send({error: err.message});
    }
})

//Relation User
CourseRouter.post('/course/managed', async (req:Request, res:Response) => {
    try {
        const courses = await Course.getTeacherCourses(req.body.user.id);

        return res.send(courses);
    }catch(err:any) {
        res.status(500).send({error: err.message})
    }
})


CourseRouter.post('/course/assigned', async (req:Request, res:Response) => {
    try {
        const user_courses = await User_Course.findAllByUserId(req.body.user.id);

        const courses: Course[] = [];

        for(let i=0; i<user_courses.length; i++) {
            const course = await Course.find(user_courses[i].course_id as number);
            courses.push(course as Course);
        }

        return res.send(courses);
    
    }catch(err:any) {
        res.status(500).send({error: err.message});
    }
})

CourseRouter.post('/course/join', async (req:Request, res:Response) => {
    try {
        const code = req.body.code;

        const course = await Course.findByCode(code);

        if(!course) return res.status(400).send({error: 'Course not found'})

        if(course.teacher_id === req.body.user.id) return res.status(400).send({error: "You can't join as student in your course"})

        const user_course = await User_Course.findByUserIdAndCourseId(course.id as number, req.body.user.id);

        if(user_course) return res.status(400).send({error: "You already joined to this course"});

        await User_Course.save({
            user_id: req.body.user.id,
            course_id: course.id
        });

        course.no_participants += 1;

        res.send(course);
    }catch(err:any) {
        res.status(500).send({error: err.message});
    }
})

CourseRouter.get('/course/:id/students', async (req:Request, res:Response) => {
    try {
        const users_course = await User_Course.findAllByCourseId(Number(req.params.id))

        const users: User[] = [];

        for(let i=0; i<users_course.length; i++) {
            users.push(await User.find(Number(users_course[i].user_id)));
        }

        res.send(users);

    } catch(err:any) {
        res.status(500).send({error: err.message});
    }
})

CourseRouter.delete('/course/:id/students/:studentId', async(req:Request, res:Response) => {
    try {
        const courseId = Number(req.params.id);
        const userId = Number(req.params.studentId)

        const course = await Course.find(courseId);

        if(!course) return res.status(400).send({error: 'Course not found'})

        if(course.teacher_id === req.body.user.id) return res.status(400).send({error: "You can't join as student in your course"})

        const user_course = await User_Course.findByUserIdAndCourseId(courseId, userId);

        if(!user_course) return res.status(400).send({error: "Studnet is not assigned in course"});

        await user_course.delete();

        res.send({message: 'Deleted'})
    }catch(err: any) {
        res.status(500).send({error: err.message});
    }
})

export default CourseRouter;