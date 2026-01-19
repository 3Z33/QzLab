<template>
     <div class="home-view"> 
       <!-- <h1>Bienvenue sur QzLab {{ user }}</h1>
        <p>Votre plateforme de quiz en ligne.</p>-->
    </div>
</template>

<script setup>
    import { computed } from 'vue'
    import { watch } from 'vue'
    
    import { useAuthStore } from '../store/useAuthStore';

    const authStore = useAuthStore();


const user = computed(() =>
  authStore.user ? authStore.user.username : 'Invité'
);

watch(
  () => authStore.user,
  (val) => console.log('user:', val),
  { immediate: false }
);



</script>

<style scoped></style>  