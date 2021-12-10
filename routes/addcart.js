const express = require('express');
const router = express.Router();

router.get('/', function(req, res, next) {
    res.setHeader('Content-Type', 'text/html');
    res.write('<head><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"> </head>');

    // If the product list isn't set in the session,
    // create a new list.
    let productList = false;
    if (!req.session.productList) {
        productList = [];
    } else {
        productList = req.session.productList;
    }

    // Add new product selected
    // Get product information
    let id = false;
    let name = false;
    let price = false;
    if (req.query.id && req.query.name && req.query.price) {
        id = req.query.id;
        name = req.query.name;
        price = req.query.price;
    } else {
        res.redirect("/listprod");
    }

    // Update quantity if add same item to order again
    if (productList[id]){
        productList[id].quantity = productList[id].quantity + 1;
    } else {
        productList[id] = {
            "id": id,
            "name": name,
            "price": price,
            "quantity": 1
        };
    }

    req.session.productList = productList;
    res.redirect("/showcart");
});

module.exports = router;
