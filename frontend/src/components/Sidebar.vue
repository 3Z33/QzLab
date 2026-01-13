<template>
<aside class="side-panel">
    <div class="side-panel-header">
      <img src="../assets/images/logo/QzLab.png" alt="QzLab" class="logo">
    </div>
    
    <nav class="side-nav">
      <router-link to="/" class="nav-item" active-class="active">
        <span class="nav-icon"><Home /></span>
        <span class="nav-text">Accueil</span>
      </router-link>
      
      <router-link to="/play" class="nav-item" active-class="active">
        <span class="nav-icon"><Play /></span>
        <span class="nav-text">Jouer</span>
      </router-link>
      
      <router-link to="/my-quizzes" class="nav-item" active-class="active">
        <span class="nav-icon"><MyQuiz /></span>
        <span class="nav-text">Mes Quiz</span>
      </router-link>
      
      <router-link to="/profile" class="nav-item" active-class="active">
        <span class="nav-icon"><Profile /></span>
        <span class="nav-text">Profil</span>
      </router-link>
      
      <router-link to="/organizations" class="nav-item" active-class="active">
        <span class="nav-icon"><Organizations /></span>
        <span class="nav-text">Organisations</span>
      </router-link>
      
      <router-link to="/leaderboards" class="nav-item" active-class="active">
        <span class="nav-icon"><Ranking /></span>
        <span class="nav-text">Classements</span>
      </router-link>
      
      <router-link to="/statistics" class="nav-item" active-class="active">
        <span class="nav-icon"><Statistics /></span>
        <span class="nav-text">Statistiques</span>
      </router-link>
      
      <router-link v-if="isLoggedIn && isAdmin" to="/admin" class="nav-item admin-link" active-class="active">
        <span class="nav-icon"><Admin /></span>
        <span class="nav-text">Administration</span>
      </router-link>
    </nav>
    
    <div class="side-panel-footer">
      <div v-if="!isLoggedIn" class="auth-buttons">
        <router-link to="/login" class="auth-btn login-btn">
          <span class="nav-text">Connexion</span>
        </router-link>
        <router-link to="/register" class="auth-btn register-btn">
          <span class="nav-text">Inscription</span>
        </router-link>
      </div>
      
      <button v-else @click="handleLogout" class="logout-btn">
        <span class="nav-text">Déconnexion</span>
      </button>
    </div>
  </aside>
</template>

<script setup>
import Home from '../components/IconsComponents/Home.vue'
import Play from '../components/IconsComponents/Play.vue'
import MyQuiz from '../components/IconsComponents/MyQuiz.vue'
import Profile from '../components/IconsComponents/Profile.vue'
import Organizations from '../components/IconsComponents/Organizations.vue'
import Ranking from '../components/IconsComponents/Ranking.vue'
import Statistics from '../components/IconsComponents/Statistics.vue'
import Admin from '../components/IconsComponents/Admin.vue'

</script>

<style scoped>

.side-panel {
  width: 280px;
  height: 100vh;
  background: linear-gradient(180deg, #1a1a1a 0%, #0f0f0f 100%);
  border-right: 1px solid #333;
  display: flex;
  flex-direction: column;
  position: fixed;
  left: 0;
  top: 0;
  z-index: 1000;
  box-shadow: 4px 0 20px rgba(0, 0, 0, 0.3);
}

.side-panel-header {
  padding: 2rem 1.5rem;
  border-bottom: 1px solid #333;
  background: rgba(255, 255, 255, 0.02);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.logo {
  width: 70%;
  object-fit: contain;
}

.logo::after {
  content: '';
  position: absolute;
  bottom: -8px;
  left: 0;
  width: 40px;
  height: 2px;
  background: #ffffff;
  border-radius: 1px;
}

.user-info {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.user-role {
  color: #999;
  font-size: 0.8rem;
  text-transform: uppercase;
  letter-spacing: 1px;
  font-weight: 500;
}

.side-nav {
  flex: 1;
  padding: 1rem 0;
  overflow-x: hidden;
  overflow-y: auto;
}

.nav-item {
  display: flex;
  align-items: center;
  gap: 0.875rem;
  padding: 0.875rem 1.5rem;
  color: #ccc;
  text-decoration: none;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  border-left: 3px solid transparent;
  position: relative;
  margin: 0.125rem 0;
}

.nav-item::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background: rgba(255, 255, 255, 0.05);
  opacity: 0;
  transition: opacity 0.2s ease;
  z-index: -1;
}

.nav-item:hover::before {
  opacity: 1;
}

.nav-item:hover {
  color: #ffffff;
  border-left-color: #ffffff;
  transform: translateX(4px);
}

.nav-item.active {
  color: #ffffff;
  background: rgba(255, 255, 255, 0.08);
  border-left-color: #ffffff;
  font-weight: 600;
}

.nav-icon {
  font-size: 1.1rem;
  width: 20px;
  text-align: center;
  filter: grayscale(1);
  transition: filter 0.2s ease;
}

.nav-item:hover .nav-icon,
.nav-item.active .nav-icon {
  filter: grayscale(0);
}

.nav-text {
  font-size: 0.9rem;
  font-weight: 500;
  letter-spacing: 0.25px;
}

.admin-link {
  margin-top: 0.5rem;
  border-top: 1px solid #333;
  padding-top: 1rem;
}

.admin-link:hover {
  background: rgba(255, 255, 255, 0.1);
  border-left-color: #ffffff;
}

.side-panel-footer {
  padding: 1rem 0;
  border-top: 1px solid #333;
  background: rgba(0, 0, 0, 0.2);
}

.logout-btn {
  display: flex;
  align-items: center;
  gap: 0.875rem;
  width: 100%;
  padding: 0.875rem 1.5rem;
  background: none;
  border: none;
  color: #999;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  font-family: inherit;
  font-size: 0.9rem;
  border-left: 3px solid transparent;
}

.logout-btn:hover {
  color: #ffffff;
  background: rgba(255, 0, 0, 0.1);
  border-left-color: #ff4444;
  transform: translateX(4px);
}

.logout-btn .nav-icon {
  filter: grayscale(1);
  transition: filter 0.2s ease;
}

.logout-btn:hover .nav-icon {
  filter: grayscale(0);
}

/* Scrollbar personnalisée 
.side-nav::-webkit-scrollbar {
  width: 6px;
}

.side-nav::-webkit-scrollbar-track {
  background: transparent;
}

.side-nav::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.2);
  border-radius: 3px;
}

.side-nav::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 255, 255, 0.4);
}*/

/* Responsive Design */
@media (max-width: 1024px) {
  .side-panel {
    width: 260px;
  }
  
  .side-panel-header {
    padding: 1.5rem 1.25rem;
  }
  
  .logo {
    font-size: 1.6rem;
  }
  
  .nav-item {
    padding: 0.75rem 1.25rem;
  }
}

@media (max-width: 768px) {
  .side-panel {
    width: 240px;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
  }
  
  .side-panel.open {
    transform: translateX(0);
  }
  
  .nav-item {
    padding: 0.875rem 1rem;
  }
  
  .side-panel-header {
    padding: 1.25rem 1rem;
  }
  
  .logo {
    font-size: 1.4rem;
    letter-spacing: 1px;
  }
}

/* Animation d'entrée */
.side-panel {
  animation: slideInLeft 0.4s ease-out;
}

@keyframes slideInLeft {
  from {
    transform: translateX(-100%);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

/* Styles pour les boutons d'authentification */
.auth-buttons {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  padding: 1rem;
}

.auth-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0.75rem 1rem;
  border: none;
  text-decoration: none;
  font-weight: 500;
  transition: all 0.2s ease;
  cursor: pointer;
}

.login-btn {
  background: rgba(255, 255, 255, 0.1);
  color: #ffffff;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.login-btn:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.3);
}

.register-btn {
  background: var(--primary-color);
  color: #ffffff;
  border: 1px solid var(--primary-color);
}

.register-btn:hover {
  background: var(--primary-color-dark);
  border-color: var(--primary-color-dark);
}

/* États de focus pour l'accessibilité */
.nav-item:focus,
.logout-btn:focus,
.auth-btn:focus {
  outline: 2px solid #ffffff;
  outline-offset: -2px;
  background: rgba(255, 255, 255, 0.1);
}

/* Effet de transition douce pour les états */
.nav-item,
.logout-btn {
  position: relative;
  overflow: hidden;
}

/* Indicateur pour les notifications (optionnel) */
.nav-item.has-notification::before {
  content: '';
  position: absolute;
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
  width: 8px;
  height: 8px;
  background: #ffffff;
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
    transform: translateY(-50%) scale(1);
  }
  50% {
    opacity: 0.7;
    transform: translateY(-50%) scale(1.2);
  }
}
</style>