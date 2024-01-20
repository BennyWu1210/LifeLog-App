import express from "express";
import axios from "axios"; // Import axios for HTTP requests

import "./db/connection.mjs";
import { Journal, Goal } from "./models/model.mjs";

const app = express();
const port = process.env.PORT;

app.use(express.json());
app.use(express.urlencoded({extended: true}));

app.post("/generate-quote", async (req, res) => {
  try {
    const apiUrl = "https://api.openai.com/v1/chat/completions";
    const apiKey = process.env.OPENAI_API_KEY; // Load API key from environment variables

    if (!apiKey) {
      return res.status(500).send("API key not found");
    }

    const { prompt } = req.body; // Extract prompt from request body

    const response = await axios.post(apiUrl, {
      model: "gpt-3.5-turbo",
      messages: [{
        role: "user",
        content: prompt
      }],
      max_tokens: 200,
      temperature: 0.85,
    }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${apiKey}`,
      },
    });

    if (response.status === 200) {
      const data = response.data;
      const quote = data.choices[0].message.content;
      res.json({ quote });
    } else {
      console.error('Failed to generate quote:', response.data);
      res.status(response.status).send('Failed to generate quote');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send('An error occurred');
  }
});


app.listen(port, () => {
  console.log(`App listening PORT ${port}`)
})


app.post("/signup", (req, res) => {
  try {
    const { username, password } = req.body;
  } catch (err) {
    console.log(err);
    res.status(500).send('An error occurred');
  }
});


app.post("/login", (req, res) => {
  try {
    const { username, password } = req.body;
    res.json({
      "username": username,
      "password": password
    });
    console.log("username: " + username);
  } catch (err) {
    console.log(err);
    res.status(500).send('An error occurred');
  }
});



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