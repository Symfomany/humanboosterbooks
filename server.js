const express = require('express')
const app = express()
const port = 3000

const { Sequelize, DataTypes } = require('sequelize')
const { Op } = require("sequelize");
const bodyParser = require('body-parser')
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
app.use(bodyParser.json())

const sequelize = require('./config')
const Extras = require('./models/extras');

const Product = require('./models/product');
const Tag = require('./models/tag');
const Cart = require('./models/cart');
const Comment = require('./models/comment');

app.get('/', (req, res) => {
  res.json('Hello Humman Booster Students!')
})



app.get('/products/last', async (req, res) => {
    try {

        const products = await Product.findAll({
            order: [['price', 'ASC']],
            limit: 10,
            raw: true,
        });
        res.json(products);
    } catch (error) {
              console.log(Product)

        res.status(500).json({ error: 'Internal server error' });
    }
});

app.get('/user', (req, res) => {
  res.json({
    age: 35,
    username: 'Symfomany'
  })
})


const User = sequelize.define("user", {
  nom: DataTypes.STRING(60),
  prenom: DataTypes.STRING(60),
  email: DataTypes.STRING(60),
  age: DataTypes.INTEGER
}, {
    freezeTableName: true,
    timestamps: false
});


app.get('/users', async(req, res) => {
    try {
         // je recupere tous les user en base
        const users = await User.findAll()
        res.json(users)
    } catch (error) {
        console.log(error,"error");
    }
   
})

app.post('/user', async(req, res) => {
    try {
         // je recupere tous les user en base
        const user = User.create({
            nom: req.body.nom,
            prenom: req.body.prenom,
        })
        res.json(true)
    } catch (error) {
        console.log(error,"error");
    }
})


app.get('/extras', async(req, res) => {
  try {
      const extras = await Extras.findAll()
      res.json(extras)
  } catch (error) {
      console.log(error,"error");
  }
})

app.get('/carts', async(req, res) => {
  try {
      const carts = await Cart.findAll();
      res.json(carts);
  } catch (error) {
      console.log(error,"error");
  }
 
})



app.get('/tags', async(req, res) => {
  try {
    const tags = await Tag.findAll()
    res.json(tags)
  } catch (error) {
    console.error(error,"error")
 }

})



app.get('/extras-example', async(req, res) => {
  try {
      const product = await Product.findByPk(1)

      let extra = await product.getExtra()
      res.json(extra)

  } catch (error) {
      console.log(error,"error");
  }
 
})



app.post('/insert-comment', async(req, res) => {
  try {
      let comments = req.body.comments

      let product = await Product.findOne({
        where: {
          title: "Apple Mini"
        }
      })


      comments = comments.map((comment) => {
        return {
          ...comment,
          product_id: product.id
        }
      })

      Comment.bulkCreate(comments)

      res.json(true)
      
  } catch (error) {
      console.log(error,"error");
  }
 
})


app.post('/insert-extras', async(req, res) => {
  try {
      let product = await Product.findOne({
        where: {
          title: "Apple Mini"
        }
      })

      // let extra = await Extras.create({
      //   "longueur": req.body.longueur,
      //    "largeur": req.body.largeur,
      //    "poid": req.body.poid,
      // })

      let extra = new Extras()
      extra.longueur = req.body.longueur
      extra.largeur =  req.body.largeur
      extra.poid =  req.body.poid
      
      await extra.save()

      product.setExtra(extra)
      await product.save()

      console.log(product, "product");

      // await product.save()


      // console.log(extra, "extra")

      res.json(true)
      
  } catch (error) {
      console.log(error,"error");
  }
 
})

app.get('/user-example', async(req, res) => {
  try {
      const cart = await Cart.findOne({created: '2023-06-01 09:56:42'})
      let user = await cart.getUser()

      res.json(user)
      
  } catch (error) {
      console.log(error,"error");
  }
 
})

// Lister les commentaires
app.get('/comments', async(req, res) => {
    try {
         // je recupere tous les user en base
        const comments = await Comment.findAll()
        res.json(comments)
    } catch (error) {
        console.log(error,"error");
    }
   
})

// Route en POST 

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})