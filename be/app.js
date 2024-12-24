const express = require('express');
const app = express();
const port = 3000;

// Middleware to parse JSON
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.listen(3008, () => {
  console.log(`Server is running at http://localhost:3008`);
});
