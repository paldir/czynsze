//////////////////////////////////////////////////////////////////////
///
/// <summary>
/// </summary>
///
///
/// <remarks>
/// </remarks>
///
///
/// <copyright>
/// Your-Company. All Rights Reserved.
/// </copyright>
///
//////////////////////////////////////////////////////////////////////
CLASS HTMLWriter
   EXPORTED:
      CLASS METHOD table
      CLASS METHOD a
      CLASS METHOD h1
      CLASS METHOD inputText, inputRadio, inputSubmit, inputHidden, inputButton
      CLASS METHOD textarea
      CLASS METHOD selectHTML
      CLASS METHOD _a, _c, _e, _l, _n, _o, _s, _x, _z, ReplaceBushes
   //HIDDEN:
      //CLASS METHOD RemoveBlankChars
ENDCLASS

CLASS METHOD HTMLWriter: table(headers, editUrl, deleteUrl)
   result:="<table border='1'>"
   result+="<tr>"

   FOR i:=1 to FCount()
      result+="<th>"
      result+=headers[i]
      result+="</th>"
   NEXT

   FOR i:=1 to LastRec()
      result+="<tr>"

      FOR j:=1 to FCount()
         result+="<td>"+Var2Char(FieldGet(j))+"</td>"
      NEXT

      result+="<td>"+::a(editUrl+Var2Char(FieldGet(1)), "Edytuj")+"</td>"
      result+="<td>"+::a(deleteUrl+Var2Char(FieldGet(1)), "Usu"+::_n())+"</td>"

      result+="</tr>"
      DbSkip()
   NEXT

   result+="</table>"
RETURN result

CLASS METHOD HTMLWriter: a(href, text)
RETURN "<a href='"+href+"'>"+text+"</a>"

CLASS METHOD HTMLWriter: h1(text)
RETURN "<h1>"+text+"</h1>"

CLASS METHOD HTMLWriter: inputText(name, label, maxlength, value, disabled, onkeypress)
   result:=""

   IF value==NIL
      value:=""
   ENDIF

   IF disabled==NIL
      disabled:=""
   ENDIF

   IF onkeypress==NIL
      onkeypress:=""
   ENDIF

   value:=RTrim(value)

   IF label!=NIL
      result+="<label for='"+name+"'>"+label+"</label><br />"
   ENDIF

   result+="<input type='text' name='"+name+"' size='"+maxlength+"' maxlength='"+maxlength+"' value='"+value+"' "+disabled+" onkeypress='"+onkeypress+"' />"
RETURN result

CLASS METHOD HTMLWriter: inputRadio(name, label, ids, values, labels, checked, disabled)
   IF checked==NIL
      checked:="-1"
   ENDIF

   result:="<label for='"+name+"'>"+label+"</label><br />"

   FOR i:=1 to Len(ids)
      result+="<input type='radio' "+disabled+" name='"+name+"' id='"+ids[i]+"' value='"+values[i]+"'"

      IF values[i]==checked
         result+="checked='checked'"
      ENDIF

      result+=" />"
      result+="<label for='"+ids[i]+"'>"+labels[i]+"</label><br />"
   NEXT
RETURN result

CLASS METHOD HTMLWriter: inputSubmit(name, value)
RETURN "<input type='submit' name='"+name+"' value='"+value+"' />"

CLASS METHOD HTMLWriter: inputHidden(name, value)
RETURN "<input type='hidden' name='"+name+"' value='"+value+"' />"

CLASS METHOD HTMLWriter: inputButton(onclick, value)
RETURN "<input type='button' onclick='"+onclick+"' value='"+value+"' />"

CLASS METHOD HTMLWriter: textarea(name, label, rows, maxlength, text, disabled)
   IF text==NIL
      text:=""
   ENDIF

   text:=RTrim(text)
   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<textarea name='"+name+"' cols='"+Var2Char(Val(maxlength)/Val(rows))+"' rows='"+rows+"' maxlength='"+maxlength+"' "+disabled+">"+text+"</textarea>"
RETURN result

CLASS METHOD HTMLWriter: selectHTML(dbHelper, name, label, selected, disabled, columns, table, orderBy)
   dbHelper: SQLSelect(columns, table, , orderBy)

   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<select name='"+name+"' "+disabled+">"

   FOR i:=1 to LastRec()
      result+="<option value='"+Var2Char(FieldGet(1))+"'"

      IF Var2Char(FieldGet(1))==selected
         result+=" selected "
      ENDIF

      result+=">"

      FOR j:=2 to Len(columns)
         result+=RTrim(Var2Char(FieldGet(j)))+", "
      NEXT

      result:=SubStr(result, 1, Len(result)-2)
      result+="</option>"

      DbSkip()
   NEXT

   result+="</select>"
RETURN result

CLASS METHOD HTMLWriter: _a()
RETURN "&#261;"

CLASS METHOD HTMLWriter: _c()
RETURN "&#263;"

CLASS METHOD HTMLWriter: _e()
RETURN "&#281;"

CLASS METHOD HTMLWriter: _l()
RETURN "&#322;"

CLASS METHOD HTMLWriter: _n()
RETURN "&#324;"

CLASS METHOD HTMLWriter: _o()
RETURN "&#243;"

CLASS METHOD HTMLWriter: _s()
RETURN "&#347;"

CLASS METHOD HTMLWriter: _x()
RETURN "&#378;"

CLASS METHOD HTMLWriter: _z()
RETURN "&#380;"

/*CLASS METHOD HTMLWriter: RemoveBlankChars(chars)
   i:=Len(chars)

   IF i>0
      DO WHILE chars[i]==" " .AND. i!=1
         i--
      ENDDO

      chars:=SubStr(chars, 1, i)
   ENDIF
RETURN chars*/

CLASS METHOD HTMLWriter: ReplaceBushes(chars)
   _bushes:={Chr(185), Chr(230), Chr(234), Chr(179), Chr(241), Chr(243), Chr(339), Chr(376), Chr(191)}
   bushes:={Chr(165), Chr(202), Chr(198), Chr(163), Chr(209), Chr(211), Chr(338), Chr(175)}

   /*chars:=StrTran(chars, '&#261;', Chr(261)) //a
   chars:=StrTran(chars, '&#263;', Chr(263)) //c
   chars:=StrTran(chars, '&#281;', Chr(281)) //e
   chars:=StrTran(chars, '&#322;', Chr(322)) //l
   chars:=StrTran(chars, '&#324;', Chr(324)) //n
   chars:=StrTran(chars, '&#243;', Chr(243)) //o
   chars:=StrTran(chars, '&#347;', Chr(347)) //s
   chars:=StrTran(chars, '&#378;', Chr(378)) //x
   chars:=StrTran(chars, '&#380;', Chr(380)) //z*/

   /*chars:=StrTran(chars, '&#262;') //A
   chars:=StrTran(chars, '&#321;') //L
   chars:=StrTran(chars, '&#323;') //N
   chars:=StrTran(chars, '&#211;') //O
   chars:=StrTran(chars, '&#346;') //S
   chars:=StrTran(chars, '&#379;') //Z */
   chars:=StrTran(chars, Chr(243), 'o') //o
   chars:=StrTran(chars, Chr(211), 'O') //O
RETURN chars