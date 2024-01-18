import express from "express";

import "./db/connection.mjs";
import { Journal, Goal } from "./models/model.mjs";

const app = express();
const port = process.env.PORT;

app.listen(port, () => {
  console.log(`App listening PORT ${port}`)
})


app.post("/journal", (req, res) => {
  const journal = new Journal({title: 'New Journal', body: 'Bill is a super dalao'});
  journal.save()
  .then(result => {
    res.send(result);
  })
  .catch(err => {
    console.log(err);
  });

});

app.get("/journal", (req, res) => {
  Journal.find()
    .then(result => {
      res.send(result);
    })
    .catch(err => {
      console.log(err);
    });

});

app.post("/goal", (req, res) => {
  const goal = new Goal({title: 'New Goal', body: 'Bill is a super dalao'});
  goal.save()
  .then(result => {
    res.send(result);
  })
  .catch(err => {
    console.log(err);
  });
});


app.get("/goal", (req, res) => {
  Goal.find()
  .then(result => {
    res.send(result);
  })
  .catch(err => {
    console.log(err);
  });
});