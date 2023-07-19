const { DataTypes, Model, Sequelize } = require('sequelize');
const Product = require('./product');

const sequelize = new Sequelize('shop', 'root', '', {
  host: 'localhost',
  dialect: 'mysql'
});

class Extras extends Model {
 }

Extras.init({
    product_id: DataTypes.INTEGER,
    poid: DataTypes.FLOAT,
    longueur: DataTypes.FLOAT,
    largeur: DataTypes.FLOAT
}, {
    sequelize,
    tableName: 'extras',
    modelName: 'Extras',
    freezeTableName: true,
    timestamps: false
});

Product.hasOne(Extras,  { foreignKey: 'product_id' })

module.exports = Extras