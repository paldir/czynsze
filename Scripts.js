function isInteger(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function isFloat(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode != 46 &&(charCode < 48 || charCode > 57)))
        return false;
    return true;
}

function isDate(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode != 45 &&(charCode < 48 || charCode > 57)))
        return false;
    return true;
}

function replaceBushes(){
   regExp=new RegExp(String.fromCharCode(185), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#261;')

   regExp=new RegExp(String.fromCharCode(230), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#263;')

   regExp=new RegExp(String.fromCharCode(234), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#281;')

   regExp=new RegExp(String.fromCharCode(179), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#322;')

   regExp=new RegExp(String.fromCharCode(241), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#324;')

   regExp=new RegExp(String.fromCharCode(243), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#243;')

   regExp=new RegExp(String.fromCharCode(339), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#347;')

   regExp=new RegExp(String.fromCharCode(376), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#378;')

   regExp=new RegExp(String.fromCharCode(191), "g")
   document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#380;')
}