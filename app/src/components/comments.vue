<template>
    <div class="container">
      <div v-if="comments.length" class="row">
        <ul class="list-inline">
            <li
            v-for="(comment, index) in comments"
            :key="index"
            class="card"
            >
            <b>Utilisateur :</b>{{ comment.users_id }}<br />
            <b>Livre :</b> {{ comment.books_id }} <br />
            <b>Commentaire :</b>{{ comment.content }}<br />
            <b> Nombre de vues </b>{{ comment.views }}<br />
            <b>Date de création :</b>{{ comment.created_date }} <br />
            <b>Dernière mise à jour :</b>{{ comment.updated_day_time }} <br />
            </li>
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