"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteEntry = exports.updateEntry = exports.getEntryById = exports.getEntries = exports.createEntry = void 0;
const entryModel_1 = __importDefault(require("../models/entryModel"));
// Create a new entry
const createEntry = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const { title, content } = req.body;
        const userId = (_a = req.user) === null || _a === void 0 ? void 0 : _a.id; // Ensure user ID is correctly typed
        if (!userId) {
            return res.status(401).json({ error: 'User not authenticated' });
        }
        const newEntry = new entryModel_1.default({
            title,
            content,
            userId,
            date: new Date()
        });
        yield newEntry.save();
        res.status(201).json(newEntry);
    }
    catch (error) {
        console.error('Error creating entry:', error);
        res.status(500).json({ error: 'Error creating entry' });
    }
});
exports.createEntry = createEntry;
// Get all entries
const getEntries = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const entries = yield entryModel_1.default.find();
        res.status(200).json(entries);
    }
    catch (error) {
        console.error('Error fetching entries:', error);
        res.status(500).json({ message: 'Failed to fetch entries' });
    }
});
exports.getEntries = getEntries;
// Get entry by ID
const getEntryById = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const entry = yield entryModel_1.default.findById(req.params.id);
        if (!entry) {
            return res.status(404).json({ message: 'Entry not found' });
        }
        res.status(200).json(entry);
    }
    catch (error) {
        console.error('Error fetching entry:', error);
        res.status(500).json({ message: 'Error fetching entry' });
    }
});
exports.getEntryById = getEntryById;
// Update an entry by ID
const updateEntry = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b;
    try {
        const { title, content } = req.body;
        const entry = yield entryModel_1.default.findById(req.params.id);
        // Check if the entry exists
        if (!entry) {
            return res.status(404).json({ message: 'Entry not found' });
        }
        // Debugging: Log userId from token and entry's userId
        console.log('User ID from token:', (_a = req.user) === null || _a === void 0 ? void 0 : _a.id);
        console.log('Entry userId:', entry.userId);
        // Ensure `entry.userId` is defined before using `.toString()`
        if (!entry.userId || entry.userId.toString() !== ((_b = req.user) === null || _b === void 0 ? void 0 : _b.id)) {
            return res.status(401).json({ message: 'Unauthorized' });
        }
        entry.title = title || entry.title;
        entry.content = content || entry.content;
        yield entry.save();
        res.status(200).json(entry);
    }
    catch (error) {
        console.error('Error updating entry:', error);
        res.status(500).json({ message: 'Error updating entry' });
    }
});
exports.updateEntry = updateEntry;
// Delete an entry by ID
const deleteEntry = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    try {
        const entry = yield entryModel_1.default.findById(req.params.id);
        if (!entry) {
            return res.status(404).json({ message: 'Entry not found' });
        }
        if (entry.userId.toString() !== ((_a = req.user) === null || _a === void 0 ? void 0 : _a.id)) {
            return res.status(401).json({ message: 'Unauthorized' });
        }
        yield entryModel_1.default.deleteOne({ _id: entry._id });
        res.status(200).json({ message: 'Entry deleted' });
    }
    catch (error) {
        console.error('Error deleting entry:', error);
        res.status(500).json({ message: 'Error deleting entry' });
    }
});
exports.deleteEntry = deleteEntry;
