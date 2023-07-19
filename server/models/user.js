const { Sequelize } = require('sequelize')

const sequelize = new Sequelize('shop', 'root', null, {
    host: '127.0.0.1',
    dialect: 'mysql'
  });
const { DataTypes, Model } = require('sequelize');
const Cart = require('./cart');

class User extends Model { }

User.init({
    nom: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    prenom: {
        type: DataTypes.STRING,
        allowNull: false,
    },
     email: {
        type: DataTypes.STRING,
        allowNull: false,
    },
  
  }, {
    sequelize,
    modelName: 'User',
    tableName: 'user',
    freezeTableName: true,
    timestamps: true
  });

// Cart.belongsTo(User)
// User.hasMany(Cart,  { as: "cart" });
module.exports = User;