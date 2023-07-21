<template>
   <div>
    <p v-for="nbAuthorsData in authors" :key="nbAuthorsData.id">Le nombre d'auteurs 
                    <i class="fas fa-list-item"></i>
                    {{ nbAuthorsData.nb_authors }} </p>

    <p v-for="nbEditorsData in editors" :key="nbEditorsData.id">Le nombre d'éditeurs 
                    <i class="fas fa-list-item"></i>
                    {{ nbEditorsData.nb_editors }} </p>
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
    }
  },
  methods: {
    
 
  },  
  async created(){
    //Les Auteurs
    const authorData = await axios.get(`http://localhost:3000/authors`);
    this.authors = authorData.data

    //nombre d'Auteurs
    const nbAuthorsData = await axios.get(`http://localhost:3000/nb_authors`);
    this.authors = nbAuthorsData.data

    //nombre d'Editions
    const nbEditorsData = await axios.get(`http://localhost:3000/nb_editors`);
    this.editors = nbEditorsData.data
  }
  

}
</script>

<style>
h3{
    color: blueviolet;
}
</style>


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
      nb_editor: '',
      nb_author: '',
    }
  },
  methods: {
    
  },  
  async created(){

    //Les Auteurs
    const authorData = await axios.get(`http://localhost:3000/authors`);
    this.authors = authorData.data

    const editorNameNbBook = await axios.get(`http://localhost:3000/editors_name_nb_books`);
    this.editors = editorNameNbBook.data

    const data_nb_editor = await axios.get(`http://localhost:3000/nb_editor`);
    this.nb_editor = data_nb_editor.data[0]

    const data_nb_author = await axios.get(`http://localhost:3000/nb_author`);
    this.nb_author = data_nb_author.data[0]
  }
  

}
</script>
