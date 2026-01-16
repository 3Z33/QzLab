<template>
    <div class="home-view">
        <h1>Bienvenue sur QzLab {{ authStore.user }}</h1>
        <p>Votre plateforme de quiz en ligne.</p>
    </div>
</template>

<script setup>
    import { ref } from 'vue';

    import { useAuthStore } from '../store/useAuthStore';

    const authStore = useAuthStore();



  //let user = ref(authStore.user ? authStore.user.name : 'Invité');






</script>

<style scoped></style>  