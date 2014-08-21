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
      CLASS METHOD inputText, inputRadio, inputSubmit, inputHidden, inputButton, inputFile
      CLASS METHOD textarea
      CLASS METHOD selectHTML
      CLASS METHOD _a, _c, _e, _l, _n, _o, _s, _x, _z, ReplaceBushes
   HIDDEN:
      CLASS METHOD RepairPolishSymbols
ENDCLASS

CLASS METHOD HTMLWriter: table(headers, columns, page, sortOrder, editUrl, deleteUrl, extraUrls, extraUrlsTexts)
   result:="<table border='1'>"
   result+="<tr>"

   FOR i:=2 to FCount()
      result+="<th>"

      IF columns==NIL
         result+=headers[i]
      ELSE
         result+="<a href="+page+".cxp?orderBy="+columns[i]+Chr(38)+"sortOrder="+sortOrder+">"+headers[i]+"</a>"
      ENDIF

      result+="</th>"
   NEXT

   FOR i:=1 to LastRec()
      result+="<tr>"

      FOR j:=2 to FCount()
         result+="<td>"+Var2Char(FieldGet(j))+"</td>"
      NEXT

      IF editUrl!=NIL
         result+="<td>"+::a(editUrl+Var2Char(FieldGet(1)), "Edytuj")+"</td>"
      ENDIF

      result+="<td>"+::a(deleteUrl+Var2Char(FieldGet(1)), "Usu"+::_n())+"</td>"

      IF extraUrls!=NIL
       FOR j:=1 to Len(extraUrls)
          result+="<td>"+::a(extraUrls[j]+Var2Char(FieldGet(1)), extraUrlsTexts[j])+"</td>"
       NEXT
      ENDIF

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
   ELSEIF onkeypress=="return isFloat(event)"
      value:=Var2Char(Round(Val(value), 2))
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

CLASS METHOD HTMLWriter: inputFile(name, label, value, disabled)
   result:=""

   IF label!=NIL
      result+="<label for='"+name+"'>"+label+"</label><br />"
   ENDIF

   result+="<input type='file' name='"+name+"' value='"+value+"' "+disabled+"' />"
RETURN result

CLASS METHOD HTMLWriter: textarea(name, label, rows, maxlength, text, disabled)
   IF text==NIL
      text:=""
   ENDIF

   text:=RTrim(text)
   result:="<label for='"+name+"'>"+label+"</label><br />"
   result+="<textarea name='"+name+"' cols='"+Var2Char(Val(maxlength)/Val(rows))+"' rows='"+rows+"' maxlength='"+maxlength+"' "+disabled+">"+text+"</textarea>"
RETURN result

CLASS METHOD HTMLWriter: selectHTML(dbHelper, name, label, selected, disabled, columns, table, orderBy, onchange)
   result:=""

   IF Len(table)>0
      dbHelper: SQLSelect(columns, table, , orderBy)
   ENDIF

   IF label!=NIL
      result+="<label for='"+name+"'>"+label+"</label><br />"
   ENDIF

   result+="<select name='"+name+"' "+disabled

   IF onchange!=NIL
      result+=" onchange='"+onchange+"' "
   ENDIF

   result+=">"

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

CLASS METHOD HTMLWriter: ReplaceBushes(chars)
   _bushes:={Chr(185)/*a*/, Chr(230)/*c*/, Chr(234)/*e*/, Chr(179)/*l*/, Chr(241)/*n*/, Chr(243)/*o*/, Chr(339)/*s*/, Chr(376)/*x*/, Chr(191)/*z*/}
   bushes:={Chr(165)/*A*/, Chr(202)/*C*/, Chr(198)/*E*/, Chr(163)/*L*/, Chr(209)/*N*/, Chr(211)/*O*/, Chr(338)/*S*/, Chr(175)/*Z*/}

   /*chars:=StrTran(chars, '&#261;', 'a') //a
   chars:=StrTran(chars, '&#263;', 'c') //c
   chars:=StrTran(chars, '&#281;', 'e') //e
   chars:=StrTran(chars, '&#322;', 'l') //l
   chars:=StrTran(chars, '&#324;', 'n') //n
   chars:=StrTran(chars, '&#243;', 'o') //o
   chars:=StrTran(chars, '&#347;', 's') //s
   chars:=StrTran(chars, '&#378;', 'z') //x
   chars:=StrTran(chars, '&#380;', 'z') //z

   chars:=StrTran(chars, '&#260;', 'A') //A
   chars:=StrTran(chars, '&#262;', 'C') //C
   chars:=StrTran(chars, '&#280;', 'E') //E
   chars:=StrTran(chars, '&#321;', 'L') //L
   chars:=StrTran(chars, '&#323;', 'N') //N
   chars:=StrTran(chars, '&#211;', 'O') //O
   chars:=StrTran(chars, '&#346;', 'S') //S
   chars:=StrTran(chars, '&#379;', 'Z') //Z*/

   chars:=StrTran(chars, '&#261;', Chr(1)) //a
   chars:=StrTran(chars, '&#263;', Chr(2)) //c
   chars:=StrTran(chars, '&#281;', Chr(3)) //e
   chars:=StrTran(chars, '&#322;', Chr(4)) //l
   chars:=StrTran(chars, '&#324;', Chr(5)) //n
   chars:=StrTran(chars, '&#243;', 'o') //o WTF
   chars:=StrTran(chars, '&#347;', Chr(7)) //s
   chars:=StrTran(chars, '&#378;', Chr(8)) //x
   chars:=StrTran(chars, '&#380;', Chr(9)) //z

   chars:=StrTran(chars, '&#260;', Chr(10)) //A
   chars:=StrTran(chars, '&#262;', Chr(11)) //C
   chars:=StrTran(chars, '&#280;', Chr(12)) //E
   chars:=StrTran(chars, '&#321;', Chr(13)) //L
   chars:=StrTran(chars, '&#323;', Chr(14)) //N
   chars:=StrTran(chars, '&#211;', 'O') //O WTF
   chars:=StrTran(chars, '&#346;', Chr(16)) //S
   chars:=StrTran(chars, '&#377;', 'Z') //X WTF
   chars:=StrTran(chars, '&#379;', Chr(18)) //Z
RETURN chars

CLASS METHOD HTMLWriter: RepairPolishSymbols(chars)
   chars:=StrTran(chars, Chr(185), '&#261;') //a
   chars:=StrTran(chars, Chr(230), '&#263;') //c
   chars:=StrTran(chars, Chr(234), '&#281;') //e
   chars:=StrTran(chars, Chr(179), '&#322;') //l
   chars:=StrTran(chars, Chr(241), '&#324;') //n
   chars:=StrTran(chars, Chr(243), '&#243;') //o
   chars:=StrTran(chars, 'o', '&#347;') //s
   chars:=StrTran(chars, 'Y', '&#378;') //x
   chars:=StrTran(chars, Chr(191), '&#380;') //z

   chars:=StrTran(chars, Chr(165), '&#260;') //A
   chars:=StrTran(chars, Chr(198), '&#262;') //C
   chars:=StrTran(chars, Chr(202), '&#280;') //E
   chars:=StrTran(chars, Chr(163), '&#321;') //L
   chars:=StrTran(chars, Chr(209), '&#323;') //N
   chars:=StrTran(chars, Chr(211), '&#211;') //O WTF
   chars:=StrTran(chars, Chr(338), '&#346;') //S
   //chars:=StrTran(chars, Chr(), '&#377;') //X WTF
   chars:=StrTran(chars, Chr(175), '&#379;') //Z
RETURN chars
