const express = require('express');
const router = express.Router();

// Rendering the main page
router.get('/', function (req, res) {
    let username = false;

    res.render('index', {
<<<<<<< HEAD
        title: "The Barrel Boulevard",
        username: username
=======
        title: "YOUR NAME Grocery Main Page",
        username: req.session.authenticatedUser, 
        pageActive: {'home': true}
>>>>>>> f7c34fc54c80c5c9709d9e8a8a9b643bb728ea4a
    });
})

module.exports = router;
