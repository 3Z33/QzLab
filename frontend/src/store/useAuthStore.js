import { defineStore } from 'pinia';
import { checkAuth, logout, login } from '../services/api';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    user: null,
    loading: true,
  }),

  actions: {
    async checkAuth() {
      try {
        this.user = await checkAuth();
        } catch (_) {
          console.log("probleme dans la reponse checkauth");
        this.user = null;
      } finally {
        this.loading = false;
      }
    },

    async logout() {
  try {
    await logout();
  } finally {
    this.user = null;
  }
},

async login(credentials) {
      const data = await login(credentials);
      this.user = data.data.user;
      return data;
    },
},
});
