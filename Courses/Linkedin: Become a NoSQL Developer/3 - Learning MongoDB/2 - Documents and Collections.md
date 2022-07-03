# Documents and Collections

Start Mongo

```bash
mongo
```

And go into cooker db

```js
use cooker;

// test with db.recipes.find();
```

## Create a document

```js
doc = {"title": "Tacos", "desc": "tacos desc", cook_time: 20 };
// Create var with dictionary

db.tacos.insertOne(doc);
// insert document

db.tacos.find();
// or
db.tacos.find().pretty();
// to see the documents
```

## Using .find() to query documents

```js
db.recipes.find();
// get everything

db.recipes.find({ "title" : "Tacos"}).pretty();
// or w/out .pretty
// Gets all the documents with the title Tacos

db.recipes.find({ "title" : "Tacos"}, {"title": 1}).pretty();
// return only the title

db.recipes.find({ "title" : "Tacos"}, {"title": 0}).pretty();
// return everything but the title

db.recipes.find({}, {"title": 1}).pretty();
// Returns only the title in every document

//We can use regex here too.
db.recipes.find({"title" : { $regex: /taco/i }}, {"title": 1}).pretty();
```

## Challenge

Create a recipe in a new collection with the following fields:  
![challenge_1](https://i.imgur.com/q6xndHZ.png)

```js
clrecipe1 = { "title": "Bacalhau à Bras", "description" : "Melhor que bacalhau com natas", "star_ratings" : 4.9, "tags" : ["portuguese", "good", "godlike"], "user_comments": [{"user_name": "Marcelo Recebo de Sousa", "comment" : "comi este bacalhau em agosto, e passei muito mal"}, {"user_name" : "Marta Temido", "comment": "Eu e a Graça Freitas gostámos muito, um esbedaculo!!" }], "ingredients" : ["bacalhau", "pala-pala marca dia"], "directions" : ["Primeiro vira à direita", "Depois vai em frente", "Quando vir o pelourinho da nossa senhora de fatima", "Corta à esquerda"]}
db.challenge.insertOne(clrecipe1);
```

