<template>
    <div class="container-fluid">
        <h1>Les Utilisateurs</h1>

      <div class="row d-flex justify-content-center">
      <form class="w-50 ">

            <div class="mb-3">
                <label for="firstname" class="form-label">Prénom</label>
                <input type="name" class="form-control" id="firstname" v-model="fname">
            </div>
            <div class="mb-3">
                <label for="lastname" class="form-label">Nom</label>
                <input type="name" class="form-control" id="lastname" v-model="lname">
            </div>
            <div class="mb-3">
                <label for="dob" class="form-label">Date de naissance</label>
                <input type="date" class="form-control" id="dob" v-model="dob">
            </div>
            <div class="mb-3">
                <label for="age" class="form-label">Age</label>
                <input type="number" class="form-control" id="age" v-model="age">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" v-model="email">
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Numéro de téléphone</label>
                <input type="text" class="form-control" id="phone" v-model="phone">
            </div>
            <div class="mb-3">
                <label for="langue" class="form-label">Langue (fr,en,es,de)</label>
                <input type="text" class="form-control" id="langue" v-model="lang">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Mot de passe</label>
                <input type="password" class="form-control" id="password" v-model="pswd">
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="checkbox">
                <label class="form-check-label" for="checkbox">Je suis un robot</label>
            </div>
            <button type="submit" @click="addUser" class="btn btn-dark">Submit</button>
        </form>
        </div>

        






        <div class="row">
        <table class="table">
          <thead>
            <tr is="vue:table-row">
              <th scope="col">Nombre d'utilisateurs actifs</th>
              <th scope="col">Nombre d'utilisateurs inactifs</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="countUser in countUsers" :key="countUser.nombre_utilisateurs">
              <td scope="col">{{ countUser.nombre_utilisateurs }}</td>
            </tr>
          </tbody>
        </table>
      </div>









<!--boucle v-for pour afficher tous les utilisateurs et bouton supprimer-->
      <div v-for="user in users" :key="user.id">
        <p>{{ user.fname }} {{ user.lname }}</p>
        <!-- Ajoutez un bouton pour supprimer l'utilisateur -->
        <button @click="deleteUser(user.id)">Supprimer</button>
      </div>










        
        <table class="table table-striped table-dark">
          <thead>
            <tr>
              <th scope="col">id</th>
              <th scope="col">Firstname</th>
              <th scope="col">Lastname</th>
              <th scope="col">Email</th>              
              <th scope="col">Password</th>              
              <th scope="col">Age</th>
              <th scope="col">Activé</th>
              <th scope="col">Pf</th>
              <th scope="col">Date d'authentification</th>
              <th scope="col">Date de création</th>
              <th scope="col">Suppression</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="users in tusers.slice(0, 10)" :key="users.id"> <!--Limiter nombre de users à 10 avec slice-->
              <th>{{ users.id }}</th>
              <td>{{ users.firstname }}</td>
              <td>{{ users.lastname }}</td>
              <td>{{ users.email }}</td>
              <td>{{ users.password }}</td>
              <td>{{ users.age }}</td>
              <td>{{ users.enable }}</td>
              <td>{{ users.profile_id }}</td>
              <td>{{ users.date_auth }}</td>
              <td>{{ users.date_created }}</td>
              <td><button @click="deleteUser(users.id)" class="btn btn-danger">Supprimer</button></td>
            </tr>
          </tbody>
        </table>



    </div>
    
  </template>
  



  <script>
  import axios from 'axios';
  import HumanBooster from './Users.vue'
  export default {
    name: 'Utilisateurs',
    props: {},
    components: {
      HumanBooster
    },
    data(){
      return {
        users: [],
        tusers: [],
        fname: "",
        lname: "",
        age:"",
        email:"",
        pswd:"",
        dob: "",
        lang:"",
        phone:"",
        countUsers: []
      }
    },
  



  methods: {
  async addUser(e){
    e.preventDefault()
    const { data } = await axios.post(`http://localhost:3000/users`, {
      fname: this.fname,
      lname: this.lname,
      age: this.age,
      email: this.email,
      pswd: this.pswd,
      dob: this.dob,
      lang: this.lang,
      phone: this.phone
    });

    this.users.push({
      fname: this.fname,
      lname: this.lname,
      age: this.age,
      email: this.email,
      pswd: this.pswd,
      dob: this.dob,
      lang: this.lang,
      phone: this.phone
    })

    this.fname = ""
    this.lname = ""
    this.age = ""
    this.email = ""
    this.pswd = ""
    this.dob = ""
    this.lang = ""
    this.phone = ""
  },
    

    async tableUsers() {
      const tUsers = await axios.get(`http://localhost:3000/users`);
        this.tusers = tUsers.data
      },

      async deleteUser(userId) {
      try {
        await axios.delete(`http://localhost:3000/users/${userId}`);
        // Mettez à jour la liste des utilisateurs localement pour refléter les changements côté serveur
        
      } catch (error) {
        console.error(error);
      }
  },

  async countEnable() {
    const usersEnabled = await axios.get(`http://localhost:3000/users`);
    this.usersEnabled = usersEnabled.data
  },
},

  async created(){
    await this.tableUsers()
    await this.countEnable()
  },



  
}

</script>