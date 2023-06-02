const { DataTypes, Model, Sequelize } = require('sequelize');
const User = require('./user');


const sequelize = new Sequelize('shop', 'root', '', {
    host: 'localhost',
    dialect: 'mysql'
  });


class Commande extends Model { }


Commande.init({
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    tva: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },
    quantity: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    status: {
        type: DataTypes.ENUM("0", "1", "2"),
        allowNull: false,
    },
   
}, {
    sequelize,
    modelName: 'Commande',
    tableName: 'commande',
    freezeTableName: true,
    timestamps: true
});

User.hasMany(Commande, { foreignKey: "user_id"});
Commande.belongsTo(User, { foreignKey: "user_id"});

module.exports = Commande ;  