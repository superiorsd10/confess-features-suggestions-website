const mongoose = require("mongoose");

const suggestionSchema = new mongoose.Schema({
  body: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("Suggestion", suggestionSchema);
