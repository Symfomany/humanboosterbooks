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
const User = require('./models/user');
const Commande = require('./models/commande');

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

app.get('/users/commande', async (req, res) => {
  try {
    const users = await User.findAll({
      limit: 3,
      order: [['createdAt', 'DESC']],
      include: [{
        model: Commande,
        order: [['createdAt', 'DESC']],
        limit: 1
      }]
    });

    res.json(users);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: 'Erreur lors de la récupération des utilisateurs.' });
  }
});



app.get('/extras-example', async(req, res) => {
  try {
      const product = await Product.findByPk(1)

      let extra = await product.getExtra()
      res.json(extra)

  } catch (error) {
      console.log(error,"error");
  }
 
})



app.post('/product/tag', async(req, res) => {
  try {
      const products = await User.findAll({
         include: Commande
      })
      
      res.json(products)

  } catch (error) {
      console.log(error,"error");
  }
 
})



app.get('/product-example', async(req, res) => {
  try {
      const products = await Product.findAll({
        include: Comment 
      })
      
      res.json(products)

  } catch (error) {
      console.log(error,"error");
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


app.post('/product/:pid/comment/add', async(req,res) => {

  try {
    let product = await Product.findByPk(req.params.pid)
    // let comment = new Comment()
    // comment.content = req.body.content
    // comment.readed = 0
    // comment.user_id = 2
    // comment.setProduct(product)

    // await comment.save()

    await Comment.findOrCreate({
      where: { content: req.body.content },
       defaults: {
       content: req.body.content,
       user_id: 2,
       product_id: product.id,
       readed: 0
      }
    })

   res.json(product)
  } catch (error) {
    res.status(403).send(error.message)
  }


})

app.delete('/product/delete', async(req,res) => {

  try {
    let title = req.body.title
    const product = await Product.findOne({ title });
    console.log(product, "product");

    await product.destroy();

    // await Product.destroy({
    //   where: {
    //     title
    //   },
    //   // force: true
    // });

    res.json(true)
  } catch (error) {
     console.log("error", error);
  }


})


app.get('/avgcart/:uid', async(req,res) => {

  try {
   let user = await User.findByPk(req.params.uid)
  
   let paniers= await user.getCarts()
   res.json(paniers)



  } catch (error) {
     console.log("error", error);
  }


})


app.get('/product/:pid/comments', async(req,res) => {

  try {
   let product = await Product.findByPk(req.params.pid)
  
   let comments= await product.getComments()

    let comment = await Comment.findByPk(3)
  
   console.log(await comment.getProduct())

   res.json(comments)
  } catch (error) {
     console.log("error", error);
  }


})


app.get('/user/:uid/commande', async(req,res) => {

  try {
   let user = await User.findByPk(req.params.uid)
  
   let commandes= await user.getCommandes()

   commandes = commandes.filter((commande) => commande.status == "1")

   res.json(commandes)
  } catch (error) {
     console.log("error", error);
  }


})


app.get('/user/:uid/cart', async(req,res) => {

  try {
   let user = await User.findByPk(req.params.uid)
  
   let paniers= await user.getCarts()
   res.json(paniers)
  } catch (error) {
     console.log("error", error);
  }


})

app.get('/avgproductprice', async(req,res) => {

   const products = await Product.findAll ()

   let moyenne = products.reduce((a,b) =>a.price + b.price) / products.length

  // const avg = await Product.findOne (
  //   {attributes: [
  //    [sequelize.fn('AVG', sequelize.col('price')), 'moyenne_prix']
  // ]})
res.json(moyenne)
})

app.get('/tag-example', async(req, res) => {
  try {
      let product = await Product.findOne({
        where: {
          title: "Apple Mini"
        }
      })


      let tag = await Tag.findOne({
        include: Product,
        where: {
          title: "Sport"
        }
      })

      let tags = await product.getTags()
      let products = await tag.getProducts()


      res.json(products)
      
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