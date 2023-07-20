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
                <label for="langue" class="form-label">Langue</label>
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
            <button type="submit" @click="addUser" class="btn btn-primary">Submit</button>
        </form>
        </div>






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
        fname: "",
        lname: "",
        age:"",
        email:"",
        pswd:"",
        dob: "",
        lang:"",
        phone:""
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

    }
    }

}

</script>