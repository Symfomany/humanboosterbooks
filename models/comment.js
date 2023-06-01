const { Sequelize } = require('sequelize')

const sequelize = new Sequelize('shop', 'root', null, {
    host: '127.0.0.1',
    dialect: 'mysql'
  });
const { DataTypes, Model } = require('sequelize');
const Product = require('./product');

class Comment extends Model { }

Comment.init({
    content: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
          is: {
           args: /^[0-9a-z ]{3,200}$/i,
           msg: "le commentaire est trop court"
          }
         
        }
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
  
Comment.belongsTo(Product, { foreignKey: "product_id"});
Product.hasMany(Comment, { foreignKey: "product_id"});

module.exports = Comment;