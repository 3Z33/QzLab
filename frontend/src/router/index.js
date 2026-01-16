import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
/*import Play from '../views/Play.vue'
import MyQuizzes from '../views/MyQuizzes.vue'
import Profile from '../views/Profile.vue'
import Organizations from '../views/Organizations.vue'
import OrganizationDetail from '../views/OrganizationDetail.vue'
import ServiceDetail from '../views/ServiceDetail.vue'
import Leaderboards from '../views/Leaderboards.vue'
import Statistics from '../views/Statistics.vue'
import Admin from '../views/Admin.vue'
import ThemeQuizzes from '../views/ThemeQuizzes.vue'
import Game from '../views/Game.vue' */

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home,
      meta: { requiresAuth: false }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
      meta: { requiresAuth: false }
    },
    {
      path: '/register',
      name: 'Register',
      component: Register,
      meta: { requiresAuth: false }
    }/*,
    {
      path: '/play',
      name: 'Play',
      component: Play,
      meta: { requiresAuth: false }
    },
    {
      path: '/my-quizzes',
      name: 'MyQuizzes',
      component: MyQuizzes,
      meta: { requiresAuth: true }
    },
    {
      path: '/profile',
      name: 'Profile',
      component: Profile,
      meta: { requiresAuth: true }
    },
    {
      path: '/organizations',
      name: 'Organizations',
      component: Organizations,
      meta: { requiresAuth: true }
    },
    {
      path: '/organizations/:id',
      name: 'OrganizationDetail',
      component: OrganizationDetail,
      meta: { requiresAuth: true }
    },
    {
      path: '/organizations/:organizationId/services/:serviceId',
      name: 'ServiceDetail',
      component: ServiceDetail,
      meta: { requiresAuth: true }
    },
    {
      path: '/leaderboards',
      name: 'Leaderboards',
      component: Leaderboards,
      meta: { requiresAuth: false }
    },
    {
      path: '/statistics',
      name: 'Statistics',
      component: Statistics,
      meta: { requiresAuth: false }
    },
    {
      path: '/admin',
      name: 'Admin',
      component: Admin,
      meta: { requiresAuth: true, requiresAdmin: true }
    },
    {
      path: '/themes/:id/quizzes',
      name: 'ThemeQuizzes',
      component: ThemeQuizzes,
      meta: { requiresAuth: false }
    },
    {
      path: '/game/:id',
      name: 'Game',
      component: Game,
      meta: { requiresAuth: false }
    },
    {
      path: '/test-icons',
      name: 'TestIcons',
      component: TestIcons,
      meta: { requiresAuth: false }
    }*/
  ]
})

export default router
