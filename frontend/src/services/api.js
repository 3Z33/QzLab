
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
  return data; // data;
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
  return data;
};


export const logout = async () => {
  await fetch('http://localhost:3000/auth/logout', {
    method: 'POST',
    credentials: 'include',
  });
};

export const checkAuth = async () => {
  try {
    const response = await fetch('http://localhost:3000/auth/check', {
      credentials: 'include', // envoie le cookie JWT
    });

    if (!response.ok) {
      // L'utilisateur n'est pas connecté ou erreur côté serveur
      return null;
    }

    const data = await response.json();
    return data.data.user || null; // retourne l'utilisateur ou null
  } catch (_) {
    // Problème réseau ou autre
    return null;
  }
};
