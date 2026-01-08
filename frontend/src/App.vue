<template>
<div class="app-layout">
  <Sidebar />
    <main class="content">
        <router-view />
    </main>


</div>
</template>


<script setup>
import Sidebar from './components/Sidebar.vue';



</script>



<style scoped>
.app-layout {
  min-height: 100vh;
}

.content {
 margin-left: 280px; /* Width of the sidebar */

}

</style>
