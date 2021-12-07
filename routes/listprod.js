const express = require('express');
const router = express.Router();
const sql = require('mssql');

router.get('/', function(req, res, next) {
    res.setHeader('Content-Type', 'text/html');
    (async function() {
        try {
            let pool = await sql.connect(dbConfig);

            res.write('<title>Barrel Boulevard</title>');
            res.write('<h1>Search for products you want to buy:</h1>')
            
            res.write('<form method="get" action="listprod">');
            res.write('<select size="1" name="categoryName">');
            res.write('<option>All</option>');
            res.write('<option>Beverages</option>');
            res.write('<option>Condiments</option>');
            res.write('<option>Confections</option>');
            res.write('<option>Dairy Products</option>');
            res.write('<option>Grains/Cereals</option>');
            res.write('<option>Meat/Poultry</option>');
            res.write('<option>Produce</option>');
            res.write('<option>Seafood</option>');  
            res.write('<option>Whiskey</option>');  
            res.write('</select>');
            res.write('<input type="text" name="productName" size="50">');
            res.write('<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave Blank for all products)');
            res.write('</form>');
            
            let sqlQuery = false;
            let filter = false;
            let name = req.query.productName;
            let category = req.query.categoryName;
            // Truthy conversion for parameters
            let hasNameParam = name !== undefined && name !== "";
            let hasCategoryParam = category !== undefined && category !== "" && category.toUpperCase() !== "ALL";
            let products = false;

            if (hasNameParam && hasCategoryParam) {
                filter = "<h2>Products containing '" + name + "' in category: '" + category + "'</h2>";
                name = '%' + name + '%';
                sqlQuery = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE @name AND categoryName = @category";
            } else if (hasNameParam) {
                filter = "<h2>Products containing '" + name + "'</h2>";
                name = '%' + name + '%';
                sqlQuery = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE @name";
            } else if (hasCategoryParam) {
                filter = "<h2>Products in category: '" + category + "'</h2>";
                sqlQuery = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE categoryName = @category";
            } else {
                filter = "<h2>All Products</h2>";
                sqlQuery = "SELECT productId, productName, productPrice, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId";
            }

            res.write(filter);

            if (hasNameParam) {
                if (hasCategoryParam) {
                    products = await pool.request()
                        .input('name', sql.VarChar, name)
                        .input('category', sql.VarChar, category)
                        .query(sqlQuery);
                } else {
                    products = await pool.request()
                        .input('name', sql.VarChar, name)
                        .query(sqlQuery);
                }
            } else if (hasCategoryParam) {
                products = await pool.request()
                    .input('category', sql.VarChar, category)
                    .query(sqlQuery);
            } else {
                products = await pool.request()
                    .query(sqlQuery);
            }

            res.write("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
            for (let i = 0; i < products.recordset.length; i++) {
                let product = products.recordset[i];
                res.write("<tr><td><a href=\"addcart?id=" + product.productId + "&name=" + product.productName + "&price=" + product.productPrice.toFixed(2) + "\">Add to Cart</a></td>");
                res.write("<td><a href=\"product?id=" + product.productId + "\">" + product.productName + "</a></td><td>$" + product.productPrice.toFixed(2) + "</td></tr>");
            }
            res.write("</table>");

            res.end()
        } catch(err) {
            console.dir(err);
            res.write(err + "")
            res.end();
        }
    })();
});

module.exports = router;
