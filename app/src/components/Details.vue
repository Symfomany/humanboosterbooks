<template>
    <div>
        <p>{{ detailAuthor.firstname }}</p>
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
       this.detailAuthor = auteurData.data[0]
    }
  }
</script>