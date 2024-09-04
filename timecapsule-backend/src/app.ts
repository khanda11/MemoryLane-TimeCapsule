import express from 'express';
import mongoose from 'mongoose';
import authRoutes from './routes/authRoutes';
import entryRoutes from './routes/entryRoutes'; // Ensure correct import
import dotenv from 'dotenv';
import { verifyToken } from './middleware/authMiddleware'; // Correct middleware import

dotenv.config();

const app = express();

app.use(express.json());

app.use('/api/auth', authRoutes);

// Ensure that the routes are registered with the correct path
app.use('/api/entries', verifyToken, entryRoutes); 

const PORT = process.env.PORT || 5000;

mongoose.connect(process.env.MONGO_URI as string)
  .then(() => app.listen(PORT, () => console.log(`Server running on port ${PORT}`)))
  .catch(error => console.error('Error connecting to MongoDB:', error));
