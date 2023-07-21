<template>
  <div class="container">
    <h3>Modifier le status d'une commande</h3>
    <form
      class="col-md-6 mx-auto"
      v-on:submit="
        (e) => {
          e.preventDefault();
          modifyOrderStatus(id, status);
        }
      "
    >
      <div class="form-group col">
        <label for="id"> entrez l'id de la commande à modifier </label>
        <input
          id="id"
          class="form-control"
          type="number"
          v-model="id"
          required
        />
      </div>
      <div class="form-group col">
        <label for="status"> entrez l'id de la commande </label>
        <select id="status" class="form-control" v-model="status" required>
          <option value="">--Selectionnez un status--</option>
          <option value="en cours">En cours</option>
          <option value="livré">Livré</option>
          <option value="non livré">Non livré</option>
          <option value="traité">Traité</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary">Modifier le status</button>
    </form>
  </div>
</template>
<script>
import axios from "axios";
export default {
  name: "ModifyOrder",
  data() {
    return {
      id: "",
      status: "",
    };
  },
  methods: {
    async modifyOrderStatus(id, status) {
      const { data } = await axios.post(`http://localhost:3000/orders/${id}`, {
        status: status,
      });
    },
  },
};
</script>
