"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const mongoose_1 = __importDefault(require("mongoose"));
const authRoutes_1 = __importDefault(require("./routes/authRoutes"));
const entryRoutes_1 = __importDefault(require("./routes/entryRoutes")); // Ensure correct import
const dotenv_1 = __importDefault(require("dotenv"));
const authMiddleware_1 = require("./middleware/authMiddleware"); // Correct middleware import
dotenv_1.default.config();
const app = (0, express_1.default)();
app.use(express_1.default.json());
app.use('/api/auth', authRoutes_1.default);
// Ensure that the routes are registered with the correct path
app.use('/api/entries', authMiddleware_1.verifyToken, entryRoutes_1.default);
const PORT = process.env.PORT || 5000;
mongoose_1.default.connect(process.env.MONGO_URI)
    .then(() => app.listen(PORT, () => console.log(`Server running on port ${PORT}`)))
    .catch(error => console.error('Error connecting to MongoDB:', error));
