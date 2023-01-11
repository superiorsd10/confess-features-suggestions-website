const express = require("express");
const mongoose = require("mongoose");
const cors = require('cors')

const app = express();

require("dotenv").config();

mongoose.set('strictQuery', true);
mongoose.connect(process.env.MONGO_DB_URL, { useNewUrlParser: true });
const con = mongoose.connection;

con.on('open', ()=>{
    console.log('Database Connected!');
});

app.use(express.json());
app.use(cors());

const suggestionRouter = require('./routes/suggestions');
app.use('/suggestions', suggestionRouter);

app.listen(3000, ()=>{
    console.log('Server is running!');
});

module.exports = app;