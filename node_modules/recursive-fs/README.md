
#Install
```
$ npm install recursive-fs
```

#Recursive

##readdirr
```js
var path = require('path');
var recursive = require('recursive-fs');

var root = path.resolve(process.argv[2]);
recursive.readdirr(root, function (err, dirs, files) {
    if (err) {
        console.log(err);
    } else {
        console.log('DONE!');
    }
});
```

##rmdirr
```js
var path = require('path');
var recursive = require('recursive-fs');

var root = path.resolve(process.argv[2]);
recursive.rmdirr(root, function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log('DONE!');
    }
});
```

##cpdirr
```js
var path = require('path');
var recursive = require('recursive-fs');

var spath = path.resolve(process.argv[2]),
    tpath = path.resolve(process.argv[3]);
recursive.cpdirr(spath, tpath, function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log('DONE!');
    }
});
```

##Tests
```
$ mocha
```
