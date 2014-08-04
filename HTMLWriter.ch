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
      CLASS METHOD inputText, inputRadio, inputSubmit
      CLASS METHOD textarea
ENDCLASS

CLASS METHOD HTMLWriter: table(headers)
   result:="<table>"
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

      result+="</tr>"
      DbSkip()
   NEXT

   result+="</table>"
RETURN result

CLASS METHOD HTMLWriter: a(href, text)
RETURN "<a href='"+href+"'>"+text+"</a>"

CLASS METHOD HTMLWriter: h1(text)
RETURN "<h1>"+text+"</h1>"

CLASS METHOD HTMLWriter: inputText(name, label, maxlength)
   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<input type='text' name='"+name+"' maxlength='"+maxlength+"' />"
RETURN result

CLASS METHOD HTMLWriter: inputRadio(name, label, ids, values, labels)
   result:="<label for='"+name+"'>"+label+"</label><br />"

   FOR i:=1 to Len(ids)
      result+="<input type='radio' name='"+name+"' id='"+ids[i]+"' value='"+values[i]+"'>"
      result+="<label for='"+ids[i]+"'>"+labels[i]+"</label><br />"
   NEXT
RETURN result

CLASS METHOD HTMLWriter: inputSubmit(name, value)
RETURN "<input type='submit' name='"+name+"' value='"+value+"' />"

CLASS METHOD HTMLWriter: textarea(name, label, rows, maxlength)
   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<textarea name='"+name+"' rows='"+rows+"' maxlength='"+maxlength+"'></textarea>"
RETURN result