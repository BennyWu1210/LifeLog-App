import mongoose from "mongoose";

const UserSchema = mongoose.Schema({
    id: {
        type: String,
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
    }
})

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

export const Journal = mongoose.model('Journal', journalSchema);
export const Goal = mongoose.model('Goal', goalSchema);
Goal.discriminator('ProcessType', progressTypeSchema);
Goal.discriminator('Todo', todoTypeSchema);



