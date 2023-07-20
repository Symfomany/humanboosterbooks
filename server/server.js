const express = require('express')
const app = express()
const port = 3000
const cors = require('cors')

const { Sequelize, DataTypes } = require('sequelize')
const { Op } = require("sequelize");
const bodyParser = require('body-parser')
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
app.use(bodyParser.json())

// CORS CSRF
app.use(cors())


const sequelize = require('./config')



app.get('/', async (req, res) => {
  res.json('Hello Humman Booster Students!')
})



app.get('/contact', async (req, res) => {
  res.json('Ma page de contact')
})


// une route pour lister les adresses
app.get('/addresses', async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM addresses");

  return res.json(results)
})

// une route pour lister les links
app.get('/links', async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM links");

  return res.json(results)
})



// une route pour récupérer la vidéo
app.get('/ma-video', async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT video, title FROM videos WHERE id = 1");

  return res.json(results[0])
})




app.post('/addresses', async (req, res) => {
  
  let zipcode = req.body.zipcode
  let city =  req.body.city

  const [results, metadata] = await sequelize.query(`
    INSERT INTO addresses (zipcode, city) VALUES ("${zipcode}", "${city}")
  `);

  res.json(results)
})

//une route pour les commentaires
app.get("/comments", async (req, res) => {
  const limit = req.query.limit > 0 ? parseInt(req.query.limit) : 10;
  const sortBy = "id";
  const[results, metadata] = await sequelize.query(
      `SELECT c.*, u.lastname, u.firstname, b.title FROM comments c JOIN users u ON c.users_id = u.id JOIN books b ON c.books_id = b.id ORDER BY ${sortBy} Desc LIMIT ${limit}`);
  const[count] = await sequelize.query(
      `SELECT COUNT(id) AS nbCount FROM comments`
  );
  res.json({results,count});
    });



// Route en POST 

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})