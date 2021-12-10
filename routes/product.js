const express = require('express');
const router = express.Router();
const sql = require('mssql');

router.get('/', function(req, res, next) {
    res.setHeader('Content-Type', 'text/html');
    (async function() {
        try {
            router.get('/', function (req, res) {
                let username = false;
                if (req.session.authenticatedUser) {
                    username = req.session.authenticatedUser;
                }
            
                res.render('product.handlebars', {
                    title: "The Barrel Boulevard Co.",
                    username: username
                });
            })
            let pool = await sql.connect(dbConfig);
            res.write('<head><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"> </head>');

            res.write('<title>YOUR NAME Grocery - Product Information</title>');

            let sqlQuery = "SELECT productId, productName, productPrice, productImageURL, productImage FROM Product P  WHERE productId = @id";
            let productId = req.query.id;

            if (productId === undefined || productId === "") {
                res.write("Invalid product");
                res.end();
                return;
            }

            result = await pool.request()
                .input('id', sql.Int, productId)
                .query(sqlQuery);

            if (result.recordset.length === 0) {
                res.write("Invalid product");
            } else {
                let product = result.recordset[0];

                res.write("<h2>" + product.productName + "</h2>");
		
                res.write("<table><tr>");
                res.write("<th>Id</th><td>" + product.productId + "</td></tr>"				
                        + "<tr><th>Price</th><td>$" + product.productPrice.toFixed(2) + "</td></tr>");
                
                //  Retrieve any image with a URL
                imageLoc = product.productImageURL;
                if (imageLoc != null)
                    res.write("<img src=\"" + imageLoc + "\">");
                
                // Retrieve any image stored directly in database
                imageBinary = product.productImage;
                if (imageBinary != null)
                    res.write("<img src=\"displayImage?id=" + product.productId + "\">");	
                res.write("</table>");
                

                res.write("<h3><a href=\"addcart?id=" + product.productId + "&name=" + product.productName
                                        + "&price=" + product.productPrice + "\">Add to Cart</a></h3>");		
                
                res.write("<h3><a href=\"listprod\">Continue Shopping</a>");
            }

            res.end()
        } catch(err) {
            console.dir(err);
            res.write(err + "")
            res.end();
        }
    })();
});

module.exports = router;
