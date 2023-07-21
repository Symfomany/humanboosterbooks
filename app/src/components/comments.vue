<template>
    <div class="container">
      <div v-if="comments.length">
        <ul class="list-inline">
            <div
            v-for="(comment, index) in comments"
            :key="index">
                <hr>
                <div class="row mb-2">
                    <div class="col-6">
                    <b>Utilisateur : </b>{{ comment.firstname }} {{ comment.lastname }}<br />
                    </div>
                    <div class="col-6">
                    <b>Livre :</b> {{ comment.title }} <br />
                    </div>
                </div>
                <div class="mb-2">
                {{ comment.content }}
                </div>
                <div>
                <b>Vues :</b>{{ comment.views }}<br />
                Créé le {{ comment.created_date }} <br />
                Mis à jour le {{ comment.updated_day_time }} <br />
                </div>
                <button class="btn btn-danger mt-2" @click="()=>deleteComment(comment.id)">Supprimer</button>
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
    methods: 
    {async deleteComment(commentId) {
      try {
        const response = await axios.post('http://localhost:3000/delete-comments', { id: commentId });
        console.log(response.data.success);

        // Si la suppression est réussie, mets à jour la liste des commentaires localement
        if (response.data.success) {
          this.comments = this.comments.filter(comment => comment.id !== commentId);
        }
      } catch (error) {
        console.error('Erreur lors de la suppression du commentaire :', error);
      }
    }},

    data() {
      return { comments: [] };
    },
    async created() {
      const { data } = await axios.get(`http://localhost:3000/comments`);
      this.comments = data.results;
    },
    /*
    async deleteComment(){
      const { data } = await axios.post(`http://localhost:3000/delete-comments`, {
        id : this.id,
      });
    },*/
    
  };
  </script>