<template>
    <div class="user">
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
                <label for="age" class="form-label">Age</label>
                <input type="number" class="form-control" id="age" v-model="age">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" v-model="email">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Mot de passe</label>
                <input type="password" class="form-control" id="password" v-model="pswd">
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="checkbox">
                <label class="form-check-label" for="checkbox">Je suis un robot</label>
            </div>
            <button type="submit" @click="addUser" class="btn btn-primary">Submit</button>
        </form>
        </div>













        
        <p>{{ tusers[0].id }}</p>
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
              <th scope="col">Profile id</th>
              <th scope="col">Date d'authentification</th>
              <th scope="col">Date de création</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="users in tusers.slice(0, 10)" :key="users.id">
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
        tusers: [] 
      }
    },



  methods: {
  async addUser(){
    const { data } = await axios.post(`http://localhost:3000/users`, {
      fname: this.fname,
      lname: this.lname,
      age: this.age,
      email: this.email,
      pswd: this.pswd,
    });

    this.users.push({
      fname: this.fname,
      lname: this.lname,
      age: this.age,
      email: this.email,
      pswd: this.pswd,
    })

    this.fname = ""
    this.lname = ""
    this.age = ""
    this.email = ""
    this.pswd = ""
    },

    

    async tableUsers() {
      const tUsers = await axios.get(`http://localhost:3000/users`);
        this.tusers = tUsers.data
      }
    },

  async created(){
    await this.tableUsers()
  },
}

</script>