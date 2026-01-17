import request from 'supertest';
import app from '../src/app.js';
import { describe, it, expect, beforeAll, afterAll } from '@jest/globals';
import { connectDB, disconnectDB, prisma } from '../src/config/db.js';

const testEmailPrefix = 'authtest+';
const uniqueId = () => `${Date.now()}-${Math.random().toString(16).slice(2)}`;
const buildEmail = () => `${testEmailPrefix}${uniqueId()}@example.com`;

describe('Auth routes', () => {
  const loginUser = {
    username: 'LoginUser',
    email: buildEmail(),
    password: 'Password123!',
  };

  // Avant tous les tests, s'assurer que la DB est connectee
  beforeAll(async () => {
    await connectDB();
    await prisma.user.deleteMany({
      where: { email: { startsWith: testEmailPrefix } },
    });

    await request(app).post('/auth/register').send(loginUser);
  });

  // Apres tous les tests, fermer la DB
  afterAll(async () => {
    await prisma.user.deleteMany({
      where: { email: { startsWith: testEmailPrefix } },
    });
    await disconnectDB();
  });

  // -----------------------------
  // Tests Register
  // -----------------------------
  describe('POST /auth/register', () => {
    it('should register a new user successfully', async () => {
      const email = buildEmail();
      const res = await request(app)
        .post('/auth/register') 
        .send({
          username: 'JohnDoe3x',
          email,
          password: 'Password123!',
        });

      expect(res.statusCode).toBe(201);
      expect(res.body.data.user.email).toBe(email); 
    }); 

    it('should fail if email is missing', async () => {
      const res = await request(app)
        .post('/auth/register')
        .send({
          username: 'JaneDoe',
          password: 'Password123!',
        });

      expect(res.statusCode).toBe(400);
      expect(res.body.errors).toBeDefined();
    });

    it('should fail if email is invalid', async () => {
      const res = await request(app)
        .post('/auth/register')
        .send({
          username: 'JaneDoe',
          email: 'not-an-email',
          password: 'Password123!',
        });

      expect(res.statusCode).toBe(400);
      expect(res.body.errors).toBeDefined();
    });

    it('should fail if password is too short', async () => {
      const res = await request(app)
        .post('/auth/register')
        .send({
          username: 'JaneDoe',
          email: buildEmail(),
          password: 'short',
        });

      expect(res.statusCode).toBe(400);
      expect(res.body.errors).toBeDefined();
    });

    it('should fail if email already exists', async () => {
      const email = buildEmail();

      await request(app)
        .post('/auth/register')
        .send({
          username: 'JaneDoe',
          email,
          password: 'Password123!',
        });

      const res = await request(app)
        .post('/auth/register')
        .send({
          username: 'JaneDoe2',
          email,
          password: 'Password123!',
        });

      expect(res.statusCode).toBe(400);
      expect(res.body.error).toBeDefined();
    });

    it('should fail if username is missing', async () => {

      const res = await request(app)
      .post('/auth/register')
      .send({
        email: buildEmail(),
        password: 'Password123!',
      });

      expect(res.statusCode).toBe(400);
      expect(res.body.errors).toBeDefined();

    })
  });

  // -----------------------------
  // Tests Login
  // -----------------------------
  describe('POST /auth/login', () => {
    it('should login successfully with correct credentials', async () => {
      const res = await request(app)
        .post('/auth/login')
        .send({
          email: loginUser.email,
          password: loginUser.password,
        });

      expect(res.statusCode).toBe(200);
      expect(res.body.data.user.email).toBe(loginUser.email);
      expect(res.headers['set-cookie']).toBeDefined(); // JWT cookie envoye
      expect(res.headers['set-cookie'][0]).toContain('HttpOnly');
      expect(res.headers['set-cookie'][0]).toContain('SameSite=Strict');
    });

    it('should fail login with wrong password', async () => {
      const res = await request(app)
        .post('/auth/login')
        .send({
          email: loginUser.email,
          password: 'wrongpassword',
        });

      expect(res.statusCode).toBe(401);
      expect(res.body.error).toBeDefined();
    });

    it('should fail login with non-existing email', async () => {
      const res = await request(app)
        .post('/auth/login')
        .send({
          email: 'doesnotexist@example.com',
          password: 'Password123!',
        });

      expect(res.statusCode).toBe(401);
      expect(res.body.error).toBeDefined();
    });

    it('should fail login with invalid email format', async () => {
      const res = await request(app)
        .post('/auth/login')
        .send({
          email: 'not-an-email',
          password: 'Password123!',
        });

      expect(res.statusCode).toBe(400);
      expect(res.body.errors).toBeDefined();
    });
  });

  // -----------------------------
  // Tests CheckAuth
  // -----------------------------
  describe('GET /auth/check', () => {
    it('should return 401 if no cookie', async () => {
      const res = await request(app).get('/auth/check');
      expect(res.statusCode).toBe(401);
    });

    it('should return user data if cookie is present', async () => {
      const agent = request.agent(app);

      // login pour obtenir le cookie
      await agent.post('/auth/login').send({
        email: loginUser.email,
        password: loginUser.password,
      });

      const res = await agent.get('/auth/check');
      expect(res.statusCode).toBe(200);
      expect(res.body.data.user.email).toBe(loginUser.email);
    });
  });

  // -----------------------------
  // Tests Logout
  // -----------------------------
  describe('POST /auth/logout', () => {
    it('should logout successfully', async () => {
      const agent = request.agent(app);

      // login pour obtenir le cookie
      await agent.post('/auth/login').send({
        email: loginUser.email,
        password: loginUser.password,
      });

      const res = await agent.post('/auth/logout');
      expect(res.statusCode).toBe(200);
      expect(res.body.status).toBe('success');
      expect(res.headers['set-cookie']).toBeDefined();
      expect(res.headers['set-cookie'][0]).toContain('jwt=');
      expect(res.headers['set-cookie'][0]).toContain('Expires=');

      // verifier que /auth/check retourne 401 apres logout
      const check = await agent.get('/auth/check');
      expect(check.statusCode).toBe(401);
    });
  });
});