export const validate = (schema) => (req, res, next) => {
  try {
    req.body = schema.parse(req.body);
    next();
  } catch (error) {
    return res.status(400).json({
      status: "errors:",
      errors: error.issues.map((issue) => ({
        field: issue.path[0],
        message: issue.message,
      })),
    });
  }
};
