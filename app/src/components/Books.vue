<template>
    <div class="news">  
        <div class="tete"> 
            <h2>Nos nouveautés</h2>
            {{ books.length}} books
        </div>

        <div>
            <p>Nb de couvetures: {{  statsCover }}</p>
            <p>Prix moyen: {{  statsPrice }}</p>
            <p>Nb de vues: {{  statsViews }}</p>
        </div>
        
        
        <div >
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

                <div class="desc">
                    <p>{{book.synopsis}} </p>
                    <p><a href>Lire la suite</a></p>
                </div>  

                <div class="infos">
                    <p>  {{book.nb_page}} pages </p>
                    <p> {{book.weight}} kg </p>
                    <p> {{book.size}} cm </p>
                </div>

                <div class="list-infos">
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

.news {
    padding:10px;
}   

.tete {
    padding-bottom : 30px;
}

.desc {
    font-size : 14px;
    text-align: justify;
}  

h3{
    font-weight: bold;
}

.custom-card {
    border-color : gray ;
    padding-top : 10px;
    padding-bottom : 10px; 
    padding-right : 25px;
    padding-left : 25px;
}

.infos{
    display : flex; 
    flex-direction : row;
    justify-content : center;
    gap : 120px;
    padding-top : 10px;
    background-color : gray;
    color : white; 
    font-weight: bold;
}

.price{
    font-size : 20px; 
    font-weight: bold;
}

.list-infos{
    text-align: start;
    padding-top : 10px;
}
</style>