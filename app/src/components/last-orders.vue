<template>
  <div class="container">
    <h3>Les dernières commandes</h3>
    <div v-if="orders.length" class="row">
      <div
        v-for="(order, index) in orders"
        :key="index"
        class="card col-md-6 col-lg-3 mx-auto"
      >
        Numero de la commande :{{ order.id }}<br />
        Prix total de la commande :{{ order.price_total }}<br />
        Date de la commande :{{ order.order_date }}<br />
        Transporteur :{{ order.carrier }} <br />
        Prix hors taxe :{{ order.price_ht }} <br />
        TVA : {{ order.tva }} <br />
        Status de la commande :{{ order.status }} <br />
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
