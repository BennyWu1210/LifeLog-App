import mongoose from "mongoose";

const journalSchema = mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    body: {
        type: String,
        required: true
    }
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



