# Querying

## Sort, Limit and Skip

![img1](https://i.imgur.com/kFzQ6Ak.png)

![img2](https://i.imgur.com/Y2XDu4Q.png)

```js
db.recipes.find({}, {"title": 1}).count();
// count all documents in recipes collection

db.recipes.find({}, {"title": 1}).limit(4);
// limit to 4 searches

db.recipes.find({}, {"title": 1}).sort({"title": 1})
// sort by title

db.recipes.find({}, {"title": 1}).skip(1)
// skip first entry

db.recipes.find({}, {"title": 1}).skip(1).limit(1)
// skip first entry and limit to 1
```

## Operators and arrays

![img2](https://i.imgur.com/kbeaKPs.png)

```js
db.recipes.find({"cook_time": { $lte : 30}, "prep_time" : { $lte : 10}}, {"title" : 1})

db.recipes.find({ $or: [{"cook_time": { $lte : 30}}, {"prep_time" : { $lte : 10}} ] }, {"title" : 1});
// or {query [array {conditon 1}, {condition 2} ]}
```

For arrays

```js
db.recipes.find({ "tags" : "easy"}, {"title" : 1, "tags": 1});
// works, but if we want to match two tags, deparately?

db.recipes.find({ "tags" : ["easy", "mexican"]}, {"title" : 1, "tags": 1});
// not like this

db.recipes.find({ "tags" : { $all: ["quick", "easy"] } }, {"title" : 1, "tags": 1});
// But like this

// Easy OR Mexican?
db.recipes.find({ "tags" : { $in: ["quick", "easy"] } }, {"title" : 1, "tags": 1});
```

Inside an object

```js
db.recipes.find({ "ingredients.name" : "egg"}, {"title" : 1, "tags": 1});
```

## Updating documents

![img3](https://i.imgur.com/rjEXXSE.png)

```js
db.examples.updateOne({"title" : "Pizza"}, { $set : {"title" : "This crust pizza"}})
// Update a document if key exists
db.examples.find({}, {"title": 1})


db.examples.updateOne({"title" : "This crust pizza"}, { $set : {"vegan" : false}})
// Update a column if key doesnt exist -> add key

db.examples.updateOne({"title" : "This crust pizza"}, { $unset : {"vegan" : 1}})
// Update a column if key doesnt exist -> Removes the key. (DOES NOT CHANGE IT TO 1, 1 HERE IS TO "REMOVE? TRUE")

db.examples.updateOne({"title" : "Tacos"}, {$inc : { "likes_count": 1}})
// here 1 is increment by how much. IN this case, by 1
db.examples.find({"title" : "Tacos"}).pretty()
db.examples.updateOne({"title" : "Tacos"}, {$inc : { "likes_count": -1}})
```

## Updating Arrays

![img4](https://i.imgur.com/C0J2Zzr.png)

```js
db.examples.updateOne({"title" : "Tacos"}, { $push : {"likes":60}})
// Push an element to the array "likes"
db.examples.find({"title" : "Tacos"}).pretty()

db.examples.updateOne({"title" : "Tacos"}, { $pull : {"likes":60}})
// pull an element
```

## Deleting Documents

```js
db.examples.find({}, {"title": 1})

db.examples.deleteOne({ "_id" : ObjectId("5ee69e393260aab97ea0d58e")})
// delete the document

db.examples.find({}, {"title": 1})
```