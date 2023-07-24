import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../components/Home.vue";
import Editors from "../components/Editors.vue";

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
    path: "/editors",
    name: "editors",
    component: Editors,
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
