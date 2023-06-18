import { Request, Response, Router } from "express";
import auth from "../middleware/auth";
import User from "../models/User";
import UserType from "../types/User";

const UserRouter = Router();

UserRouter.use('/user', auth);

//Auth
UserRouter.post('/signup', async (req: Request, res: Response) => {
    try {
        if(await User.find(req.body.email)) return res.status(400).send({error: 'Email already in use'})

        const user = await User.save(req.body as UserType);
        
        const token = await user.generateJWT();

        res.send({user, token});

    }catch(er) {
        res.status(400).send({error: er})
    }
})

UserRouter.post('/login',async (req:Request, res:Response) => {
    try {
        const user = await User.find(req.body.email);
    
        if(user == null) return res.status(400).send({error: 'no user with this email'});

        const isValid = await user.checkPassword(req.body.password);

        if(isValid) return res.send({user,token: await user.generateJWT()});

        res.status(400).send({error: 'incorrect password'})

    }catch(er:any) {
        res.status(500).send({error: er.message})
    }
})

//CRUD
UserRouter.get('/user/me', async (req: Request, res:Response) => {
    try {
        return res.send({ user: req.body.user});
    }catch(err:any) {
        res.status(500).send({error: err.message})
    }
});

UserRouter.put('/user/me', async(req: Request, res:Response) => {
    try {
        
        const user: User = req.body.user;

        user.name = req.body.name;

        await user.save()

        res.send({message: 'Updated'})
    }catch(err:any) {
        res.status(500).send({error: err.message })
    }
})

UserRouter.delete('/user/me', async (req: Request, res:Response) => {
    try {
        const user: User = req.body.user;
        
        await user.delete();

        return res.status(201).send()
    }catch(err:any) {
        res.status(500).send({error: err.message})
    }
})

export default UserRouter;