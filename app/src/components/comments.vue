<template>
    <div class="container">
      <div v-if="comments.length">
        <ul class="list-inline">
            <div
            v-for="(comment, index) in comments"
            :key="index">
            <hr>
            <div class="row">
                <div class="col-6">
                <b>Utilisateur :</b>{{ users.firstname, users.lastname }}<br />
                </div>
                <div class="col-6">
                <b>Livre :</b> {{ books.title }} <br />
                </div>
            </div>
            <div>
            {{ comment.content }}
            </div>
            <b>Vues :</b>{{ comment.views }}<br />
            Créé le {{ comment.created_date }} <br />
            Mis à jour le {{ comment.updated_day_time }} <br />
        </div>
        </ul>
      </div>
      <template v-else>
        <p>No comments...</p>
      </template>
    </div>
  </template>
  
  <script>
  import axios from "axios";
  export default {
    name: "Comments",
    data() {
      return { comments: [] };
    },
    async created() {
      const { data } = await axios.get(`http://localhost:3000/comments`);
      this.comments = data;
    },
  };
  </script>