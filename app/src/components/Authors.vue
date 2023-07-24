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
                        <td scope="row"> {{ author.biography }} <svg @click="removeAuthors(author)" width="30px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>close</title><path d="M19,6.41L17.59,5L12,10.59L6.41,5L5,6.41L10.59,12L5,17.59L6.41,19L12,13.41L17.59,19L19,17.59L13.41,12L19,6.41Z" /></svg></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div>
            <input placeholder="Prénom" type="text" v-model="newAuthor.firstname">
            <input placeholder="Nom" type="text" v-model="newAuthor.lastname">
            <input placeholder="Bio" type="text" v-model="newAuthor.biography">
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
        },
      }
    },
    methods: {

       async removeAuthors(author){
           this.authors.splice(this.authors.indexOf(author),1)
           const x = await axios.delete(`http://localhost:3000/authors/${author.id}`)
           
            console.log(author.id);
        },

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