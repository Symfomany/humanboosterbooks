<template>
  <div id="app">
    
    <header>
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Boutique en ligne de Livres</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item active">
              <a class="nav-link" href="#"><i class="fas fa-home"></i>  Accueil</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#"><i class="fas fa-cogs"></i>  Les Livres</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#"><i class="fas fa-cogs"></i>  Les Auteurs/Editeurs</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#"><i class="fas fa-cogs"></i>  Les Utilisateurs</a>
            </li>
          </ul>
        </div>
      </nav>
    </header>
    <main class="container" id="main">
      <Home />
    </main>

     <!-- Footer -->
    <footer class="bg-dark text-light text-center py-3">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <p>&copy; 2023 Back Office. Tous droits réservés.</p>
          </div>
          <div class="col-md-6">
            <ul class="list-inline social-icons">
              <li class="list-inline-item">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
              </li>
              <li class="list-inline-item">
                <a href="#"><i class="fab fa-twitter"></i></a>
              </li>
              <li class="list-inline-item">
                <a href="#"><i class="fab fa-instagram"></i></a>
              </li>
              <li class="list-inline-item">
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </footer>

  </div>
</template>

<script>
import Home from './components/Home.vue'

export default {
  name: 'App',
  components: {
    Home
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
#main{
  min-height: 800px;
}
</style>
