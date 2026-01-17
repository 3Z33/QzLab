import { z } from 'zod'

export const usernameSchema = z
  .string()
  .trim()
  .min(3, 'Le nom d\'utilisateur doit contenir au moins 3 caractères')
  .max(20, 'Le nom d\'utilisateur ne peut pas dépasser 20 caractères')
  .regex(
    /^[a-zA-Z0-9_-]+$/,
    'Seuls les lettres, chiffres, tirets et underscores sont autorisés'
  )

export const emailSchema = z
  .string()
  .trim()
  .email('Veuillez saisir une adresse email valide')

export const passwordSchema = z
  .string()
  .min(8, 'Au moins 8 caractères')
  .max(64, 'Maximum 64 caractères')
  .regex(/[A-Z]/, 'Au moins une majuscule')
  .regex(/\d/, 'Au moins un chiffre')
  .regex(
    /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/,
    'Au moins un caractère spécial'
  )

export const registerSchema = z
  .object({
    username: usernameSchema,
    email: emailSchema,
    password: passwordSchema,
    confirmPassword: z.string()
  })
  .refine(
    data => data.password === data.confirmPassword,
    {
      message: 'Les mots de passe ne correspondent pas',
      path: ['confirmPassword']
    }
  )


