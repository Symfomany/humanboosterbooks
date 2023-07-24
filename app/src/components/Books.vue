<template>
     <div class="bloc_en-tete">  
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
            <div v-for="book in books" :key="books.id" class = "card custom-card ">
                
                <div class="bloc_1_entete-card-book">
                    <div>
                        <img :src="book.image" class = "imgecover"/>
                    </div>

                    <div>
                        <div class="bl_1_txtentete" >
                            <h3> {{book.title}} </h3>
                            
                            <div>
                                <p v-if="book.disponibility === 1"> Disponible </p>
                                <p v-else> Non disponible </p>
                            </div>
                        </div>

                        <div class="infos_books">    
                            <p> Date de publication : {{book.publication_date}} </p>
                            
                            <p> Auteur : {{book.author_fullname}} </p>
                            
                            <p> Edition : {{book.name}} </p>
                            
                            <p class="price"> {{book.price}} €</p>
                        </div>

                        <div class="btn_visible">
                            <p> Visibilité du livre : {{ book.visible }}</p>
                            <button class="btn btn-info" @click="modifyVisibility(book.id)">Modifier</button>
                        </div>

                        <div class="desc">
                            <h4> Synopsis </h4>
                            <p>{{book.synopsis}} </p>
                        </div> 
                    </div> 
                </div> 

                <div class="infos_supp">
                    <p>  {{book.nb_page}} pages </p>
                    <p> {{book.weight}} kg </p>
                    <p> {{book.size}} cm </p>
                </div>

                <div class="list-infos-supp">
                    <h4> Informations supplémentaires : </h4>
                    <ul>
                        <li>ISBN : {{book.isbn}} </li>
                        <li>Langue : {{book.lang}} </li>
                        <li>Type : {{book.type}} </li>
                    </ul>
                </div>

                
            </div>
        </div>
    </div>
</template>


<script>
import axios from 'axios';



export default {
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

    }
  },
  methods: {
   async modifyVisibility(id){
        await axios.post(`http://localhost:3000/isvisible`, {
            bookid: id
        });

        const resbooks = await axios.get(`http://localhost:3000/newbooks`);
        this.books = resbooks.data

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

  }

}
</script>




<style>
/* En-tête */
.bloc_en-tete {
    padding:10px;  
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
    text-align : left;
    padding-left : 30px;
    display : flex; 
    flex-direction : row;
}

.bl_1_txtentete h3{
    font-weight: bold;
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

.btn-info{
    background-color : #5D97E6;
    
}

.desc {
    font-size : 14px;
    text-align: justify;
    padding-left : 30px;
}  

/* Bloc 2 carte "book" - infos supp + liste à puce */

.infos_supp{
    display : flex; 
    flex-direction : row;
    justify-content : center;
    gap : 120px;
    padding-top : 10px;
    background-color : gray;
    color : white; 
    font-weight: bold;
}

.list-infos-supp{
    text-align: start;
    padding-top : 10px;
}

</style>