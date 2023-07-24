import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../components/Home.vue";
import Authors from "../components/Authors.vue";
import Details from "../components/Details.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: Home,
  },
  {
    path: "/about",
    name: "about",
    component: () => import(/* static page*/ "../views/AboutView.vue"),
  },
  {
    path: "/authors",
    name: "authors",
    component: Authors,
  },
  {
    path: "/details/:id",
    name: "Details",
    component: Details,
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;