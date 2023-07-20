const { Sequelize, DataTypes } = require("sequelize");

// init configuration in localhost
<<<<<<< HEAD
const sequelize = new Sequelize("books_shop", "root", "", {
=======
const sequelize = new Sequelize("book_shop", "root", "", {
>>>>>>> af0919934599eb05b2b9b7236eb27d0424f7fcc6
  host: "localhost",
  dialect: "mysql",
});

/**
 * Create connection
 */
async function connection() {
  try {
    // create authentificate in connexion
    await sequelize.authenticate();
    console.log("Connection has been established successfully.");
  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
}

// run connection Mysql
connection();

module.exports = sequelize;
