import mongoose from "mongoose";


const journalSchema = mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    body: {
        type: String,
        required: true
    },
    
}, {timestamps: true});

const progressTypeSchema = mongoose.Schema({
    current: {
        type: Number,
        required: true
    },
    total: {
        type: Number,
        required: true
    }
});


const todoTypeSchema = mongoose.Schema({
    completed: {
        type: Boolean,
        required: true
    }
});

const goalSchema = mongoose.Schema({
    title: {
        type: String,
        required: true
    },
}, {timestamps: true, discriminatorKey: 'kind'})



const UserSchema = mongoose.Schema({
    // do we use uuid for this?
    id: {
        type: Number,
        required: true
    },
    username: {
        type: String,
        required: true
    },

    // auth: password + stored salt + stored hash = verified
    hash: {
        type: String,
        required: true
    },
    salt: {
        type: String,
        required: true
    },

    profilePicPath: {
        type: String,
    },

    journals: {
        type: [journalSchema],
        required: true
    },
    goals: {
        type: [goalSchema],
        required: true
    }

})


export const Journal = mongoose.model('Journal', journalSchema);
export const Goal = mongoose.model('Goal', goalSchema);
export const User = mongoose.model('User', UserSchema);
Goal.discriminator('ProgressType', progressTypeSchema);
Goal.discriminator('TodoType', todoTypeSchema);


