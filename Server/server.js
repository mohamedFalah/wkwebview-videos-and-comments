var express = require('express');
var bodyParser = require('body-parser');

var app = express();

//allow to speak to backend by adding something to response header 
app.all('/*', function(req, res, next){
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Headers', 'X-Requsted-With', 'Content-Type, Accept');
    res.header('Access-Control-Allow-Methods', 'POST, GET');
    next();
});

//middlewear 
app.use(bodyParser.json());
app.unsubscribe(bodyParser.urlencoded({extended: false}));

var tutorials = [
{
    id: 1,
    title: "Android Development for Beginners - Full Course 1",
    description: "Learn how to develop an android app from scratch in this full course for beginners. No prior programming experience required!",
    iframe: '<div class="container"><iframe src="https://www.youtube.com/embed/fis26HvvDII" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" class="video" allowfullscreen></iframe></div>',
    thumbnail: "https://i.pinimg.com/564x/c7/d2/56/c7d256740c72e03772c293c0b828b59b.jpg"
},
{
    id: 2,
    title: "Android Development for Beginners - Full Course 2",
    description: "Learn how to develop an android app from scratch in this full course for beginners. No prior programming experience required!",
    iframe: '<div class="container"><iframe src="https://www.youtube.com/embed/fis26HvvDII" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen class="video" ></iframe></div>',
    thumbnail: "https://i.pinimg.com/564x/c7/d2/56/c7d256740c72e03772c293c0b828b59b.jpg"
},
{
    id: 3,
    title: "Android Development for Beginners - Full Course 3",
    description: "Learn how to develop an android app from scratch in this full course for beginners. No prior programming experience required!",
    iframe: '<div class="container"><iframe  src="https://www.youtube.com/embed/fis26HvvDII" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" class="video" allowfullscreen></iframe></div>',
    thumbnail: "https://i.pinimg.com/564x/c7/d2/56/c7d256740c72e03772c293c0b828b59b.jpg"
}

];

var comments = [
{
    "username": "mohammed falah",
    "comment": "nice tutorial"
}

];

app.post('/comment', function(req, res) {
    var comment = req.body;
    if(comment) {
        if (comment.username && comment.comment){
            comments.push(comment);
        } else {
            res.send("invalid data");
        }
    }else {
        res.send("empty data");
    }

    res.send("comment added");
});

app.get('/comments', function(req, res) {
    res.send(comments)  
});

app.get('/tutorials', function(req, res) {
  res.send(tutorials)  
});

app.listen(6069);