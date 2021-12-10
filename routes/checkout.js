const express = require('express');
const router = express.Router();

router.get('/', function(req, res, next) {
    res.setHeader('Content-Type', 'text/html');
<<<<<<< HEAD
    res.write("<title>Grocery CheckOut Line</title>");
=======
    res.write("<title>BBC CheckOut Line</title>");
>>>>>>> 0fa20cf62a5a208458b64cdaa11492e6b230df78

    res.write("<h1>Enter your customer id to complete the transaction:</h1>");

    res.write('<form method="get" action="order">');
    res.write('<input type="text" name="customerId" size="50">');
    res.write('<input type="submit" value="Submit"><input type="reset" value="Reset">');
    res.write('</form>');

    res.end();
});

module.exports = router;
