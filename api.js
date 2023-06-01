console.log('Go !')

// connection base de données

// j'inclus ma  librarie
const { Sequelize, DataTypes } = require('sequelize')
const { Op } = require("sequelize");


// la connexion avec ma base de données local en root qui s'appel shop
const sequelize = new Sequelize('shop', 'root', '', {
  host: 'localhost',
  dialect: 'mysql'
});


async function connection(){

    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');



    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
}

connection()

// Modelisation de ma table product
const Product = sequelize.define("product", {
  title: DataTypes.TEXT,
  description: DataTypes.TEXT,
  price: DataTypes.FLOAT,
  enabled: DataTypes.BOOLEAN
}, {
        freezeTableName: true,
        timestamps: true
});

(async () => {
  await sequelize.sync({ alter: true });

  try {
    // Créer un produit en base
    // const product = await Product.create({
    //     title: 'Produit 1',
    //     description: 'test de Produit 1',
    //     price: 10
    // },)

    // const products = await Product.findAll({
    //    attributes: ['title'],
    //    where: {
    //     price: {
    //         [Op.eq]: 10
    //     }
    //   }
    // })
    // console.log(products, "products");

    //  const products = await Product.findAll({
    //    attributes: ['title', 'price'],
    //    where: {
    //      [Op.or]: [
    //       { price:  [50, 100] },
    //     ]
    //   }
    // })

    //  console.log(products, "products");


     // sortir les 5 derniers produits (titre, description) 
     // créer en base qui contienne
     // le mot clef Apple dans le titre et qui soit activés
const products = await Product.findAll({
            where: {
                title: {
                    [Op.like]: '%Apple%'
                },
                enabled: true
            },
            order: [['createdAt', 'DESC']],
            limit: 5
        });

        console.log("nb products", products);


        products.forEach((product) => {
            console.log(`Titre: ${product.title}`);
            console.log(`Description: ${product.description}`);
        });


// sortir le titre et le prix des produit égal à 50 ou 100 euros

    // products.forEach((product) =>{
    //   console.log(product.title)
    // })
    

    // console.log(products[0].title, "product");


    

  } catch (error) {
      console.log("error",error);
  }
  

  // Code here
})();




