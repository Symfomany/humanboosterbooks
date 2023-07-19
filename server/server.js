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

app.get('/genres', async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM genres");

  res.json(results)
})

// Route en POST 

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})