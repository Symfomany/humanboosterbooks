<template>
  <div class="container">
    <h3>Stats liés au commandes</h3>
    <template v-if="ordersStats.length">
      <div
        v-for="(stat, index) in ordersStats"
        :key="index"
        class="card col-md-6 col-lg-3"
      >
        <p>status: {{ stat.status }}</p>
        <p>nombre de commandes pour ce status :{{ stat.nb_orders_by_stats }}</p>
      </div>
    </template>
    <template v-else><p>aucune stats / chargement...</p></template>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "OrdersStats",
  data() {
    return { ordersStats: [] };
  },
  async created() {
    const { data } = await axios.get(`http://localhost:3000/orders/stats`);
    console.log(data);
    this.ordersStats = data;
  },
};
</script>
