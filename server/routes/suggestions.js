const express = require('express');

const router = express.Router();

const Suggestion = require('../models/suggestion');

router.post('/', async(req, res) => {
    const suggestion = new Suggestion({
        body: req.body.body,
    });

    try{
        const savedSuggestion = await suggestion.save();
        res.json(savedSuggestion);
    } catch(err){
        res.send('Error: ' + err);
    }
});

module.exports = router;