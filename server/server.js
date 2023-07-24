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

// une route pour récupérer les utilisateurs
app.get('/users', async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM users ORDER BY date_created DESC");

  return res.json(results)
})

// une route pour récupérer et compter les utilisateurs actifs et inactifs
app.get('/status_users_count', async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT enable, COUNT(*) AS nombre_utilisateurs FROM users GROUP BY enable");
  
  return res.json(results)

})
  //route pour récup les profiles et les lier aux users
app.get('/profiles', async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM profiles LEFT JOIN users ON users.profile_id = profiles.id");

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

app.post('/users', async (req, res) => {
  
  let fname = req.body.fname
  let lname =  req.body.lname
  let age =  req.body.age
  let email =  req.body.email
  let pswd =  req.body.pswd
  let pid = req.body.pid
  


  const [results, metadata] = await sequelize.query(`
    INSERT INTO users (firstname, lastname, age, email, password, profile_id, enable, date_auth, date_created) VALUES ("${fname}", "${lname}", "${age}", "${email}", "${pswd}", "${pid}", "0", "2023-06-28T00:00:00.000Z", "2023-06-07T00:00:00.000Z")
  `);

  res.json(results)
})

app.post('/profiles', async (req, res) => {
  
  let dob = req.body.dob
  let lang =  req.body.lang
  let phone =  req.body.phone

  const [results, metadata] = await sequelize.query(`
    INSERT INTO profiles (dob, lang, phone, geoloc, token) VALUES ("${dob}", "${lang}", "${phone}", POINT(18, -63), SHA1(RAND()))
  `);

  res.json(results)
})

//Pouvoir supprimer un utilisateur
app.delete('/users/:id', async (req, res) => {
  const userId = req.params.id;
  try {
    // Supprimer l'utilisateur en fonction de l'ID spécifié
    const deletedUser = await sequelize.query(`DELETE FROM users WHERE id = ${userId}`);
    res.json({ message: 'Utilisateur supprimé avec succès' });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la suppression de l\'utilisateur' });
  }
});

app.post('/users/:id', async (req, res) => {
  const userActivId = req.params.id;
  const activateButton = await sequelize.query(`
    UPDATE users SET enable = "1" WHERE users.id = ${userActivId}
  `);
})


// Route en POST 

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})