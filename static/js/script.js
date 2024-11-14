"use strict";
let a=3;
let b=7;
let array = [1,2,3,4,5]; //массив
let obj={10:'a',b:6,c:7}; //объект

function sayHello(param="John") {
    console.log('Hello ' + param)
}

console.log(obj[10]);

// for each(let переменная of массив)
//for (let item in array) {
 //   console.log(item);
   // }

    // полный цикл for
    //  start stop  step 
for(let i =0; i<5; i++){
    console.log(array [i]);
} 

let count=4;
while(count > -1) {
    console.log(array[count]);
    count-=1;
}

if(a>b) { 
    console.log(a+Number(b));
    console.log(a / b);
} else if(a==b) {
    console.log("Переменные равны");
} else {
    var res=5;
    console.log("а меньше b");
}

console.log(res);
sayHello('Alexey');
/*
комментарии

*/

