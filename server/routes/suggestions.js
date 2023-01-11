const express = require("express");

const router = express.Router();

const Suggestion = require("../models/suggestion");

router.post("/", async (req, res) => {
  const suggestion = new Suggestion({
    body: req.body.body,
  });

  console.log(req.body);

  try {
    const savedSuggestion = await suggestion.save();
    console.log(savedSuggestion);
    res.json(savedSuggestion);
  } catch (err) {
    res.send("Error: " + err);
    console.log(err);
  }
});

module.exports = router;
