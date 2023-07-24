<template>
     <div class="news">  
        <div class="tete"> 
            <h2>Nos nouveautés</h2>
            {{ books.length}} books
        </div>

        <div>
            <p>Nb de couvertures : {{ statsCover }}</p>
            <p>Prix moyen : {{ statsPrice }} €</p>
            <p>Nb de vues : {{ statsViews }}</p>
        </div>
        


     
        
        
        <div>
<<<<<<< HEAD
            <div v-for="book in books" :key="books.id" class="card custom-card">
                
                <div class="bloc_1_entete-card-book">
                    <div>
                        <img :src="book.image" class="rounded imgecover"/>
                    </div>

                    <div>
                        <div class="bl_1_txtentete" >
                            <h3> {{book.title}} </h3>
                            
                           <div class="btn_dispo">
                               <button style="padding: 7px" class="btn" :class="book.disponibility === 1 ? 'btn-success': 'btn-danger'" @click="modifyDisponibility(book.id)">
                                    <span v-if="book.disponibility === 1" > Disponible </span>
                                    <span v-else> Indisponible </span>
                                    <img v-if="book.disponibility === 1"  src="@/assets/accept.png"  alt="" style="width: 15px; height: 15px;"/>
                                    <img v-else  src="@/assets/error.png"  alt="" style="width: 15px; height: 15px;"/>

                                    </button>
                                </button>
                            </div>

                        </div>

                        <div class="infos_books">    
                            <p> Date de publication : {{book.publication_date}} </p>
                            
                            <p> Auteur : {{book.author_fullname}} </p>
                            
                            <p> Edition : {{book.name}} </p>
                            
                            <p class="price"> {{book.price}} €</p>
                        </div>

                        <div class="btn_visible">
                            <p> Visibilité du livre :
                            <span class="fas fa-eye" v-if="book.visible"></span>
                            <span class="fas fa-eye-slash" v-else></span>
                            </p>


                            <button class="btn btn-info"  @click="modifyVisibility(book.id)">Modifier</button>
                        </div>
=======
            <div v-for="book in books" :key="books.id" class = "card custom-card ">
                <img src ="{{}}" alt="">
                <div  >
                    <h3> {{book.title}} </h3>
                    <p v-if="book.disponibility === 1"> Disponible </p>
                    <p v-else> Non disponible </p>
                    <p class="price"> {{book.price}} €</p>
                    <img :src="book.image" />

                </div>
            
                <div>
                    <p> {{book.publication_date}} </p>
                    <p> {{book.author_fullname}} </p>
                    <p> {{book.name}} </p>
                </div>
>>>>>>> f21064da0bd52fd0feee4e4cad67a339987c3a16

                        <div class="desc">
                            <h4> Synopsis </h4>
                            <p>{{book.synopsis}} </p>
                        </div> 
                    </div> 
                </div> 

                <div class="tableau">
                    <h4>Informations supplémentaires :</h4>
                    <table>
                        <tbody>
                            <tr>
                                <td>Nombre de page : </td>
                                <td>Poids : </td>
                                <td>Taille : </td>
                                <td>ISBN : </td>
                                <td>Langue :</td>
                                <td>Type : </td>
                            </tr>
                            <tr>
                                <td>{{book.nb_page}} pages</td>
                                <td>{{book.weight}} kg</td>
                                <td>{{book.size}} cm </td>
                                <td>{{book.isbn}} </td>
                                <td>{{book.lang}}</td>
                                <td>{{book.type}}  </td>
                            </tr>
                        </tbody> 
                    </table>
                </div>
                
            </div>
        </div>
    </div>

</template>


<script>
import axios from 'axios';



export default {
  watch: {
  },
  name: 'Books',
  data(){
    return {
      books : [],
      authors : [],
      books_has_authors : [],
      stats: [],
      statsCover: "",
      statsViews: "",
      statsPrice: "",
      imagecover : [],
      tableau_collection: [],
      


    }
  },


methods: {
  async modifyVisibility(id) {
    await axios.post(`http://localhost:3000/isvisible`, {
      bookid: id
    });

    const resbooks = await axios.get(`http://localhost:3000/newbooks`);
    this.books = resbooks.data;
  },
  async modifyDisponibility(id) {
    await axios.post(`http://localhost:3000/isavailable`, {
      bookid: id
    });

    const resbooks = await axios.get(`http://localhost:3000/newbooks`);
    this.books = resbooks.data;
  }
},

  async created(){

// je charge les liens derriere API
    const resbooks = await axios.get(`http://localhost:3000/newbooks`);
    this.books = resbooks.data

// je charge les liens derriere API
    const resStats = await axios.get(`http://localhost:3000/stats`);
    this.statsCover = resStats.data[0].nombre_livres_couverture
    this.statsViews = resStats.data[0].nombre_vues_totales
    this.statsPrice = resStats.data[0].prix_moyen

    // je charge les liens derriere API
    const rescollection = await axios.get(`http://localhost:3000/collec`);
    this.tableau_collection = rescollection.data




  }

}
</script>




<style>
/* En-tête */
.bloc_en-tete {
    padding:10px;  
}   
.btn span{
    color: white;
}
.tete {
    padding-bottom : 30px;
}

h2{
    font-weight: bold;
}

/* Bloc 1 carte "book" - img + title +date + authors + edition + price + synopsis */

.custom-card {
    border-color : gray ;
    padding-top : 30px;
    padding-right : 25px;
    padding-left : 25px;
}

.bloc_1_entete-card-book {
    display: flex ;
    flex-direction : row;
}

.imgecover{
    width : 257px;
    height : auto;
    padding-bottom : 15px;
}

.bl_1_txtentete{
    align-items : baseline;
    justify-content : space-between;
    padding-left : 30px;
    display : flex; 
    flex-direction : row;
}

.bl_1_txtentete h3{
    font-weight: bold;
    text-align : left;
}

.btn_dispo{
    display : flex ;
    flex-direction : row;
    align-items : baseline;
    padding-left : 30px;
    gap : 10px;
    font-size : 14px;
}

.btn_dispo button{
    font-size : 13px;
    padding-top : 2px;
    padding-bottom : 2px;
    padding-right : 5px;
    padding-left : 5px;
}

.infos_books{
    text-align : left;
    padding-left : 30px;
    padding-top : 10px;
    font-size : 13px;
}

.price{
    font-size : 20px; 
    font-weight: bold;
}

.btn_visible{
    display : flex ;
    flex-direction : row;
    align-items : baseline;
    padding-left : 30px;
    gap : 10px;
}

.btn-info{
    background-color : #5D97E6;
    font-size : 13px;
    padding-top : 2px;
    padding-bottom : 2px;
    padding-right : 5px;
    padding-left : 5px;
}

.desc {
    font-size : 14px;
    text-align: justify;
    padding-left : 30px;
}  

table, td {
    border: 1px solid #333;
    margin-bottom : 30px;
    padding-left : 10px; 
    padding-right : 10px;
    text-align : left;
}

thead, tfoot {
    background-color: #333;
    color: #fff;
}
.tableau h4 {
    text-align : left;
}

</style>