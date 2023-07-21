<template>
  <div class="container m-3">
    <h3>Stats liées au commandes</h3>
    <div class="row" v-if="ordersStats.length">
      <div class="card col-md-6 col-lg-3 mx-auto">
        <div v-for="(stat, index) in ordersStats" :key="index">
          <p>
            Nombre de commandes pour le status "{{ stat.status }}" :
            {{ stat.nb_orders_by_stats }}
          </p>
        </div>

        <p>
          Nombre total de commandes :
          {{
            ordersStats.reduce((sum, e) => {
              return (sum += e.nb_orders_by_stats);
            }, 0)
          }}
        </p>
      </div>
    </div>
    <div v-else><p>aucune stats / chargement...</p></div>
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
