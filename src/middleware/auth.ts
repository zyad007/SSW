import { Request, Response } from "express"
import jwt from 'jsonwebtoken';
import User from "../models/User";

const auth = async (req: Request, res: Response, next: Function) => {
    try {
        let token = req.header('Authorization') as string;
        token = token.replace('Bearer ', '');
        const decoded: any = jwt.verify(token, 'secret')
        const user = await User.find(decoded.id);

        if(!user) return res.status(404).send({error: 'User not found'}); 

        req.body = {
            ...req.body,
            user,
            token
        };

        next();
    } catch(err) {
        res.status(401).send({ error: 'User not authenticated' })
    }
}

export default auth;