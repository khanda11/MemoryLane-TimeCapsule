"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const entryController_1 = require("../controllers/entryController");
const authMiddleware_1 = require("../middleware/authMiddleware");
const router = express_1.default.Router();
router.post('/', authMiddleware_1.verifyToken, entryController_1.createEntry);
router.get('/', authMiddleware_1.verifyToken, entryController_1.getEntries);
router.get('/:id', authMiddleware_1.verifyToken, entryController_1.getEntryById);
router.put('/:id', authMiddleware_1.verifyToken, entryController_1.updateEntry);
router.delete('/:id', authMiddleware_1.verifyToken, entryController_1.deleteEntry);
exports.default = router;
