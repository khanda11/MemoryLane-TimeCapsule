import { RequestHandler } from 'express';
import Entry from '../models/entryModel';

// Create a new entry
export const createEntry: RequestHandler = async (req, res) => {
  try {
    const { title, content } = req.body;
    const userId = req.user?.id; // Ensure user ID is correctly typed

    if (!userId) {
      return res.status(401).json({ error: 'User not authenticated' });
    }

    const newEntry = new Entry({
      title,
      content,
      userId,
      date: new Date()
    });

    await newEntry.save();
    res.status(201).json(newEntry);
  } catch (error) {
    console.error('Error creating entry:', error);
    res.status(500).json({ error: 'Error creating entry' });
  }
};

// Get all entries
export const getEntries: RequestHandler = async (req, res) => {
  try {
    const entries = await Entry.find();
    res.status(200).json(entries);
  } catch (error) {
    console.error('Error fetching entries:', error);
    res.status(500).json({ message: 'Failed to fetch entries' });
  }
};

// Get entry by ID
export const getEntryById: RequestHandler = async (req, res) => {
  try {
    const entry = await Entry.findById(req.params.id);
    if (!entry) {
      return res.status(404).json({ message: 'Entry not found' });
    }

    res.status(200).json(entry);
  } catch (error) {
    console.error('Error fetching entry:', error);
    res.status(500).json({ message: 'Error fetching entry' });
  }
};

// Update an entry by ID
export const updateEntry: RequestHandler = async (req, res) => {
  try {
    const { title, content } = req.body;
    const entry = await Entry.findById(req.params.id);

    // Check if he entry exists
    if (!entry) {
      return res.status(404).json({ message: 'Entry not found' });
    }

  
    console.log('User ID from token:', req.user?.id);
    console.log('Entry userId:', entry.userId);

    // Ensure `entry.userId` is defined before using `.toString()`
    if (!entry.userId || entry.userId.toString() !== req.user?.id) {
      return res.status(401).json({ message: 'Unauthorized' });
    }

    entry.title = title || entry.title;
    entry.content = content || entry.content;
    await entry.save();

    res.status(200).json(entry);
  } catch (error) {
    console.error('Error updating entry:', error);
    res.status(500).json({ message: 'Error updating entry' });
  }
};
// Delete an entry by ID
export const deleteEntry: RequestHandler = async (req, res) => {
  try {
    const entry = await Entry.findById(req.params.id);

if (!entry) {
  return res.status(404).json({ message: 'Entry not found' });
}

if (entry.userId.toString() !== req.user?.id) {
  return res.status(401).json({ message: 'Unauthorized' });
}

await Entry.deleteOne({ _id: entry._id });
res.status(200).json({ message: 'Entry deleted' });
  } catch (error) {
    console.error('Error deleting entry:', error);
    res.status(500).json({ message: 'Error deleting entry' });
  }
};
