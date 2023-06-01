const { DataTypes, Model, Sequelize } = require('sequelize');
const Extras = require('./extras');

console.log(Extras, "Extras")
const sequelize = new Sequelize('shop', 'root', '', {
  host: 'localhost',
  dialect: 'mysql'
});

class Product extends Model {
 }

Product.init({
    title: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    description: {
        type: DataTypes.TEXT,
        allowNull: false,
    },
    price: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },

}, {
    sequelize,
    tableName: 'product',
    modelName: 'Product',
    freezeTableName: true,
    timestamps: false
});


module.exports = Product