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
app.delete("/authors/:id", async (req, res) => {
  const id = req.params.id;
  const [results, metadata] = await sequelize.query(
    `DELETE FROM authors WHERE authors.id = ${id}`
  );
});

app.post("/detail-auteur", async (req, res) => {
  let id = req.body.id;

  const [results, metadata] = await sequelize.query(
    "SELECT * FROM `authors` INNER JOIN images ON images.id = authors.images_id INNER JOIN books_has_authors ON authors.id = books_has_authors.author_id INNER JOIN books ON books_has_authors.books_id = books.id WHERE authors.id = :id",
    {
      replacements: { id: id },
    }
  );
  return res.json(results);
});

app.get("/nb_author", async (req, res) => {
  const [results, metadata] = await sequelize.query(
    "SELECT COUNT(AUTHORS.id) AS nb_author FROM authors;"
  );
  return res.json(results);
});
app.post("/authors", async (req, res) => {
  const author = req.body.newAuthor;
  const [results, metadata] = await sequelize.query(
    `INSERT INTO authors (firstname, lastname, biography) VALUES ("${author.firstname}", "${author.lastname}", "${author.biography}")`
  );
  return res.json(results);
});

app.get("/nb_editor", async (req, res) => {
  const [results, metadata] = await sequelize.query(
    "SELECT COUNT(editors.id) AS nb_editor FROM editors;"
  );
  return res.json(results);
});

app.get("/editors", async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT * FROM editors");

  return res.json(results);
});

app.post("/addresses", async (req, res) => {
  let zipcode = req.body.zipcode;
  let city = req.body.city;
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

  res.json(results);
});

app.get("/editors_name_nb_books", async (req, res) => {
  const [results, metadata] = await sequelize.query("SELECT editors.name, COUNT(books.id) AS nb_books FROM editors INNER JOIN editors_has_books ON editors.id = editors_has_books.editors_id INNER JOIN books ON editors_has_books.books_id = books.id GROUP BY editors.id, editors.name;");

  return res.json(results);
});

// Route en POST

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
