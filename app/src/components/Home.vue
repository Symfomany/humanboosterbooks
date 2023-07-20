<template>
  <div class="hello">
    <img src="https://campusnumerique.auvergnerhonealpes.fr/app/uploads/2019/11/logo_degrade_jaune-Baseline-300ppi.jpg" alt="">
    <div class="container text-center">
    <div class="row align-items-start">
      
      <!-- Vous pouvez supprimer cet exemple -->
      <div class="row">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">Exemple de Reactivité en VueJS</h4>
            <h3 class="pa-2">Compteur: {{ compteur }}</h3>
            <p>{{  prenom }}</p>
          
            <p v-if="compteur >= 10"> Whaaaouhh ! </p>
            <p v-else-if="compteur > 2"> Super ! </p>
            <p v-else> Pas encore </p>

            <HumanBooster :compteur="compteur"></HumanBooster>  

                <input type="text" class="form-control" placeholder="le nb" v-model="compteur">
                <button class="btn btn-success" @click="augmenterFive"><i class="fas fa-plus"></i><i class="fas fa-plus"></i> Augmenter de 5</button>
                <button class="btn btn-primary" @click="compteur++"><i class="fas fa-plus"></i> Augmenter</button>
                <button class="btn btn-danger" @click="compteur--"><i class="fas fa-minus"></i> Diminuer</button>
          </div>
        </div>
      </div>

       <div class="row">
         <div class="col-md-6 col-lg-3">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title">  Les Adresses</h5>
                <p class="card-text">

                  <div v-if="!addresses.length" class="alert alert-info" role="alert">
                    Chargement...
                  </div>
                    <p v-for="addresse in addresses" :key="addresse.id"> 
                    <i class="fas fa-list-item"></i>
                    {{ addresse.city }}  {{ addresse.zipcode }}</p>

                    <input placeholder="Zipcode" type="text" class="form-control" v-model="zipcode">
                    <input placeholder="City" type="text" class="form-control" v-model="city" >
                    <button :disabled="zipcode.length !== 5" @click="ajouterAdresse" class="btn btn-primary">Ajouter une adresse</button>

                </p>
              </div>
            </div>
          </div>

           <div class="col-md-6 col-lg-3">
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">  Les Links</h5>
                  <p class="card-text">
                      <p v-for="link in links" :key="link.id"> 
                      {{ link.name }}  
                      <a :href="link.url">
                        {{ link.url }}
                      </a>
                  </p>
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
              <!-- MyComponent -->
                <Authors v-if="currentComponent == true"></Authors>
                <router-link to="/authors">Authors</router-link>
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
import HumanBooster from './HumanBooster.vue';
import Authors from './Authors.vue';


export default {
  name: 'Home',
  props: {},
  components: {
    HumanBooster,
    Authors
  },
  data(){
    return {
      zipcode: "",
      city: "",
      prenom: "Julien",
      addresses : [],
      links: [],
      authors: [],
      editors: [],
      compteur: 0,
      currentComponent: false
    }
  },
  methods: {
    augmenterFive(){
      this.compteur += 5
    },
    async ajouterAdresse(){
      const { data } = await axios.post(`http://localhost:3000/addresses`, {
        city: this.city,
        zipcode: this.zipcode,
      });

      this.addresses.push({
         city: this.city,
        zipcode: this.zipcode,
      })

       this.city = ""
       this.zipcode = ""

    },
 
  },  
  async created(){
    // je charge les adresses derriere API
    const {data} = await axios.get(`http://localhost:3000/addresses`);
    this.addresses = data
    
    // je charge les liens derriere API
    const res = await axios.get(`http://localhost:3000/links`);
    this.links = res.data

    //Les Auteurs
    const authorData = await axios.get(`http://localhost:3000/authors`);
    this.authors = authorData.data
  }
  

}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
