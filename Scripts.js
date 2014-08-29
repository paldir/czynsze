function isInteger(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function isFloat(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode != 46 &&(charCode < 48 || charCode > 57)))
        return false;
    return true;
}

function isDate(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode != 45 &&(charCode < 48 || charCode > 57)))
        return false;
    return true;
}

function ClearSelectionOfRow() {
   var radios=document.getElementsByTagName('input');

   for(var i=0; i<radios.length; i++)
      if (radios[i].type=='radio' && radios[i].className=='rowRadio')
         radios[i].checked=false;
}

function ChangeRow(rowId) {
   var buttons=Array(3)
   buttons[1]=document.getElementById("editingButton");
   buttons[2]=document.getElementById("deletingButton");
   buttons[3]=document.getElementById("browsingButton");

   for(var i=0; i<buttons.length; i++)
      if (buttons[i]!=null)
         buttons[i].disabled=false;

   var selectedRow=document.getElementsByClassName("selectedRow")[0]

   if (selectedRow!=null)
      selectedRow.className="row";

   var row=document.getElementById(rowId+"_row");

   if (row!=null)
      row.className="selectedRow";
}