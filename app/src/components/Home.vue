<template>
  <div class="hello">
    <img src="https://campusnumerique.auvergnerhonealpes.fr/app/uploads/2019/11/logo_degrade_jaune-Baseline-300ppi.jpg" alt="">
    <div class="container text-center">
    <div class="row align-items-start">
      
       <div class="row">
         <div class="col-md-6 col-lg-3">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title">  Modérer les Genres</h5>
                <p class="card-text">
                  
                  <div v-if="!genres.length" class="alert alert-info" role="alert">
                    Chargement...
                  </div>
                    <p v-for="genre in genres" :key="genre.id"> {{  genre.name }}</p>

                </p>
              </div>
            </div>
          </div>

        <div class="col-md-6 col-lg-3">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">  Modérer les Commentaires</h5>
              <p class="card-text">Description du contenu de la carte 1.</p>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title"> Gérer les Utilisateurs </h5>
              <p class="card-text">Description du contenu de la carte 2.</p>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title"> Modérer les Livres </h5>
              <p class="card-text">Description du contenu de la carte 3.</p>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Modérer les Auteurs et Editions </h5>
              <p class="card-text">Description du contenu de la carte 4.</p>
            </div>
          </div>
        </div>
      </div>

      
      
    
    </div>
  </div>
  </div>
</template>

<script>
import axios from 'axios';


export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  data(){
    return {
      genres : []
    }
  },
  async created(){
    const {data} = await axios.get(`http://localhost:3000/genres`);
    this.genres = data
    console.log("data", data);
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
