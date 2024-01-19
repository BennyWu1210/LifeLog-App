import express from "express";

import "./db/connection.mjs";
import { Journal, Goal } from "./models/model.mjs";

const app = express();
const port = process.env.PORT;

app.use(express.json());
app.use(express.urlencoded({extended: true}));

app.listen(port, () => {
  console.log(`App listening PORT ${port}`)
})


app.post("/journal", (req, res) => {
  console.log(req.body);
  const {title, body} = req.body;
  const journal = new Journal({title: title, body: body});
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
  const goal = new Goal({
    title: 'New Goal',
    body: 'Bill is a super dalao', 
    kind: 'ProgressType',
    current: 2,
    total: 10,
    details: {
      current: 2,
      total: 10
    }
  });
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