<template>
    <div class="user-panel-container">
        <div class="container user-infos">
            <div class="profile-picture-container"></div>
            <h2 class="username">{{ username }}</h2>
            <div class="user-exp-infos">
                <div class="user-exp">
                        <p>Niveau {{ userLevel }}</p>
                        <p>{{ expPoints }} / {{ nextLevel}} XP</p>
                </div>
                <div class="exp-bar">
                    <div class="progress"></div>
                </div>
            </div>

        </div>
        <div class="favorite-badges">
            <p>Badges favoris :</p> 
            <div class="badges-container">
                    <div class="unit-badge" v-for="(n, i) in 6" :key="i">
                        <img v-if="badgesSelection[i].name" :src="badgesSelection[i].icon" width="40" /> 
                    </div>
                <button class="badges-management-bt" @click="console.log('clické')">
                    <img :src="parameterIcon" alt="Paramètres">
                </button>
            </div>
        </div>
    </div>
</template>


<script setup>
import { ref, computed } from 'vue';
import parameterIcon from '../assets/images/icons/parameter.svg';
import { useAuthStore } from '../store/useAuthStore';

const authStore = useAuthStore();

const username = computed(() => authStore.user ? authStore.user.username : 'Invité');



const userLevel = ref(5);
const expPoints = ref(1200);
const nextLevel = ref(10000);

const badgesSelection = ref([
    { id: 1, name: "Badge 1" },
    { id: 2, name: "Badge 2" },
    { id: 3, name: "Badge 3" },
    { id: 4, name: "Badge 4" },
    { id: 5, name: "Badge 5" },
    { id: 6, name: "Badge 6" },
]);
</script>


<style scoped>

.user-panel-container {
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  background-color: aqua;
  width: 100%;
  max-width: 390px;
  padding: 16px;
  box-sizing: border-box;
}

.user-infos {
  background-color: rgb(175, 175, 175);
  width: 100%;
  min-height: 280px;
  margin-top: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  color: black;
}

.profile-picture-container {
  height: 140px;
  width: 140px;
  background-color: white;
  border-radius: 50%;
  margin-top: 12px;
  box-shadow: 0 0 10px 5px rgba(0, 0, 0, 0.3);
}

.username {
  text-align: center;
  margin-top: 12px;
  font-size: 1.6rem;
}

.user-exp-infos {
  text-align: center;
  margin-top: 30px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 100%;
}

.user-exp {
  display: flex;
  justify-content: space-between;
  width: 100%;
  font-size: 0.85rem;
  line-height: 10px;
  
  box-sizing: border-box;
}

.exp-bar {
  height: 10px;
  width: 100%;
  background-color: black;
  border-radius: 10px;
  margin: 10px auto;
}

.progress {
  height: 100%;
  width: 80%;
  background: linear-gradient(90deg, var(--secondary-color) 50%, var(--primary-color) 100%);
  border-radius: 10px;
}

.favorite-badges p {
  background-color: rgb(200, 200, 200);
  height: 40px;
  display: flex;
  align-items: center;
  padding: 0 10px;
  margin: 12px 0 0;
  max-width: 260px;
  margin: auto;
}

.badges-container {
  display: flex;
  align-items: center;
  position: relative;
  gap: 10px;
  background-color: rgb(211, 211, 211);
  min-height: 70px;
  max-width: 260px;
  margin: auto;
    justify-content: center; 
  padding: 10px 30px;
  flex-wrap:wrap;
  
}

.unit-badge {
  height: 45px;
  width: 45px;
  border: solid 1px black;
  border-radius: 50%;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.badges-management-bt {
  height: 25px;
  width: 25px;
  background: none;
  cursor: pointer;
  display: flex;
  position: absolute;
  right: 5px;
  top: 5px;
  border: 1px solid transparent;
  transition: border-color 0.2s ease;
}

.badges-management-bt:hover {
  border-color: rgba(0, 0, 0, 0.5);
}

@media (min-width: 768px) {
  .user-panel-container {
    max-width: 520px;
    padding: 0;
  }

  .user-infos {
    width: 480px;
    min-height: 350px;
    margin-top: 30px;
  }

  .profile-picture-container {
    height: 200px;
    width: 200px;
    margin-top: 15px;
  }

  .username {
    margin-top: 20px;
    font-size: 2rem;
  }

  .user-exp-infos {
   width: 90%;
  }

  .user-exp {
    width: 400px;
    font-size: 0.9rem;
    padding: 0;
  }

  .exp-bar {
    width: 400px;
    margin-top: 15px;
  }

  .favorite-badges p {
    max-width: 400px;
  }

  .badges-container {
    flex-wrap: nowrap;
    max-width: 400px;
  }
}
</style>