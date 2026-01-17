import express from "express";
import { register, login, logout, checkAuth } from "../controllers/authController.js";
import { requireAuth } from "../middleware/requireAuth.js";
import { validate } from "../middleware/validate.js";
import { registerSchema, loginSchema } from "../validators/authValidator.js";


const router = express.Router();

/**
 * @openapi
 * /auth/register:
 *   post:
 *     summary: Inscription utilisateur
 *     tags:
 *       - Auth
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - username
 *               - email
 *               - password
 *             properties:
 *               username:
 *                 type: string
 *                 example: JohnDoe
 *               email:
 *                 type: string
 *                 example: john@example.com
 *               password:
 *                 type: string
 *                 example: Password123!
 *     responses:
 *       201:
 *         description: Inscription réussie
 *       400:
 *         description: Erreur de validation ou email déjà utilisé
 *       500:
 *         description: Erreur interne du serveur
 */

router.post("/register", validate(registerSchema), register);

/**
 * @openapi
 * /auth/login:
 *   post:
 *     summary: Connexion utilisateur
 *     tags:
 *       - Auth
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 example: john@example.com
 *               password:
 *                 type: string
 *                 example: Password123!
 *     responses:
 *       200:
 *         description: Connexion réussie
 *       400:
 *         description: Erreur de validation
 *       401:
 *         description: Identifiants invalides
 */

router.post("/login", validate(loginSchema), login);

/**
 * @openapi
 * /auth/logout:
 *   post:
 *     summary: Déconnexion de l'utilisateur
 *     tags:
 *       - Auth
 *     responses:
 *       200:
 *         description: déconnexion réussie
 *
 */

router.post("/logout", logout);

/**
 * @openapi
 * /auth/check:
 *   get:
 *     summary: Vérifie si l'utilisateur est authentifié
 *     tags:
 *       - Auth
 *     security:
 *       - bearerAuth: []
 *       - cookieAuth: []
 *     responses:
 *       200:
 *         description: utilisateur authentifié ( token valide )
 *       401:
 *         description: Non autorisé (token manquant, invalide/expiré, ou utilisateur inexistant)
 *       
 */

router.get('/check', requireAuth, checkAuth);

export default router;