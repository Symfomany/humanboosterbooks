<template>
     <div>  
        <h2>Nos nouveautés</h2>
        

        {{ books.length}} books
        <div v-for="book in books" :key="books.id" class = "card custom-card">
            <img src ="{{}}" alt="">
            <div  >
                <h3> {{book.title}} </h3>
                <p> {{book.price}} €</p>
                <p v-if="book.disponibility === 1"> Disponible </p>
                <p v-else> Non disponible </p>
            </div>
           
            <div>
                <p> {{book.publication_date}} </p>
                <p> <!--auteurs --> </p>
                <p> <!--édition --> </p>
            </div>

            <div>
                <p>{{book.synopsis}} </p>
            </div>  

            <div>
                <p>  {{book.nb_page}} pages </p>
                <p> {{book.weight}} kg </p>
                <p> {{book.size}} cm </p>
            </div>

            <div>
                <ul>
                    <li> {{book.isbn}} </li>
                    <li> {{book.lang}} </li>
                    <li> {{book.type}} </li>
                </ul>
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
    }
  },
  methods: {
   
  },  
  async created(){

// je charge les liens derriere API
    const resbooks = await axios.get(`http://localhost:3000/newbooks`);
    this.books = resbooks.data
  }

}
</script>




<style>
    h3{
        color: blue
    }

    .custom-card {
        border-color : gray ;
    }
</style>