<template>
  <div>
    <div v-if="detailAuthor.id">
      <h3>{{ detailAuthor.firstname }} {{ detailAuthor.lastname }}</h3>
      <img :src="detailAuthor.image" :alt="detailAuthor.firstname">
      <ul>
        <li>{{ detailAuthor.title }}</li>
      </ul>
      <p>{{ detailAuthor.biography }}</p>

    
    </div>
  </div>
  
</template>

<script>
  import axios from 'axios';
  export default {
  name: 'Detail',
  props: {},
  components: {
  },
  data(){
    return {
      detailAuthor: [],
    }
  },
  methods: {
   
  },  
  async created(){
    // REcuperation de parametres en GET
    let id = this.$route.params.id
    console.log("id de l'auteur récupérer en GET depuis url", id);

    //Récupération de l'auteur
     const auteurData = await axios.post('http://localhost:3000/detail-auteur', {
      id: id
     })
     this.detailAuthor = auteurData.data[0];
  }
}

</script>