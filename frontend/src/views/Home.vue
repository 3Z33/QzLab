<template>
     <div class="home-view"> 
      <UserPanel />
      <LastPlayed />
      <QuizCard />
    </div>
</template>

<script setup>
    import { computed } from 'vue'
    import { watch } from 'vue'
    
    import { useAuthStore } from '../store/useAuthStore';
import UserPanel from '../components/UserPanel.vue';
import LastPlayed from '../components/LastPlayed.vue';
import QuizCard from '../components/QuizCard.vue';

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