<template>
<div class="app-layout">
  <Sidebar />
  <main class="content">
      <UserPanel />
      <router-view />
    </main>


</div>
</template>


<script setup>
import Sidebar from './components/Sidebar.vue';
import UserPanel from './components/userPanel.vue';
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
