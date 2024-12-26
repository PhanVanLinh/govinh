require('dotenv').config();
const path = require('path')
const express = require('express');
const bodyParser = require('body-parser');
const router = require('./router');
const adminRouter = require('./admin/router');
const app = express();
app.use(express.json())
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'admin'))

app.use(express.static(path.join(__dirname, 'public')))

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.use('/api', router);
app.use('/admin', adminRouter);

// Start the server
const PORT = process.env.PORT || 3008;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
