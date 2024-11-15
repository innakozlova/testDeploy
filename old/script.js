"use strict";

const elem=document.querySelector('#element');
const button =document.querySelector('#button'); 
const field=document.querySelector('#field'); 
let flag = false;
let textflag=false;

let sum =(a,b) => a+b;

console.log(sum(4,5));

//function changeFocus(){
 //   field.value = 'Я в фокусе';
//}
function changeFocus(){
    flag =!flag;
    if (flag){
        field.type='submit';
    field.value = 'Я теперь кнопка';
    field.style.backgroundColor ='red';
    } else {
        field.type='text';
        field.value = 'Я теперь текстовое поле';
        field.style.backgroundColor ='';
    }
}

//function changeText(){
//    let temp = elem.textContent;
 //       textflag =!textflag;
 //   if (textflag){
 //       elem.innerHTML = `<b>${temp}</b>`
 //       elem.style.color ='green';
 //       button.value='Normal';
 //   } else {
 //       elem.innerHTML = `${temp}`
 //       elem.style.color ='';
 //       button.value='Bold';}
//}

//`<b>${temp}</b>`
button.addEventListener('click', () => {
    let temp = elem.textContent;
        textflag = !textflag;
    if (textflag){
        elem.innerHTML = `<b>${temp}</b>`
        elem.style.color ='green';
        button.value='Normal';
    } else {
        elem.innerHTML = `${temp}`
        elem.style.color ='';
        button.value='Bold';
    }});


field.addEventListener('focus',changeFocus());

//console.log(elem.textContent)

//let a=3;
//let b=7;
//const PI=3.14;
//let array = [1,2,3,4,5]; //массив
//let obj={10:'a',b:6,c:7}; //объект

//function sayHello(param="John") {
 //   console.log('Hello ' + param)
//}
// && оператор И
// || оператор ИЛИ

//if(b >=0 && b<=10)
//    console.log('Лежит в диапазоне');
//console.log(obj[10]);

// for each(let переменная of массив)
//for (let item in array) {
 //   console.log(item);
   // }

    // полный цикл for
    //  start stop  step 
//for(let i =0; i<5; i++){
 //   console.log(array [i]);
//} 

//let count=4;
//while(count > -1) {
 //   console.log(array[count]);
 //   count-=1;
//}

//if(a>b) { 
//    console.log(a+Number(b));
//    console.log(a / b);
//} else if(a==b) {
 //   console.log("Переменные равны");
//} else {
//    var res=5;
 //   console.log("а меньше b");
//}

//console.log(res);
//sayHello('Alexey');
/*
комментарии

*/
