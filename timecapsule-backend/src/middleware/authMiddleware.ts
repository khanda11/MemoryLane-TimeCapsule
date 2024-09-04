import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

interface JwtPayload {
  userId: string;
}

export const verifyToken = (req: Request, res: Response, next: NextFunction) => {
  const token = req.header('Authorization')?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access Denied' });

  try {
    const verified = jwt.verify(token, process.env.JWT_SECRET as string) as JwtPayload;
    if (verified && verified.userId) {
      (req as any).user = { id: verified.userId }; // Temporarily use `as any` to bypass TypeScript error
    }
    next();
  } catch (err) {
    res.status(400).json({ message: 'Invalid Token' });
  }
};
