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

// une route pour récupérer les livres
app.get('/newbooks', async (req, res) => {
const [results, metadata] = await sequelize.query
("SELECT books.*, images.image FROM books  INNER JOIN images ON books.images_id = images.id WHERE visible = 1 ORDER BY books.publication_date DESC LIMIT 5");

  return res.json(results)
})

// une route pour récupérer les stats
app.get('/stats', async (req, res) => {
  const [results, metadata] = await sequelize.query
  ("SELECT COUNT(*) AS nombre_livres_disponibles, SUM(CASE WHEN cover = '1' THEN 1 ELSE 0 END) AS nombre_livres_couverture, SUM(views) AS nombre_vues_totales, AVG(price) AS prix_moyen FROM books");
  
    return res.json(results)
  })


// une route pour récupérer les auteurs
app.get('/newAuthors', async (req, res) => {
  const [results, metadata] = await sequelize.query
  ("SELECT CONCAT(authors.firstname, ' ', authors.lastname) AS author_fullname FROM authors INNER JOIN books_has_authors ON authors.id = books_has_authors.author_id INNER JOIN books ON books_has_authors.books_id = books.id");
  
    return res.json(results)
  })

 

app.post('/addresses', async (req, res) => {
  
  let zipcode = req.body.zipcode
  let city =  req.body.city

  const [results, metadata] = await sequelize.query(`
    INSERT INTO addresses (zipcode, city) VALUES ("${zipcode}", "${city}")
  `);

  res.json(results)
})


// Route en POST 

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})