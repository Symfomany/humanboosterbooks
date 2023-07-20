<template>
    <div class="container">
      <h3>Commentaires</h3>
      <div v-if="comments.length" class="row">
        <div
          v-for="(comment, index) in comments"
          :key="index"
          class="card col-md-6 col-lg-3"
        >
          Utilisateur :{{ comment.users_id }}<br />
          Livre : {{ comment.books_id }} <br />
          Commentaire :{{ comment.content }}<br />
          Nombre de vues :{{ comment.views }}<br />
          Date de création :{{ comment.created_date }} <br />
          Dernière mise à jour :{{ comment.updated_day_time }} <br />
        </div>
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