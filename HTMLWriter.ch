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
      CLASS METHOD _a, _c, _e, _l, _n, _o, _s, _x, _z
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
   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<input type='text' name='"+name+"' size='"+maxlength+"' maxlength='"+maxlength+"' value='"+value+"' "+disabled+" onkeypress='"+onkeypress+"' />"
RETURN result

CLASS METHOD HTMLWriter: inputRadio(name, label, ids, values, labels, checked)
   IF checked==NIL
      checked:="-1"
   ENDIF

   result:="<label for='"+name+"'>"+label+"</label><br />"

   FOR i:=1 to Len(ids)
      result+="<input type='radio' name='"+name+"' id='"+ids[i]+"' value='"+values[i]+"'"

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

CLASS METHOD HTMLWriter: textarea(name, label, rows, maxlength, text)
   IF text==NIL
      text:=""
   ENDIF

   text:=RTrim(text)
   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<textarea name='"+name+"' cols='"+Var2Char(Val(maxlength)/Val(rows))+"' rows='"+rows+"' maxlength='"+maxlength+"'>"+text+"</textarea>"
RETURN result

CLASS METHOD HTMLWriter: selectHTML(dbHelper, name, label, selected, columns, table, orderBy)
   dbHelper: SQLSelect(columns, table, , orderBy)

   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<select name='"+name+"'>"

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