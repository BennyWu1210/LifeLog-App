import dotenv from "dotenv";
import mongoose from "mongoose";

// load from process.env
dotenv.config();

// connect to MongoDB database
mongoose.connect(process.env.ATLAS_URI)
    .catch(err => console.log(err));

export default mongoose;