<template>
    <div class="quiz-card-container">
        <div class="quiz-card">
            <div class="quiz-card-thumbnail">
                <img :src="paint" alt="Paint" />
            </div>
            <div class="quiz-card-details-container">
                <h3>Chimie - Difficile</h3>
                <div class="quiz-card-details">
                    <div class="quiz-card-questions detail-item">
                        <span class="label">Questions :</span>
                        <span>20</span>
                    </div>
                    <div class="quiz-card-best-score detail-item">
                        <span class="label3">Meilleur score :</span>
                        <span>2300</span>
                    </div>
                    <div class="quiz-card-difficulty detail-item">
                        <span class="label">Difficulté :</span>
                            <span class="difficulty-star-container" :aria-label="`Difficulté sur 3`">
                                <img
                                    v-for="i in 3"
                                    :key="i"
                                    :src="i <= difficulty ? emptyStar : star"
                                    alt=""
                                />
                                </span>
                        </div>
                    <div class="quiz-card-category detail-item">
                        <span class="label">Catégorie :</span>
                        <span>Méthodologie cognitives</span>
                    </div>
                </div>
            </div>
                <div class="action-buttons">
                    <router-link class="play-bt" :to="`/play/`">Jouer</router-link>
                    <router-link class="edit-bt" :to="`/play/`">Editer</router-link>
                </div>
            <!-- <router-link class="replay-bt" :to="`/play/${n}`">Rejouer</router-link> -->
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import emptyStar from '../assets/images/icons/empty-star.svg';
import star from '../assets/images/icons/star.svg';
import paint from '../assets/images/icons/paint.svg';



const facile = ref(1); 
const moyen = ref(2);
const difficile = ref(3);

</script>

<style scoped>

.quiz-card-difficulty img {
    width: 30px;
    height: 30px;
}
.quiz-card-container {
    display: flex;
    margin-top: 50px;
    background-color: rgb(185, 63, 63);
    flex-direction: column;
    align-items: center;
    width: 100%;
    max-width: 350px; 
    font-size: 0.7rem;  

}

.quiz-card {
    width: 95%;
    flex-direction: column;
    background-color: #ffffff;
    box-shadow: var(--box-shadow);
    
}
.quiz-card-thumbnail {
    display: flex;
    margin: auto;   
    height: 120px; 
    aspect-ratio: 1/1;
    
    background-color: #e9e9e9;
    
    
}
.quiz-card-thumbnail img {
   height: 100%;
}

.quiz-card-details-container h3 {
  
    text-align: center;
    margin: 10px 0;
    }

.quiz-card-details {
    display: flex;
    flex-direction: column;
    

    }

    .detail-item {
    display: flex;
    flex-direction: column;
    background-color: #cfcfcf;
    align-items: center;
    gap: 10px;
    
    }

    .difficulty-star-container {
    display: flex;
    
    
    }


    .detail-item span:first-of-type {
    font-weight: bold;
    text-decoration: underline;
    }

    .action-buttons {
        display: flex;
        flex-direction: column;
        gap: 5px;
        background-color: rgb(192, 192, 192);
    }

.play-bt, .edit-bt {
      padding: 0.75rem 1rem;
  text-align: center;
  padding: 1rem 0;  /* padding: 0 0.5rem; */
  width: 100%;
  background-color: rgb(27, 152, 255);
  color:white;
  
  text-decoration: none;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.edit-bt {
    background-color: rgb(245, 167, 0);
    
}   

.quiz-card-details:has(.play-bt:hover), .quiz-card-details:has(.edit-bt:hover) { 
  box-shadow: var(--box-shadow-selected);
  transform: translateY(-4px) scale(1.02);
} 

.quiz-card-details:has(.play-bt:active), .quiz-card-details:has(.edit-bt:active) {
  box-shadow: var(--box-shadow-selected);
  transform: scale(1.5);
}



.quiz-card-details {
  display: flex;
  flex-direction: column;
  
}




@media (min-width: 768px) {

.quiz-card-container {
    display: flex;
    justify-content: center;
    height: 120px;
    max-width: 560px;
}
.quiz-card {
  display: flex;
  flex-direction: row;
  
  align-items: center;
  width: 100%;
  max-width: 550px;
  position: relative;
}


.quiz-card-details {
    display: flex;
    justify-content: space-around;
    
    
}
.quiz-card-details-container {
    height: 100%;
    margin: auto;
    position: relative;
    width: 100%;
}

.quiz-card-details-container h3 {
    margin: 0px 0 15px 0;
}


  .quiz-card-details {
    flex-direction: row;
    align-items: center;
    flex-wrap: nowrap;
    
    background-color: #e7e7e7;

    
  }
  .detail-item {
      height: 70px;
      word-wrap: break-word;
    }
    
    .quiz-card-thumbnail {
        margin: 0;
    }
    
    .action-buttons {
        position: absolute;
        right: -200px;
        display: flex;
        flex-direction: row;
       height: 120px;
        width: 190px;
        gap: 10px;
    }
    
    .play-bt, .edit-bt {
        width: 140px;
        display: flex;
        align-items: center;
        justify-content: center;    
        padding: 0;
        
    }

} 

</style>