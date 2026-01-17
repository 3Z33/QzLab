<template>
    <div class="container register-container" role="main" aria-labelledby="page-title">
    <div class="card register-card">
      <h1 id="page-title">Inscription</h1>
      <p class="text-center page-description">Créez votre compte QzLab pour pouvoir accèder à toutes les fonctionnalités :</p>
      <div 
        v-if="error" 
        class="error-message" 
        role="alert" 
        aria-live="assertive"
        :aria-describedby="error ? 'error-description' : null"
      >
        <span id="error-description">{{ error }}</span>
      </div>
      <div 
        v-if="successMessage" 
        class="success-message" 
        role="status" 
        aria-live="polite"
        :aria-describedby="successMessage ? 'success-description' : null"
      >
        <span id="success-description">{{ successMessage }}</span>
      </div>
      
      <form class="register-form" role="form" aria-labelledby="page-title" @submit.prevent="handleRegister">
        <!-- Nom d'utilisateur -->
        <div class="form-group">
          <label for="username" class="required">
            Nom d'utilisateur :
            <span class="required-indicator" aria-label="requis">*</span>
          </label>
          <div class="input-wrapper">
            <input 
              id="username" 
              v-model="username" 
              type="text" 
              required 
              :disabled="loading"
              placeholder="Votre nom d'utilisateur"
              aria-describedby="username-help username-validation"
              aria-required="true"
              autocomplete="username"
              :class="{ 'valid': usernameValid, 'invalid': usernameError }"
              @input="validateUsername"
              @blur="validateUsername"
            >
            <div class="validation-icon" :class="{ 'valid': usernameValid, 'invalid': usernameError }">
              <span v-if="usernameValid" class="icon-valid" aria-label="Valide">✅</span>
              <span v-else-if="usernameError" class="icon-invalid" aria-label="Invalide">❌</span>
            </div>
          </div>
          <div id="username-help" class="help-text">
            Entre 3 et 20 caractères, lettres, chiffres et tirets uniquement
          </div>
          <div 
            v-if="usernameError" 
            id="username-validation" 
            class="validation-error" 
            role="alert"
            aria-live="polite"
          >
            {{ usernameError }}
          </div>
        </div>
        
        <!-- Email -->
        <div class="form-group">
          <label for="email" class="required">
            Adresse email :
            <span class="required-indicator" aria-label="requis">*</span>
          </label>
          <div class="input-wrapper">
            <input 
              id="email" 
              v-model="email" 
              type="email" 
              required 
              :disabled="loading"
              placeholder="votre@email.com"
              aria-describedby="email-help email-validation"
              aria-required="true"
              autocomplete="email"
              :class="{ 'valid': emailValid, 'invalid': emailError }"
              @input="validateEmail"
              @blur="validateEmail"
            >
            <div class="validation-icon" :class="{ 'valid': emailValid, 'invalid': emailError }">
              <span v-if="emailValid" class="icon-valid" aria-label="Valide">✅</span>
              <span v-else-if="emailError" class="icon-invalid" aria-label="Invalide">❌</span>
            </div>
          </div>
          <div id="email-help" class="help-text">
            Format email valide requis
          </div>
          <div 
            v-if="emailError" 
            id="email-validation" 
            class="validation-error" 
            role="alert"
            aria-live="polite"
          >
            {{ emailError }}
          </div>
        </div>
        
        <!-- Mot de passe -->
        <div class="form-group">
          <label for="password" class="required">
            Mot de passe :
            <span class="required-indicator" aria-label="requis">*</span>
          </label>
          <div class="input-wrapper">
            <input 
              id="password" 
              v-model="password" 
              type="password" 
              required 
              :disabled="loading"
              placeholder="Créez un mot de passe sécurisé"
              aria-describedby="password-help password-validation password-strength"
              aria-required="true"
              autocomplete="new-password"
              :class="{ 'valid': passwordValid, 'invalid': passwordError }"
              @input="validatePassword"
              @blur="validatePassword"
            >
            <div class="validation-icon" :class="{ 'valid': passwordValid, 'invalid': passwordError }">
              <span v-if="passwordValid" class="icon-valid" aria-label="Valide">✅</span>
              <span v-else-if="passwordError" class="icon-invalid" aria-label="Invalide">❌</span>
            </div>
          </div>
          <div id="password-help" class="help-text">
            Minimum 8 caractères avec majuscules, chiffres et caractères spéciaux
          </div>
          
          <!-- Indicateur de force du mot de passe -->
          <div id="password-strength" class="password-strength" aria-live="polite">
            <div class="strength-bar">
              <div 
                class="strength-fill" 
                :class="passwordStrength.level"
                :style="{ width: passwordStrength.percentage + '%' }"
                :aria-label="'Force du mot de passe: ' + passwordStrength.text"
              ></div>
            </div>
            <span class="strength-text" :class="passwordStrength.level">
              {{ passwordStrength.text }}
            </span>
          </div>

          <!-- Critères de validation du mot de passe -->
          <div class="password-criteria" role="group" aria-label="Critères de validation du mot de passe">
            <div 
              v-for="criterion in passwordCriteria" 
              :key="criterion.key"
              class="criterion-item"
              :class="{ 'valid': criterion.valid, 'invalid': !criterion.valid }"
            >
              <span class="criterion-icon" :aria-label="criterion.valid ? 'Critère respecté' : 'Critère non respecté'">
                {{ criterion.valid ? '✅' : '❌' }}
              </span>
              <span class="criterion-text">{{ criterion.text }}</span>
            </div>
          </div>
          
          <div 
            v-if="passwordError" 
            id="password-validation" 
            class="validation-error" 
            role="alert"
            aria-live="polite"
          >
            {{ passwordError }}
          </div>
        </div>
        
        <!-- Confirmation du mot de passe -->
        <div class="form-group">
          <label for="confirmPassword" class="required">
            Confirmer le mot de passe :
            <span class="required-indicator" aria-label="requis">*</span>
          </label>
          <div class="input-wrapper">
            <input 
              id="confirmPassword" 
              v-model="confirmPassword" 
              type="password" 
              required 
              :disabled="loading"
              placeholder="Confirmez votre mot de passe"
              aria-describedby="confirm-help confirm-validation"
              aria-required="true"
              autocomplete="new-password"
              :class="{ 'valid': confirmPasswordValid, 'invalid': confirmPasswordError }"
              @input="validateConfirmPassword"
              @blur="validateConfirmPassword"
            >
            <div class="validation-icon" :class="{ 'valid': confirmPasswordValid, 'invalid': confirmPasswordError }">
              <span v-if="confirmPasswordValid" class="icon-valid" aria-label="Valide">✅</span>
              <span v-else-if="confirmPasswordError" class="icon-invalid" aria-label="Invalide">❌</span>
            </div>
          </div>
          <div id="confirm-help" class="help-text">
            Saisissez à nouveau votre mot de passe
          </div>
          <div 
            v-if="confirmPasswordError" 
            id="confirm-validation" 
            class="validation-error" 
            role="alert"
            aria-live="polite"
          >
            {{ confirmPasswordError }}
          </div>
        </div>
        
        <!-- Bouton de soumission -->
        <div class="form-actions" role="group" aria-label="Actions du formulaire">
          <button 
            type="submit" 
            class="btn btn-primary" 
            :disabled="loading || !isFormValid"
            aria-describedby="submit-help"
          >
            {{ loading ? 'Inscription en cours...' : 'Créer mon compte' }}
          </button>
          <div id="submit-help" class="help-text">
            {{ isFormValid ? 'Formulaire valide, vous pouvez vous inscrire' : 'Veuillez corriger les erreurs avant de continuer' }}
          </div>
        </div>
      </form>
      
      <div class="register-footer">
        <p>Déjà un compte ? <router-link to="/login">Se connecter</router-link></p>
      </div>
    </div>
  </div>

        
 
</template>

<script setup>
import { ref, computed } from 'vue'
import { register } from '../services/api.js'
import { usernameSchema, emailSchema, passwordSchema } from '../schemas/register.schema.js'
import { registerSchema } from '../schemas/register.schema.js'; 

//const authStore = useAuthStore()
//const router = useRouter()

// Variables réactives
const username = ref('')
const email = ref('')
const password = ref('')
const confirmPassword = ref('')
const loading = ref(false)
const error = ref('')
const successMessage = ref('')

// Variables de validation
const usernameValid = ref(false)
const usernameError = ref('')
const emailValid = ref(false)
const emailError = ref('')
const passwordValid = ref(false)
const passwordError = ref('')
const confirmPasswordValid = ref(false)
const confirmPasswordError = ref('')



// Validation du nom d'utilisateur
const validateUsername = () => {
  /*const value = username.value.trim()
  
  if (!value) {
    usernameValid.value = false
    usernameError.value = ''
    return
  }
  
  if (value.length < 3) {
    usernameValid.value = false
    usernameError.value = 'Le nom d\'utilisateur doit contenir au moins 3 caractères'
    return
  }
  
  if (value.length > 20) {
    usernameValid.value = false
    usernameError.value = 'Le nom d\'utilisateur ne peut pas dépasser 20 caractères'
    return
  }
  
  if (!/^[a-zA-Z0-9_-]+$/.test(value)) {
    usernameValid.value = false
    usernameError.value = 'Seuls les lettres, chiffres, tirets et underscores sont autorisés'
    return
  }
  
  usernameValid.value = true
  usernameError.value = '' */

  // === Validation avec Zod ===
  const result = usernameSchema.safeParse(username.value)
  usernameError.value = result.success ? '' : result.error.issues[0].message
}

// Validation de l'email
const validateEmail = () => {
  /*const value = email.value.trim()
  
  if (!value) {
    emailValid.value = false
    emailError.value = ''
    return
  }
  
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(value)) {
    emailValid.value = false
    emailError.value = 'Veuillez saisir une adresse email valide'
    return
  }
  
  emailValid.value = true
  emailError.value = '' */

    // === Validation avec Zod ===

const result = emailSchema.safeParse(email.value)
emailError.value = result.success ? '' : result.error.issues[0].message
}





// Critères de validation du mot de passe
const passwordCriteria = ref([
  { key: 'length', text: 'Entre 8 et 64 caractères', valid: false },
  { key: 'uppercase', text: 'Au moins une majuscule', valid: false },
  { key: 'number', text: 'Au moins un chiffre', valid: false },
  { key: 'special', text: 'Au moins un caractère spécial', valid: false }
])


// Force du mot de passe
const passwordStrength = ref({
  level: 'weak',
  percentage: 0,
  text: 'Très faible'
})
    

// Validation du mot de passe
const validatePassword = () => {
  /*const value = password.value
  
  if (!value) {
    passwordValid.value = false
    passwordError.value = ''
    updatePasswordCriteria(value)
    updatePasswordStrength(value)
    return
  }
  
  // Mise à jour des critères
  updatePasswordCriteria(value)
  updatePasswordStrength(value)
  
  // Validation globale
  const allCriteriaMet = passwordCriteria.value.every(criterion => criterion.valid)
  
  if (!allCriteriaMet) {
    passwordValid.value = false
    passwordError.value = 'Le mot de passe ne respecte pas tous les critères de sécurité'
    return
  }
  
  passwordValid.value = true
  passwordError.value = '' */

    // === Validation avec Zod ===
    const value = password.value
    const result = passwordSchema.safeParse(password.value)
    passwordError.value = result.success ? '': 'Le mot de passe ne respecte pas tous les critères'

      // Mise à jour des critères
  updatePasswordCriteria(value)
  updatePasswordStrength(value)
  
}


// Mise à jour des critères de validation
const updatePasswordCriteria = (value) => {
  passwordCriteria.value[0].valid = value.length >= 8 && value.length <= 64
  passwordCriteria.value[1].valid = /[A-Z]/.test(value)
  passwordCriteria.value[2].valid = /\d/.test(value)
  passwordCriteria.value[3].valid = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(value)
}



// Mise à jour de la force du mot de passe
const updatePasswordStrength = (value) => {
  let score = 0
  let level = 'weak'
  let text = 'Très faible'
  
  if (value.length >= 8) score += 25
  if (/[A-Z]/.test(value)) score += 25
  if (/\d/.test(value)) score += 25
  if (/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(value)) score += 25
  
  if (score >= 100) {
    level = 'strong'
    text = 'Très fort'
  } else if (score >= 75) {
    level = 'good'
    text = 'Fort'
  } else if (score >= 50) {
    level = 'medium'
    text = 'Moyen'
  } else if (score >= 25) {
    level = 'weak'
    text = 'Faible'
  } else {
    level = 'very-weak'
    text = 'Très faible'
  }
  
  passwordStrength.value = {
    level,
    percentage: score,
    text
  }
}

// Validation de la confirmation du mot de passe
const validateConfirmPassword = () => {
  const value = confirmPassword.value
  
  if (!value) {
    confirmPasswordValid.value = false
    confirmPasswordError.value = ''
    return
  }
  
  if (value !== password.value) {
    confirmPasswordValid.value = false
    confirmPasswordError.value = 'Les mots de passe ne correspondent pas'
    return
  }
  
  confirmPasswordValid.value = true
  confirmPasswordError.value = ''
}

// Validation globale du formulaire 
/*const isFormValid = computed(() => {
  return usernameValid.value && 
         emailValid.value && 
         passwordValid.value && 
         confirmPasswordValid.value &&
         username.value.trim() &&
         email.value.trim() &&
         password.value &&
         confirmPassword.value
}) */


const isFormValid = computed(() => {
  const result = registerSchema.safeParse({
    username: username.value.trim(),
    email: email.value.trim(),
    password: password.value,
    confirmPassword: confirmPassword.value,
  });

  return result.success; // Retourne true si le formulaire est valide
});


// Fonction de soumission du formulaire
const handleRegister = async () => {
  if (loading.value || !isFormValid.value) return
  
  loading.value = true
  error.value = ''
  successMessage.value = ''
  
  try {
    const result = await register({
      username: username.value.trim(),
      email: email.value.trim(),
      password: password.value
    })
    
    if (result) {
      successMessage.value = 'Compte créé avec succès ! Redirection en cours...'
      setTimeout(() => {
        router.push('/')
      }, 2000) 
    } else {
      error.value = result.error || 'Erreur lors de l\'inscription'
    }
  } catch (err) {
    console.error('Erreur lors de l\'inscription:', err)
    error.value = err.message || 'Erreur lors de l\'inscription'
  } finally {
    loading.value = false
  }
}



</script>

<style scoped>


.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  padding: 1rem;
  max-width: 800px;
  
}

h1 {
    text-decoration: underline;
    text-underline-offset: 5px;
    text-decoration-thickness: 2px;
    margin: 2rem 0;
}

.register-card {
  padding: 1rem;
  background-color: white;
  box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.3);
}

.page-description {
  color: var(--text-primary);
  margin: 1.5rem 0;
  font-size: 1rem;
  line-height: 1rem;
}

.register-form {
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

.form-group label.required {
  position: relative;
}

.required-indicator {
  color: #dc3545;
  margin-left: 0.25rem;
}

/* Wrapper pour les inputs avec icônes */
.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.input-wrapper input {
  width: 100%;
  padding: 0.6rem 0.6rem;
  border: 2px solid var(--border-light);
  font-size: 0.9rem;
  transition: all 0.3s ease;
  background-color: white;
}

.input-wrapper input:focus {
  outline: none;
  border-color: #0d6efd;
  box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
}

/* États de validation basés sur les classes JavaScript */
.input-wrapper input.valid {
  border-color: #28a745;
}

.input-wrapper input.invalid {
  border-color: #dc3545;
}

.input-wrapper input:disabled {
  background-color: #f8f9fa;
  cursor: not-allowed;
}

/* Icônes de validation */
.validation-icon {
  position: absolute;
  right: 0.75rem;
  top: 50%;
  transform: translateY(-50%);
  font-size: 1.2rem;
  pointer-events: none;
}

.validation-icon .icon-valid {
  color: #28a745;
}

.validation-icon .icon-invalid {
  color: #dc3545;
}

/* Textes d'aide */
.help-text {
  font-size: 0.875rem;
  color: #6c757d;
  margin-top: 0.5rem;
  line-height: 1.4;
}

/* Messages d'erreur */
.validation-error {
  font-size: 0.875rem;
  color: #dc3545;
  margin-top: 0.5rem;
  font-weight: 500;
}

/* Messages globaux */
.error-message {
  background-color: #f8d7da;
  color: #721c24;
  padding: 1rem;
  border-radius: 8px;
  margin-bottom: 1.5rem;
  border: 1px solid #f5c6cb;
  font-weight: 500;
}

.success-message {
  background-color: #d4edda;
  color: #155724;
  padding: 1rem;
  border-radius: 8px;
  margin-bottom: 1.5rem;
  border: 1px solid #c3e6cb;
  font-weight: 500;
}

/* Indicateur de force du mot de passe */
.password-strength {
  margin-top: 0.5rem;
}

.strength-bar {
  width: 100%;
  height: 8px;
  background-color: #e9ecef;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 0.5rem;
}

.strength-fill {
  height: 100%;
  transition: all 0.3s ease;
  border-radius: 4px;
}

.strength-fill.very-weak {
  background-color: #dc3545;
}

.strength-fill.weak {
  background-color: #fd7e14;
}

.strength-fill.medium {
  background-color: #ffc107;
}

.strength-fill.good {
  background-color: #20c997;
}

.strength-fill.strong {
  background-color: #28a745;
}

.strength-text {
  font-size: 0.875rem;
  font-weight: 600;
}

.strength-text.very-weak {
  color: #dc3545;
}

.strength-text.weak {
  color: #fd7e14;
}

.strength-text.medium {
  color: #ffc107;
}

.strength-text.good {
  color: #20c997;
}

.strength-text.strong {
  color: #28a745;
}

/* Critères de validation du mot de passe */
.password-criteria {
  margin-top: 0.5rem;
  padding: 0.75rem;
  background-color: #f8f9fa;
  border-radius: 6px;
  border: 1px solid #e9ecef;
}

.criterion-item {
  display: flex;
  align-items: center;
  margin-bottom: 0.5rem;
  font-size: 0.875rem;
}

.criterion-item:last-child {
  margin-bottom: 0;
}

.criterion-icon {
  margin-right: 0.5rem;
  font-size: 1rem;
  width: 1.2rem;
  text-align: center;
}

.criterion-item.valid .criterion-text {
  color: #28a745;
  font-weight: 500;
}

.criterion-item.invalid .criterion-text {
  color: #6c757d;
}

/* Actions du formulaire */
.form-actions {
  margin-top: 1.5rem;
  text-align: center;
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

.form-actions .btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.form-actions .help-text {
  margin-top: 0.75rem;
  font-style: italic;
}

/* Footer */
.register-footer {
  margin-top: 1.5rem;
  text-align: center;
  padding-top: 1rem;
  border-top: 1px solid #e9ecef;
}

.register-footer a {
  color: #0d6efd;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s ease;
}

.register-footer a:hover {
  color: #0b5ed7;
  text-decoration: underline;
}

/* Responsive */
@media (max-width: 768px) {
  .register-container {
    padding: 1rem;
  }
  
  .register-card {
    padding: 1.5rem;
  }
  
  .input-wrapper input {
    padding: 1rem 3rem 1rem 1rem;
    font-size: 1.1rem;
  }
  
  .form-actions .btn {
    padding: 1rem 1.5rem;
    font-size: 1.2rem;
    min-height: 52px;
  }
  
  .password-criteria {
    padding: 0.75rem;
  }
  
  .criterion-item {
    font-size: 0.9rem;
  }
}

@media (max-width: 480px) {
  .register-card {
    padding: 1rem;
  }
  
  .input-wrapper input {
    padding: 1.125rem 3.5rem 1.125rem 1.125rem;
    font-size: 1.2rem;
  }
  
  .validation-icon {
    right: 1rem;
    font-size: 1.4rem;
  }
  
  .form-actions .btn {
    padding: 1.125rem 1.5rem;
    font-size: 1.3rem;
    min-height: 56px;
  }
}

/* Animations */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.validation-error,
.validation-icon,
.password-criteria {
  animation: fadeIn 0.3s ease;
}

/* Focus visible pour l'accessibilité */
*:focus {
  outline: 2px solid #0d6efd;
  outline-offset: 2px;
}

/* Amélioration du contraste pour les textes d'aide */
.help-text {
  color: #495057;
}

/* États de validation visuels - Désactivés pour les champs avec validation personnalisée */
.input-wrapper input:valid {
  /* border-color: #28a745; - Désactivé pour éviter les conflits avec la validation JS */
}

.input-wrapper input:invalid:not(:placeholder-shown) {
  /* border-color: #dc3545; - Désactivé pour éviter les conflits avec la validation JS */
}


</style>