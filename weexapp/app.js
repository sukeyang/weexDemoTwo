const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs')

const app = express();

app.use(express.static('./public'));

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

const server = app.listen(3000, function() {

    const host = server.address().address
    const port = server.address().port

    console.log('Server is working!')
})


app.all('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    res.header("Access-Control-Allow-Methods", "POST,GET");
    res.header("X-Powered-By", ' 3.2.1')
    res.header("Content-Type", "application/json;charset=utf-8");
    next();
});

app.post('/login', function(req, res) {
    if (req.body.name === userInfo.name && req.body.password === userInfo.password) {
        let _json = Object.assign(successJson)
        _json.result = {
            name: req.body.name
        }
        res.json(_json)
    } else {
        let _json = Object.assign(failJson)
        res.json(_json)
    }

});





app.get('/env', function(req, res) {
    res.json({
        code: 200,
        msg: {
            devEnv: 'dev',
            podEnv: 'pod'
        }
    });
});

var userInfo = {
    name: 'admin',
    password: '123456'
}

var successJson = {
    code: 200,
    msg: 'success',
    result: {}
}

var failJson = {
    code: 100,
    msg: 'fail',
    result: {}
}
