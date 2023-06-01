const { Sequelize } = require('sequelize')

const sequelize = new Sequelize('shop', 'root', null, {
    host: '127.0.0.1',
    dialect: 'mysql'
  });
const { DataTypes, Model } = require('sequelize');

class Comment extends Model { }

Comment.init({
    content: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    readed: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    product_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
  

  }, {
    sequelize,
    modelName: 'Comment',
    freezeTableName: true,
    timestamps: false
  });


module.exports = Comment;