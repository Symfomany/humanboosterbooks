<template>
    <div>
        <div class="authors">
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
                        <td scope="row" @click="sendIdAuthors(author.id)" > {{ author.lastname }} </td>
                        <td scope="row" @click="sendIdAuthors(author.id)" > {{ author.biography }} </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div>
            <input type="text" v-model="newAuthor.firstname">
            <input type="text" v-model="newAuthor.lastname">
            <input type="text" v-model="newAuthor.biography">
            <input type="text" v-model="newAuthor.prize">
            <button type="button" @click="addAuthors">Envoyer</button>
        </div>
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

        newAuthor: {
            firstname:"",
            lastname:"",
            biography:"",
            prize:"",
        },
      }
    },
    methods: {
    sendIdAuthors(id){
        // ROUTER naviguation
        this.$router.push({ name: 'Details', params: { id: id } })
      },

      //Ajout Auteurs
      async addAuthors(){
        const newAuthor = await axios.post('http://localhost:3000/authors' , {
            newAuthor: this.newAuthor,
        });
        const authorData = await axios.get(`http://localhost:3000/authors`);
      this.authors = authorData.data

        this.newAuthor = {
            firstname:"",
            lastname:"",
            biography:"",
            prize:"",
        }
      }
    },  
    async created(){
  
      //Les Auteurs
      const authorData = await axios.get(`http://localhost:3000/authors`);
      this.authors = authorData.data
    
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