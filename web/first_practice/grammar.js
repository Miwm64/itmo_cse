"use strict"; // enforce stricter error handling
/*
 covers topics:
 basics
 declarations, comments
*/


// vars
let 漢字123ыфasdads = "漢字123ыфasdads text"; // utf-8 symbols can be a name of a variable, global
const a = 1
var b = 2 // var is for both local and global vars
const {c} = a

const d = c; // surprisingly, they are constant - can not be changed
const MY_OBJECT = { key: "value" };
MY_OBJECT.key = "otherValue";
// const means - u can not reassign objects, but can change values

var y;

let x; // var variables can be called before initialization
++x; // now variable becomes NaN

/*
console.log(f)
if (Math.random() > 0.5) {
    const e = 5;
}
console.log(e); // ReferenceError: y is not defined
*/

var f; // var variables are hoisted - moved to top of the file before execution
// const z; - const must be initialized
// comments are like
/*
* java, c++
* */

/*
alert(漢字123ыфasdads);
[1, 2].forEach(alert);
 */

function square(number) {
    return (number * number).toFixed(100); // number calculation has non infinite precision
}

console.log(square(1.2321321/3));