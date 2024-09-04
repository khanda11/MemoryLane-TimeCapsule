import mongoose, { Document, Schema } from 'mongoose';

interface IEntry extends Document {
  title: string;
  content: string;
  date: Date;
  userId: string; 
}

const entrySchema: Schema = new Schema({
  title: { type: String, required: true },
  content: { type: String, required: true },
  date: { type: Date, default: Date.now },
  userId: { type: String, required: true } 
});

const Entry = mongoose.model<IEntry>('Entry', entrySchema);

export default Entry;
