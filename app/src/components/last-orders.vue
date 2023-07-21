<template>
  <div class="container m-3">
    <h3>Les dernières commandes</h3>
    <div v-if="orders.length" class="row">
      <div
        v-for="(order, index) in orders"
        :key="index"
        class="card col-md-6 col-lg-3 mx-auto"
      >
        <p>Numero de la commande :{{ order.id }}</p>
        <p>Prix total de la commande :{{ order.price_total }}</p>
        <p>Date de la commande :{{ order.order_date }}</p>
        <p>Transporteur :{{ order.carrier }}</p>
        <p>Prix hors taxe :{{ order.price_ht }}</p>
        <p>Tva : {{ order.tva }}</p>
        <p>Status de la commande :{{ order.status }}</p>
      </div>
    </div>
    <template v-else>
      <p>Pas de commande/En chargement</p>
    </template>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "LastOrders",
  data() {
    return { orders: [] };
  },
  async created() {
    const { data } = await axios.get(`http://localhost:3000/orders`);
    this.orders = data;
  },
};
</script>
