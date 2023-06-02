const mongoose = require('mongoose');

const Schema = mongoose.Schema;
// creation de schéma
const NotificationSchema = new Schema({
   title: { type: String, default: 'hahaha' },
   created:  { type: Date},
});

const Notification = mongoose.model('Notification', NotificationSchema);

module.exports = Notification