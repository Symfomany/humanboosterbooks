const { Sequelize } = require('sequelize')

const sequelize = new Sequelize('shop', 'root', null, {
    host: '127.0.0.1',
    dialect: 'mysql'
  });
const { DataTypes, Model } = require('sequelize');
const Product = require('./product');

class Tag extends Model { }

Tag.init({
    title: {
        type: DataTypes.STRING,
        allowNull: false,
    },
  
  }, {
    sequelize,
    modelName: 'Tag',
    freezeTableName: true,
    timestamps: false
  });




module.exports = Tag;