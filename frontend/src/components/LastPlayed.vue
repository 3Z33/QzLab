<template>
<div class="last-played-container">
    <h3>Dernières parties jouées :</h3>
    <hr>
    <div class="last-quiz-played-list">
        <div class="last-quiz-played" v-for="n in 4" :key="n">
            <div class="last-quiz-played-thumbnail"></div>
            <div class="last-quiz-played-info">
                <h4>{{ quizTitle }}</h4>
                
                    <table class="last-quiz-played-stats">
                        <tr>
                            <th>Score :</th>
                            <td>{{ lastScores[n-1].score }}</td>
                        </tr>
                        <tr>
                            <th>Temps :</th>
                            <td>{{  lastScores[n-1].time }}</td>
                        </tr>
                        <tr>
                            <th>Bonne réponses :</th>
                            <td>{{ lastScores[n-1].correctAnswers }}/{{ lastScores[n-1].totalQuestions }}</td>
                        </tr>
                    </table>
                 <router-link class="replay-bt" :to="`/play/${n}`">Rejouer</router-link>
                 
            </div>
        </div>
    </div>

</div>

</template>


<script setup>
import { ref } from 'vue';

const quizTitle = ref("Histoire");
const lastScores = ref([
    { score: 850, time: '2:30', correctAnswers: 1, totalQuestions: 10 },
    { score: 14300, time: '2:10', correctAnswers: 2, totalQuestions: 15 },
    { score: 1200, time: '3:00', correctAnswers: 3, totalQuestions: 5 },
    { score: 280, time: '2:00', correctAnswers: 4, totalQuestions: 20 },
]);
</script>


<style scoped>

    h3 {
    text-align: center;
    }

.last-played-container {
    margin-top: 50px;
}

hr {
    border: none;
    margin: 10px auto;
    border-top: 2px solid #000000;
    width: 50%;
}
.last-quiz-played-list {
    display: flex;
   justify-content: center;
    flex-direction: row;
     flex-wrap:wrap;
    margin: auto;
    max-width: 1100px;
    gap: 30px;

 background-color: rgb(107, 107, 107);

}
.last-quiz-played {
   display: flex;
   flex-direction: column;
   width: 252px;
  
    align-items: center;
    box-shadow: var(--box-shadow);      
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    
}
.last-quiz-played-thumbnail {
    width: 60px;
    height: 60px;
    background-color: #1f1f1f;

}

.last-quiz-played-info {
   
    display: flex;
    flex-direction: column;
    
    width: 100%;
    max-width: 400px;
    
}
.last-quiz-played-info h4 {
    margin-bottom: 20px;
    text-align: center;
}

.last-quiz-played-stats {
  
  gap: 8px 16px;
  width: 100%;
  
  border-collapse: collapse;
  border: 1px solid var(--border-color);
  margin-bottom: 5px;
  border-right: none;
  border-left: none;
}

.last-quiz-played-stats th, .last-quiz-played-stats td {
  border: 1px solid var(--border-color); 
border-right: none;
border-left: none;

}

.last-quiz-played-stats th {
  text-align: left;
  font-weight: 600;
  padding: 6px 8px;
  border-right: none;
  border-left: none;
  
}
.last-quiz-played-stats td {
  text-align: right;
  padding: 6px 8px;
  border-left: none;
  border-right: none;

}

.replay-bt {
  
  text-align: center;
  padding: 0.75rem 1rem;
  width: 100%;
  background-color: var(--success-color);
  color: white;
  text-decoration: none;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.last-quiz-played:has(.replay-bt:hover) { 
  box-shadow: var(--box-shadow-selected);
  transform: translateY(-4px) scale(1.02);
} 

.last-quiz-played:has(.replay-bt:active) {
  box-shadow: var(--box-shadow-selected);
  transform: scale(1.5);
}

@media (min-width: 768px) {
    .last-quiz-played-list {
        width: 700px;
    } 
    
    .last-quiz-played-thumbnail {
        width: 80px;
        height: 80px;
        margin: 5px 0;
        background-color: #383838;
        
    }
    
    .last-quiz-played-info h4 {
        text-decoration: underline;
        text-underline-offset: 3px;
        
    }
}

@media (min-width: 1500px) {
.last-quiz-played-list {
    width: auto;
  } 
}

@media (min-width: 1024px) {
  .replay-bt {
    background-color: red;
  }
  .last-quiz-played:has(.replay-bt:active) {
   transition: 3600s;
}
}

</style>