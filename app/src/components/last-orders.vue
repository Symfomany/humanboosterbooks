<template>
  <div class="container m-3">
    <h3>Les dernières commandes</h3>
    <div v-if="orders.length" class="row">
      <div
        v-for="(order, index) in orders"
        :key="index"
        class="card col-md-6 col-lg-3 mx-auto"
      >
        numero de la commande :{{ order.id }}<br />
        prix total de la commande :{{ order.price_total }}<br />
        date de la commande :{{ order.order_date }}<br />
        transporteur :{{ order.carrier }} <br />
        prix hors taxe :{{ order.price_ht }} <br />
        tva : {{ order.tva }} <br />
        status de la commande :{{ order.status }} <br />
      </div>
    </div>
    <template v-else>
      <p>pas de commande/en chargement</p>
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
