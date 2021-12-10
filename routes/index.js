const express = require('express');
const router = express.Router();

// Rendering the main page
router.get('/', function (req, res) {
    let username = false;

    res.render('index', {
        title: "YOUR NAME Grocery Main Page",
        username: req.session.authenticatedUser, 
        pageActive: {'home': true}
    });
})

module.exports = router;
