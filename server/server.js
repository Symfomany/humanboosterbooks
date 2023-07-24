const express = require("express");
const app = express();
const port = 3000;
const cors = require("cors");

const { Sequelize, DataTypes } = require("sequelize");
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

app.post("/addresses", async (req, res) => {
  let zipcode = req.body.zipcode;
  let city = req.body.city;

  const [results, metadata] = await sequelize.query(`
    INSERT INTO addresses (zipcode, city) VALUES ("${zipcode}", "${city}")
  `);

  res.json(results);
});

app.get("/orders", async (req, res) => {
  const limit = req.query.limit > 0 ? parseInt(req.query.limit) : 5;
  const sortBy = "id";
  const [results, metadata] = await sequelize.query(
    `SELECT * FROM orders ORDER BY ${sortBy} DESC LIMIT ${limit}`
  );
  res.json(results);
});

app.get("/orders/stats", async (req, res) => {
  const [results, metadata] = await sequelize.query(
    `SELECT COUNT(*) AS nb_orders_by_stats ,status FROM orders GROUP BY status;`
  );
  res.json(results);
});
app.post;

app.post("/orders/:id", async (req, res) => {
  const status = req.body.status;
  let result = "";
  if (
    req.params.id > 0 &&
    (status == "en cours" ||
      status == "livré" ||
      status == "non livré" ||
      status == "traité")
  ) {
    const id = parseInt(req.params.id);
    await sequelize.query(
      `UPDATE orders SET status = "${status}" WHERE orders.id = ${id}`
    );
    result = "success";
  } else {
    result = "error, invalid url or parameters";
  }

  return res.json(result);
});

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

//route pour delete les commentaires
app.post('/delete-comments', async (req, res) => {

  let delete_comments = req.body.id

  const [results, metadata] = await sequelize.query (
      `DELETE FROM comments WHERE id = ${delete_comments}`
  );
  return res.json({success : true});
});

// Route en POST

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
