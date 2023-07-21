<template>
    <div>
        <h3>Donnée des Auteurs</h3>
       <table class="table-authors">
        <thead class="table-dark">
            <tr >
                <th scope="col">Prénom</th>
                <th scope="col">Nom</th>
                <th scope="col">Biographie</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="author in authors" :key="author.id">
                <td scope="row" @click="sendIdAuthors(author.id)" > {{ author.firstname }} </td>
                <td scope="row"> {{ author.lastname }} </td>
                <td scope="row"> {{ author.biography }} </td>
            </tr>
        </tbody>
       </table>
       <h4 v-for="titleAuthors in titleBook"> {{ titleAuthors.title }} {{ titleAuthors.firstname }} {{ titleAuthors.lastname }}</h4>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name: 'Authors',
    props: {},
    components: {
    },
    data(){
      return {
        authors: [],
        editors: [],
        titleBook: []
      }
    },
    methods: {
    sendIdAuthors(id){
        // ROUTER naviguation
        this.$router.push({ name: 'Details', params: { id: id } })
      }
    },  
    async created(){
  
      //Les Auteurs
      const authorData = await axios.get(`http://localhost:3000/authors`);
      this.authors = authorData.data

      //Titre Livre plus nom auteurs
      const titleLastFirstNameAuthorsData = await axios.get('http://localhost:3000/title-books')
      this.titleBook = titleLastFirstNameAuthorsData.data
    }
  }

</script>

<style>
:root{
    --black: rgba(0,0,0,0.7);
    --borderTable: 0.5px solid var(--black)
}
table, td{
    border-collapse: collapse;
    border: var(--borderTable)
}
    thead{
        color: #fff;
        font-weight: 100;
    }
    td:last-child{
        padding: 20px;
    }
</style>