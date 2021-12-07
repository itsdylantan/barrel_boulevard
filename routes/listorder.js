const express = require('express');
const router = express.Router();
const sql = require('mssql');
const moment = require('moment');

router.get('/', function(req, res, next) {
    res.setHeader('Content-Type', 'text/html');
    (async function() {
        try {
            let pool = await sql.connect(dbConfig);

            res.write('<title>YOUR NAME Grocery Order List</title>');

            let sqlQuery = "SELECT orderId, O.CustomerId, totalAmount, firstName+' '+lastName as cname, orderDate FROM OrderSummary O, Customer C WHERE O.customerId = C.customerId";
            let result = await pool.request().query(sqlQuery);
            
            res.write("<h1>Order List</h1>");
            res.write('<table border=\"1\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>');

            for (let i = 0; i < result.recordset.length; i++) {
                let record = result.recordset[i];
                orderId = record.orderId;
                orderDate = new Date(record.orderDate);
                res.write("<tr><td>" + orderId + "</td>");
                res.write("<td>" + moment(orderDate).format('Y-MM-DD HH:mm:ss') + "</td>");
                res.write("<td>" + record.CustomerId + "</td>");
                res.write("<td>" + record.cname + "</td>");
                res.write("<td>$" + record.totalAmount.toFixed(2) + "</td>");
                res.write("</tr>");

                let orderedProducts = await pool.request()
                    .input('id', sql.Int, orderId)
                    .query('SELECT productId, quantity, price FROM OrderProduct WHERE orderId=@id')
                
                res.write("<tr align=\"right\"><td colspan=\"5\"><table border=\"1\">");
                res.write("<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
                for (let j = 0; j < orderedProducts.recordset.length; j++) {
                    let product = orderedProducts.recordset[j];
                    res.write("<tr><td>" + product.productId + "</td>");
                    res.write("<td>" + product.quantity + "</td>");
                    res.write("<td>$" + product.price.toFixed(2) + "</td></tr>");
                }
                res.write("</table></td></tr>");
            }

            res.write("</table>");

            res.end();
        } catch(err) {
            console.dir(err);
            res.write(err + "");
            res.write("<h3>Has the data been loaded?</h3>")
            res.end();
        }
    })();
});

module.exports = router;
