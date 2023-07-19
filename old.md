// j'inclus ma  librarie
const { Sequelize, DataTypes } = require('sequelize')
const { Op } = require("sequelize");


// la connexion avec ma base de données local en root qui s'appel bookshop
const sequelize = new Sequelize('bookshop', 'root', '', {
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


/*
 La personne la plus jeune qui est commenté un produit Apple
 durant ces 3 derniers mois
 */

SELECT u.nom
FROm user AS u
    INNER JOIN comment as c ON c_id = u.id
    INNER JOIN product as pr ON pr.id = c.product_id
WHERE
    c.created > DATE_SUB(CURDATE, INTERVAL 3 MONTH)
    AND c.created < NOW()
SELECT
    YEAR(c.created) AS yearComment,
    pr.id,
    pr.title,
    COUNT(*) AS commentCount
FROM comment AS c
    INNER JOIN product as pr ON pr.id = c.product_id
GROUP BY yearComment
ORDER BY
    yearComment,
    commentCount DESC
LIMIT
    3
    /*
     (Niveau 2) Le nom de l'utilisateur ayant déjà commenté le plus jeune et le plus vieux.
     */
    /*
     Créer une table "extras" pour stocker le poids, la longueur et la largeur du produit.
     1 produit possède un seul et unique extra (1-1)
     Remplir la table extras de nos produits.
     Calculer la moyenne (AVG) du poids total  (2e requete) puis le nom du produit le plus lourds.
     Bonus: calculer le volume total  de tous les produits qui n'ont pas encore de promotions 
     */
SELECT p.title
FROM `extras` AS e
    INNER JOIN product AS p ON p.id = e.product_id
ORDER BY e.poid DESC
LIMIT 1
SELECT
    SUM(e.longeur * e.largeur) AS volume
FROM extras AS e
    INNER JOIN product AS p ON p.id = e.product_id
    INNER JOIN product_promotion AS pp ON pp.product_id = p.id
    INNER JOIN promotion AS pr ON pr.id = pp.promotion_id
WHERE NOT EXIST (
        SELECT pp.product_id
        FROM
            product_promotion
        WHERE
            product.id = pp.product_id
    )
    /*
     Modifier le prix des produits en ajoutant 10 euros qui ont au moins 2 commentaires
     */
    /*
     Supprimer les commentaires de l'année 2020 ou qui comporte une longueur 
     en dessous de 10  caractères
     */
    /*
     Pouvoir gérer les tags des produits de notre boutique. Un tag est un mot-clefs ou expressions
     pouvant être associés à plusieurs produits.
     Bonus: Afficher le nombre de tags qui ont une longueur d'au moins 6 caractères
     */
...SELECT COUNT(title)
FROm tag
WHERE
    LENGTH(title) >= 6
    /*
     Pouvoir gérer les commandes de produits des utilisateurs.
     Nous pourrons gérer une tva, une date de commande ainsi qu'une quantité de produit commandés par l'utilisateurs
     ainsi qu'un status (type ENUM). 
     */
    /*
     Ajouter la gestion de du panier (table) aux produits et aux utilisateurs.
     Un utilisateur pourra voir les articles qu'il a dans son panier ainsi que la quantité,
     la date de mise en panier et une promotion (optionnelle) pourra même etre appliquer sur le panier.
     
     Puis calculer le panier moyen de cette année 
     pour les utilisateurs utilisant GMAIL et qui sont seniors (Plus de 60 ans)
     */
SELECT
    AVG(pp.quantite * p.price)
FROM panier as p
    INNER JOIN user as u ON u.id = p.user_id
    INNER JOIN product_panier AS pp ON p.id = pp.product_id
    INNER JOIN product as pr ON pr.id = pp.product_id
WHERE
    email REGEXP '@gmail(.com|.fr)$'
    AND age > = 60
    /*
     Créer une colonne password avec la commande ALTER TABLE dans la table user,
     Afficher les 5 derniers utilisateurs inscrits en affichant les 4 premiers caractères
     du mot de passe et cryptés le reste par des étoiles (*)
     ... 
     */
WHERE SUBSTRING(
        password
        FROM
            1 FOR 4
    )
    /*
     /*
     Afficher les ids des utilisateurs qui ont un mot de passe valide: comportant au moins
     1 majuscule, 1 numéro et 1 caractères spécial (accéptés: @&#_-)
     */
    /*
     J'affiche le nombre de mot que comporte la description de produit dont le jour est le 25  
     */
    /*
     Je calcule la moyenne du nb de commentaire par mois qui sont écris entre 2 et 4 semaines
     */
    /*
     Les 3 produits qui ont le plus de commentaires par année (created)
     */
SELECT
    YEAR(c.created) AS yearComment,
    pr.id,
    pr.title,
    COUNT(*) AS commentCount
FROM comment AS c
    INNER JOIN product as pr ON pr.id = c.product_id
GROUP BY yearComment
ORDER BY
    yearComment,
    commentCount DESC
LIMIT
    3 Identifiants Udemy: Email: julien.boyer @wildcodeschool.fr Mdp: jecode4lyon69
SELECT COUNT(c.id) as nbComm
FROM `comment` as c
    INNER JOIN product as p ON p.id = c.product_id
    INNER JOIN user as u ON c.user_id = u.id
WHERE u.prenom = ' Julien '
GROUP BY p.id;

/*
 Incrémenter de 1 le nb de vue dont l'id du book est 3
 */

/*
 Modifier a la date d'ajourd'hhui les livres disponible et en couvertures
 */

SELECT title, synopsis
FROM books
WHERE (
        type = "numerique"
        OR type = "papier"
    )
    AND (
        publication_date > DATE_SUB(NOW(), INTERVAL 3 MONTH)
        AND publication_date < NOW()
    );

Remplir votre base de données avec des données factices Remplir 5 utilisateurs dans la
table
    user et profile Récuperer 2 nom et prénoms (concatener) des utilisateurs activés (enable) qui ont GMAIL et qui se sont connecter sous les 72 heures Modifier les tokens des utilisateur en les generant aléatoirement avec la fonction SHA1() Récuperer les noms et age des utilisateurs majeurs français qui ont renseignés un numéro de téléphone portable Récupérer le téléphone de l 'utilisateur français le plus vieux 

Afficher le 2 premier caractères du mot de passe des utilisateurs qui sont activés (enable) suivis des étoiles

Afficher 2 addresse du Rhône commençant par 69

Afficher les auteurs qui n' ont pas été primmé (prize) Compter le nombre de livres en couverture et qui n 'ont pas de collection

Afficher la moyenne du nombre de vue des commentaires publier ce mois-ci

Concatener le nom et prénom des auteurs dont la biographie fait minimum 15 mots

Compter le nombre d' edition dont le logo est un JPEG de Wikipédia Afficher les images des livres qui ont une miniature et qui soit un gif de Giphy Calculer la moyenne des prix HT de toutes les commandes passées dont le status est traitées et de TVA 10 % Afficher le prix Total TTC à partir du prix HT en prennant en compte le bon d 'achat, la TVA

Compter le nombre de relation (relationship) que dispose le bouqin numéro 1

Compter le nombre d' utilisateur quit ont GMAIL,
    actif et dont la date de connexion est comprise entre le 2 février 2021 et il y a 5 semaines Totaliser et afficher dans 1 champs le nombre de vue plus le nombre de likes que totalise l 'auteur numéro 2

Afficher l' age moyen des utilisateurs,
    puis l 'age maximum et l' age minimum Compter le nombre de parrainages par utilisateurs (
        GROUP BY
    ) Calculer les ages des profiles a partir de la dob puis afficher l 'affiche du profil le plus agée






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



app.get('/notifications', async (req, res) => {
    try {
      
      let notifications = await  Notification.find({})
      res.json(notifications);
    } catch (error) {
              console.log(Product)

        res.status(500).json({ error: 'Internal server error' });
    }
});



app.post('/notifications', async (req, res) => {
    try {
      
      let notifications = new  Notification()
      notifications.title ="Nouveau"
      notifications.created = new Date()
      await notifications.save()

      res.json(notifications);
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


app.get('/product/:pid/addtag', async (req, res) => {
  try {
    await sequelize.sync();
    const product = await Product.findByPk(req.params.pid);

    const tagOne = await Tag.findByPk(2);
    const tagTwo = await Tag.findByPk(3);
     await product.addTag(tagOne)
     await product.addTag(tagTwo)

    res.json(true);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: 'Erreur lors de la récupération des utilisateurs.' });
  }
});


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



app.post('/product-example', async(req, res) => {
  try {
        await sequelize.sync();
      const products = await Product.findAll({
        include: {
           model: Tag,
           where: { title: { [Op.eq]: req.body.title } },
        }
      })
      
      res.json(products)

  } catch (error) {
      console.log(error,"error");
  }
 
})


app.get('/product-with-comment', async(req, res) => {
  try {
      await sequelize.sync();
      const products = await Product.create({
        title: "Apple TV",
        description: "la TV Apple",
        price: 25,
        comment: [
          {content: "Super télé!"}
        ]
      
      },
      {
        include: [Comment]
      }
      )
      
      res.json(true)

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
