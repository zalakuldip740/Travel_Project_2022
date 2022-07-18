import express, { Express, Request, Response } from 'express';
import mongoose from 'mongoose';

import * as dotenv from 'dotenv';
import { verifyToken, checkRequest } from "./authentication/verify_token";
import * as admin from 'firebase-admin';
import credential from "./travelproject22-6b9d4-firebase-adminsdk-2wiay-c9c1876710.json";

const app: Express = express();
const connection = mongoose.connect('mongodb://localhost:27017/mmtdata');
dotenv.config();
const port = process.env.PORT;
app.use(express.json());

// ROUTER
import { router as hotelroute } from './controller/hotel_controller';
import { router as tourroute } from './controller/tour_controller';
import { router as cityroute } from './controller/city_controller';
import { router as roomroute } from './controller/room_controller';
import { router as userroute } from './controller/user_controller';
import { router as reviewroute } from './controller/review_controller';
import { router as bookingroute } from './controller/booking_controller';

// FIREBASE INTITIALIZE
admin.initializeApp(
    {
        credential: admin.credential.cert(JSON.parse(JSON.stringify(credential)))
    }
);




// TOKEN VERIFICATION CALL
app.use(verifyToken, checkRequest);


// ROOT LEVEL
app.get('/', (req: Request, res: Response) => {
    res.send('MMT Backend development');
    res.end();
});

// USE
app.use('/hotel', hotelroute);
app.use('/room', roomroute);
app.use('/tour', tourroute);
app.use('/city', cityroute);
app.use('/user', userroute);
app.use('/review', reviewroute);
app.use('/booking',bookingroute);

// LISTEN
app.listen(port, () => {
    console.log(`⚡️[server]: Server is running at ${port}`);
});
