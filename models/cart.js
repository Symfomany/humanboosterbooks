const { DataTypes, Model, Sequelize } = require('sequelize');
const User = require('./user');


const sequelize = new Sequelize('shop', 'root', '', {
    host: 'localhost',
    dialect: 'mysql'
  });


class Cart extends Model { }


Cart.init({
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    promotion_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    created: {
        type: DataTypes.DATE,
        allowNull: false,
    },
   
}, {
    sequelize,
    modelName: 'Cart',
    tableName: 'panier',
    freezeTableName: true,
    timestamps: false
});

Cart.belongsTo(User,  { foreignKey: 'user_id'});
User.hasMany(Cart,  { foreignKey: "user_id"});

module.exports = Cart ;  