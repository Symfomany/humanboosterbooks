<template>
  <div class="container">
    <h3>Stats liés au commandes</h3>
    <template v-if="ordersStats.length"></template>
    <template v-else>chargement...</template>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "OrdersStats",
  data() {
    return { ordersStats: {} };
  },
  async created() {
    const { data } = await axios.get(`http://localhost:3000/orders`);
    this.orders = data;
  },
};
</script>
