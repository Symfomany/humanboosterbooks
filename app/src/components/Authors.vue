<template>
   <div>
        <h3>Hello Guys</h3>
        <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Magni molestias at, tenetur illum doloribus quasi eligendi voluptatem quaerat iusto rem corrupti. Nesciunt nisi, quasi delectus molestiae nemo nam unde eum!</p>


        <p v-for="authorData in authors" :key="authorData.id"> 
                    <i class="fas fa-list-item"></i>
                    {{ authorData.firstname }}  {{ authorData.lastname }}</p>

                    <hr>

                    <p v-for="editorNameNbBook in editors" :key="editorNameNbBook.id"> Nom de l'éditeur
                    <i class="fas fa-list-item"></i>
                    {{ editorNameNbBook.name }} : nombre livre {{ editorNameNbBook.nb_books }}</p>

                    <hr>

                    <p :key="nb_editor.id"> Nb éditeur
                    <i class="fas fa-list-item"></i>
                    {{ nb_editor.nb_editor }}</p>

                    <p :key="nb_author.id"> Nb autheur
                    <i class="fas fa-list-item"></i>
                    {{ nb_author.nb_author }}</p>
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
