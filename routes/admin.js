const express = require('express');
const router = express.Router();
const auth = require('../auth');
const sql = require('mssql');

router.get('/', function(req, res, next) {
    let authenticated = auth.checkAuthentication(req, res);
    // Stop rendering the page if we aren't authenticated
    if (!authenticated) {
        return;
    }

    let username = req.session.authenticatedUser;

    res.setHeader('Content-Type', 'text/html');

    (async function() {
        try {
            let pool = await sql.connect(dbConfig);
            res.write('<head><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"> </head>');

            res.write("<title>Administrator Page</title>");
            res.write("<h3>Administrator Sales Report by Day</h3>")

            let sqlQuery = "select year(orderDate) as year, month(orderDate) as month, day(orderDate) as day, SUM(totalAmount) as totalSum FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
            let result = await pool.request().query(sqlQuery);

            res.write("<table class=\"table\" border=\"1\">");
            res.write("<tr><th>Order Date</th><th>Total Order Amount</th>");
            for (let i = 0; i < result.recordset.length; i++) {
                let record = result.recordset[i];
                res.write("<tr><td>" + record.year + "-" + record.month + "-" + record.day + "</td><td>$" + record.totalSum.toFixed(2) + "</td></tr>");
            }
            res.write("</table>");

            res.end();
        } catch(err) {
            console.dir(err);
            res.write(err + "");
            res.end();
        }
    })();
});

module.exports = router;