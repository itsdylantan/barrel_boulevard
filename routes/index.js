const express = require('express');
const router = express.Router();

// Rendering the main page
router.get('/', function (req, res) {
    let username = false;
    if (req.session.authenticatedUser) {
        username = req.session.authenticatedUser;
    }

    res.render('index', {
        title: "The Barrel Boulevard Co.",
        username: username
    });
})

module.exports = router;
