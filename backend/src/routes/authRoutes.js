import express from "express";
import { register, login, logout, checkAuth } from "../controllers/authController.js";
import { requireAuth } from "../middleware/requireAuth.js";


const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/logout", logout);
router.get('/check', requireAuth, checkAuth);

export default router;