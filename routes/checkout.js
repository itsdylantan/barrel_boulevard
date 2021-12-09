const express = require('express');
const router = express.Router();

router.get('/', function(req, res, next) {
    res.setHeader('Content-Type', 'text/html');
    res.write("<title>Grocery CheckOut Line</title>");
    res.write('<head><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"> </head>');

    res.write("<h1>Enter your customer id to complete the transaction:</h1>");

    res.write('<form method="get" action="order">');
    res.write('<input type="text" name="customerId" size="50">');
    res.write('<input type="submit" value="Submit"><input type="reset" value="Reset">');
    res.write('</form>');

    res.end();
});

module.exports = router;
