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
    if (localStorage.bushes!="bushesRemoved") {
     //a
     regExp=new RegExp(String.fromCharCode(185), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#261;')
     //c
     regExp=new RegExp(String.fromCharCode(230), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#263;')
     //e
     regExp=new RegExp(String.fromCharCode(234), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#281;')
     //l
     regExp=new RegExp(String.fromCharCode(179), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#322;')
     //n
     regExp=new RegExp(String.fromCharCode(241), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#324;')
     //o
     regExp=new RegExp(String.fromCharCode(243), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#243;')
     //s
     regExp=new RegExp(String.fromCharCode(339), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#347;')
     //x
     regExp=new RegExp(String.fromCharCode(376), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#378;')
     //z
     regExp=new RegExp(String.fromCharCode(191), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#380;')

     //A
     regExp=new RegExp(String.fromCharCode(165), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#260;')
     //C
     regExp=new RegExp(String.fromCharCode(198), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#262;')
     //E
     regExp=new RegExp(String.fromCharCode(202), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#280;')
     //L
     regExp=new RegExp(String.fromCharCode(163), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#321;')
     //N
     regExp=new RegExp(String.fromCharCode(209), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#323;')
     //O
     regExp=new RegExp(String.fromCharCode(211), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#211;')
     //S
     regExp=new RegExp(String.fromCharCode(338), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#346;')
     //Z
     regExp=new RegExp(String.fromCharCode(175), "g")
     document.body.innerHTML=document.body.innerHTML.replace(regExp, '&#379;')
   }
}