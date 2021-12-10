const express = require('express');
const router = express.Router();
const sql = require('mssql');

router.get('/', function(req, res, next) {
    res.setHeader('Content-Type', 'text/html');

    let listProds = false;

    if(req.session.listProds){
        listProds = req.session.listProds;
    }

    idx = req.query.id;
    
    let id = false;

    if (productList[id]){
        delete productList[id];
    } 

    req.session.productList = productList;
    res.redirect("/showcart");
});

module.exports = router;