const { DataTypes, Model, Sequelize } = require('sequelize');
const Extras = require('./extras');
const Tag = require('./tag');

console.log(Extras, "Extras")
const sequelize = new Sequelize('shop', 'root', '', {
  host: 'localhost',
  dialect: 'mysql'
});

class Product extends Model {
    test(){
        console.log(`test`)
    }
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

Product.belongsToMany(Tag, { through: 'product_tag',  foreignKey: "product_id"  })
Tag.belongsToMany(Product, { through: 'product_tag', foreignKey: "tag_id" })

module.exports = Product