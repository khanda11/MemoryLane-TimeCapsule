// src/custom.d.ts or src/types/express/index.d.ts
import { Request } from 'express';

declare module 'express-serve-static-core' {
  interface Request {
    user?: {
      id: string; // Ensure this matches the structure you're using
    };
  }
}
