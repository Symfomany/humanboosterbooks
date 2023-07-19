const { Sequelize, DataTypes } = require('sequelize')

// init configuration in localhost
const sequelize = new Sequelize('bookshop', 'root', '', {
  host: 'localhost',
  dialect: 'mysql'
});

/**
 * Create connection
 */
async function connection(){
    try {
        // create authentificate in connexion
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');

    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}

// run connection Mysql
connection()

module.exports = sequelize