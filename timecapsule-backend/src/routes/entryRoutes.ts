import express from 'express';
import { createEntry, getEntries, getEntryById, updateEntry, deleteEntry } from '../controllers/entryController';
import { verifyToken } from '../middleware/authMiddleware';

const router = express.Router();

router.post('/', verifyToken, createEntry);
router.get('/', verifyToken, getEntries);
router.get('/:id', verifyToken, getEntryById);
router.put('/:id', verifyToken, updateEntry);
router.delete('/:id', verifyToken, deleteEntry);

export default router;
