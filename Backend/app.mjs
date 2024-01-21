import express from "express";
import axios from "axios"; // Import axios for HTTP requests

import "./db/connection.mjs";
import { Journal, Goal, User } from "./models/model.mjs";

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


app.post("/signup", async (req, res) => {
  try {
    const { username, hash, salt } = req.body;

    const userExists = await User.findOne({ username: username });
    if (userExists) {
      return res.status(409).send('Username already exists'); // 409 Conflict
    }
    // Store the user in the database
    const newUser = await User({ id: Math.random() * 3000, username: username, hash: hash, salt: salt, profilePicPath: "", journals: [], goals: []});
    newUser.save().then(result => {
      res.send(result);
    })
    .catch(err => {
      res.status(500).send('An error occurred');
      console.log(err);
    });


    // debug
    console.log("############ signup ###############")
    User.find().then(result=>{
      console.log(result);
    });
    

  } catch (err) {
    console.log(err);
    res.status(500).send('An error occurred');
  }
});


app.post("/login", async (req, res) => {
  try {
    const { inputUsername, inputPassword } = req.body;

    console.log("######## login ########\n" + inputUsername + " " + inputPassword);

    // Find user by username
    const user = await User.findOne({ username: inputUsername });
    if (!user) {
      return res.status(400).send('Cannot find user');
    }

    // Compare provided password with stored hashed password
    const isMatch = verifyPassword(inputPassword, user.hash, user.salt);
    if (!isMatch) {
      console.log("WTF");
      return res.status(400).send('Invalid credentials');
    }

    res.send({user: user});

    console.log("username: " + inputUsername);
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

// Helper Functions (Hashing purposes)
import crypto from "crypto";

function hashPassword(password, salt) {
  // Create a SHA-256 hash with the password and salt
  const hash = crypto.createHash('sha256');
  hash.update(password + salt);
  const hashedPassword = hash.digest('base64'); // Convert to base64
  return hashedPassword;
}

function verifyPassword(inputPassword, storedHash, salt) {
  // Hash the input password with the same salt
  const inputHash = hashPassword(inputPassword, salt);
  // Compare the input hash with the stored hash
  return inputHash === storedHash;
}