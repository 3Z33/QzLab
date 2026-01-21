<template>
<div class="app-layout">
  <Sidebar />
  <main class="content">
      <router-view />
      <QuizCard />
    </main>


</div>
</template>


<script setup>
import QuizCard from './components/QuizCard.vue';
import Sidebar from './components/Sidebar.vue';
import { useAuthStore } from './store/useAuthStore';
import { onMounted } from 'vue';


const authStore = useAuthStore(); 

onMounted(() => {
  authStore.checkAuth(); 
});


</script>



<style scoped>
.app-layout {
  min-height: 100vh;
}
.content {
  margin-left: 280px; /* Width of the sidebar */

  }
@media (max-width: 1024px) {
  .content {
  margin-left: 0px; /* Width of the sidebar */

  }
}


</style>
