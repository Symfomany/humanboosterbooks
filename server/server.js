const express = require("express");
const app = express();
const port = 3000;
const cors = require("cors");

const { Sequelize, DataTypes, Association } = require("sequelize");
const { Op } = require("sequelize");
const bodyParser = require("body-parser");
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));
// parse application/json
app.use(bodyParser.json());

// CORS CSRF
app.use(cors());

const sequelize = require("./config");

app.get("/", async (req, res) => {
  res.json("Hello Humman Booster Students!");
});

app.get("/contact", async (req, res) => {
  res.json("Ma page de contact");
});

// une route pour lister les adresses
app.get("/addresses", async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM addresses");

  return res.json(results);
});

// une route pour lister les links
app.get("/links", async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM links");

  return res.json(results);
});

app.get("/authors", async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM authors");
  return res.json(results);
});

app.get("/editors", async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM editors");

  return res.json(results);
});

app.get("/title-books", async (req, res) => {
  const [results, metadata] = await sequelize.query(
    "SELECT books.title, authors.firstname, authors.lastname FROM authors INNER JOIN books_has_authors ON authors.id = books_has_authors.author_id INNER JOIN books ON books_has_authors.books_id = books.id GROUP BY books.id ORDER BY books.publication_date ASC LIMIT 5"
  );
  return res.json(results);
});

app.post("/detail-auteur", async (req, res) => {
  let id = req.body.id;

  const [results, metadata] = await sequelize.query(
    "SELECT * FROM `authors` WHERE authors.id = :id",
    {
      replacements: { id: id },
    }
  );
  return res.json(results);
});

app.post("/addresses", async (req, res) => {
  let zipcode = req.body.zipcode;
  let city = req.body.city;

  const [results, metadata] = await sequelize.query(`
    INSERT INTO addresses (zipcode, city) VALUES ("${zipcode}", "${city}")
  `);

  res.json(results);
});

// Route en POST

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
