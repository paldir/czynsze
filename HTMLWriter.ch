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
      CLASS METHOD inputText, inputRadio, inputSubmit, inputHidden
      CLASS METHOD textarea
      CLASS METHOD _a, _c, _e, _l, _n, _o, _s, _x, _z
ENDCLASS

CLASS METHOD HTMLWriter: table(headers)
   result:="<table border='1'>"
   result+="<tr>"

   FOR i:=1 to FCount()
      result+="<td><b>"
      result+=headers[i]
      result+="</b></td>"
   NEXT

   FOR i:=1 to LastRec()
      result+="<tr>"

      FOR j:=1 to FCount()
         result+="<td>"+Var2Char(FieldGet(j))+"</td>"
      NEXT

      result+="<td>"+::a("EdytujBudynek.cxp?kod_1="+Var2Char(FieldGet(1)), "Edytuj")+"</td>"
      result+="<td>"+::a("UsunBudynek.cxp?kod_1="+Var2Char(FieldGet(1)), "Usu"+::_n())+"</td>"

      result+="</tr>"
      DbSkip()
   NEXT

   result+="</table>"
RETURN result

CLASS METHOD HTMLWriter: a(href, text)
RETURN "<a href='"+href+"'>"+text+"</a>"

CLASS METHOD HTMLWriter: h1(text)
RETURN "<h1>"+text+"</h1>"

CLASS METHOD HTMLWriter: inputText(name, label, maxlength, value, disabled)
   IF value==NIL
      value=""
   ENDIF

   IF disabled==NIL
      disabled=""
   ENDIF

   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<input type='text' name='"+name+"' maxlength='"+maxlength+"' value='"+value+"' "+disabled+" />"
RETURN result

CLASS METHOD HTMLWriter: inputRadio(name, label, ids, values, labels, checked)
   IF checked==NIL
      checked:="-1"
   ENDIF

   result:="<label for='"+name+"'>"+label+"</label><br />"

   FOR i:=1 to Len(ids)
      result+="<input type='radio' name='"+name+"' id='"+ids[i]+"' value='"+values[i]+"'"

      IF Var2Char(i-1)==checked
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

CLASS METHOD HTMLWriter: textarea(name, label, rows, maxlength, text)
   IF text==NIL
      text:=""
   ENDIF

   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<textarea name='"+name+"' rows='"+rows+"' maxlength='"+maxlength+"'>"+text+"</textarea>"
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