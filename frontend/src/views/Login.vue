<template>
  <div class="container login-container" role="main" aria-labelledby="page-title">
    <div class="card login-card">
      <h1 class="text-center" id="page-title">Connexion</h1>
      
      <div v-if="error" class="error-message">{{ error }}</div>
      
      <form @submit.prevent="handleLogin" class="login-form">
        <div class="form-group">
          <label for="email">Email</label>
          <input 
            type="email" 
            id="email" 
            v-model="email" 
            required 
            :disabled="loading"
            placeholder="votre@email.com"
          >
        </div>
        
        <div class="form-group">
          <label for="password">Mot de passe</label>
          <input 
            type="password" 
            id="password" 
            v-model="password" 
            required 
            :disabled="loading"
            placeholder="Votre mot de passe"
          >
        </div>
        
        <!-- Bouton de soumission -->
        <div class="form-actions" aria-label="Actions du formulaire">
          <button 
            type="submit" 
            class="btn btn-primary" 
          >
            {{ loading ? 'Connexion...' : 'Se connecter' }}
          </button>
        </div>




        <!-- <button type="submit" class="btn" style="width: 100%;" :disabled="loading"> 
          {{ loading ? 'Connexion...' : 'Se connecter' }}
        </button>-->
      </form>
      
      <div class="login-footer">
        <p>Pas encore de compte ? <router-link to="/register">S'inscrire</router-link></p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
//import { useAuthStore } from '../stores/auth'
import { login } from '../services/api.js'
import { useRouter, useRoute } from 'vue-router'

//const authStore = useAuthStore()
const router = useRouter()
const route = useRoute()

const email = ref('')
const password = ref('')
const loading = ref(false)
const error = ref('')

// Variables pour gérer l'invitation
const isInvitation = ref(false)
const invitationParams = ref({})

const handleLogin = async () => {
  if (loading.value) return
  
  loading.value = true
  error.value = ''
  
  try {
    const result = await login({ 
      email: email.value,
      password: password.value
    })
    
    console.log('🔍 Résultat de la connexion:', result)
    /*
    if (result.success) {
      // Si c'est une invitation, traiter l'invitation après connexion
      if (isInvitation.value) {
        await processInvitation()
      } else {
        console.log('🔄 Redirection vers la page d\'accueil')
        router.push('/')
      }
    } else {
      error.value = result.error || 'Erreur lors de la connexion'
    } */
  } catch (err) {
    console.error('❌ Erreur dans handleLogin:', err)
    error.value = err.message || 'Erreur lors de la connexion'
  } finally {
    loading.value = false
  }
}

/**
 * Traite l'invitation après connexion
 */
const processInvitation = async () => {
  try {
    const { orgId, token } = invitationParams.value
    
    const response = await fetch(`/api/invitations/join/${orgId}/${token}`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${authStore.getToken}`
      }
    })
    
    if (response.ok) {
      // Rediriger vers les organisations avec un message de succès
      router.push('/organizations?message=Vous avez rejoint l\'organisation avec succès')
    } else {
      // Rediriger vers les organisations avec un message d'erreur
      router.push('/organizations?error=Erreur lors de l\'acceptation de l\'invitation')
    }
  } catch (err) {
    console.error('Erreur lors du traitement de l\'invitation:', err)
    router.push('/organizations?error=Erreur lors de l\'acceptation de l\'invitation')
  }
}

/**
 * Initialisation du composant
 */
onMounted(() => {
  // Vérifier si c'est une invitation
  if (route.query.invitation === 'true') {
    isInvitation.value = true
    invitationParams.value = {
      orgId: route.query.orgId,
      token: route.query.token,
      email: route.query.email
    }
    
    // Pré-remplir l'email si fourni
    if (route.query.email) {
      email.value = decodeURIComponent(route.query.email)
    }
  }
})
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  padding: 2rem;
}

h1 {
    text-decoration: underline;
    text-underline-offset: 5px;
    text-decoration-thickness: 2px;
    margin: 2rem 0;
    text-align: center;
}

.login-card {
  max-width: 450px;
  width: 100%;
  padding: 2rem;
  box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.3);
  background-color: white;
}

.login-form {
  margin-top: 1rem;
}

.form-group {
  margin-bottom: 1.25rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: #2c3e50;
}


 input {
  width: 100%;
  padding: 0.6rem 0.6rem;
  border: 2px solid var(--border-light);
  font-size: 0.9rem;
  transition: all 0.3s ease;
  background-color: white;
}

input:focus {
  outline: none;
  border-color: #0d6efd;
  box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
}

.form-actions .btn {
  width: 100%;
  padding: 0.5rem 1rem;
  font-size: 1rem;
  font-weight: 600; 
  transition: all 0.3s ease;
  background: var(--primary-color);
  color: #ffffff;
  border: none;
  cursor: pointer;
}

.form-actions .btn:hover {
  background: var(--primary-color-dark);
}

.login-footer {
  margin-top: 1.5rem;
  text-align: center;
}

.login-footer a {
  color: #3498db;
  text-decoration: none;
}

.login-footer a:hover {
  text-decoration: underline;
}
</style>
