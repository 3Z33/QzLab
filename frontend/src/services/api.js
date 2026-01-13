
export const register = async ({username, email, password}) => {
  // Validation des données côté client
  if (!username || !email || !password) {
    console.log("donnees : ", username, email, password);
    throw new Error('Tous les champs sont requis'); 
  }

  const response = await fetch(`http://localhost:3000/auth/register`, { 
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'POST',
    credentials: 'include', // Inclure les cookies pour l'authentification
    body: JSON.stringify({ username, email, password }),
  });

  if (!response.ok) {
    let errorMessage = 'Erreur lors de l\'inscription';
    try {
      const error = await response.json();
      errorMessage = error.error || errorMessage;
    } catch (e) {
      // Si la réponse n'est pas en JSON, garder le message par défaut
    }
    throw new Error(errorMessage);
  }

  // Si nécessaire, traiter les données de la réponse
  const data = await response.json();
  return response; // data;
};


export const login = async ({email, password}) => {
  // Validation des données côté client
  if (!email || !password) {
    console.log("donnees : ", email, password);
    throw new Error('Tous les champs sont requis'); 
  }

  const response = await fetch(`http://localhost:3000/auth/login`, {
    headers: {
      'Content-Type': 'application/json',
    },
    method: 'POST',
    credentials: 'include',
    body: JSON.stringify({ email, password }),
  });

  if (!response.ok) {
    let errorMessage = 'Erreur lors de la connexion';
    try {
      const error = await response.json();
      errorMessage = error.error || errorMessage;
    } catch (_) {
      
    }
    throw new Error(errorMessage);
  }

  
  const data = await response.json();
  return response;
};