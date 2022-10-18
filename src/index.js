const express = require('express');
const app = express();
const router = require('./routers');
const cors = require('cors');


app.use(express.json())
app.use(cors({
    credentials: true,
    origin: 'http://172.16.4.184:5174'
}))
app.use(express.urlencoded({extended:true}));
app.use('/api', router);

app.listen(5555, '172.16.4.184',() => {
    console.log('Server is online!');
});