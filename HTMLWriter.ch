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
      CLASS METHOD h2
      CLASS METHOD inputText, inputRadio, inputSubmit, inputHidden, inputButton, inputFile, inputPassword
      CLASS METHOD textarea
      CLASS METHOD selectHTML
      CLASS METHOD buttonSubmit
      CLASS METHOD _a, _c, _e, _l, _n, _o, _s, _x, _z, ReplacePolishSymbols
   HIDDEN:
      CLASS METHOD RepairPolishSymbols
ENDCLASS

CLASS METHOD HTMLWriter: table(headers, columns, page, sortOrder, pk)
   result:="<table border='1'>"
   result+="<tr class='headingRow'>"

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
      result+="<tr class='row' id='"+Var2Char(FieldGet(1))+"_row'>"

      result+="<td><input class='rowRadio' type='radio' name='"+pk+"' id='"+Var2Char(FieldGet(1))+"' value='"+Var2Char(FieldGet(1))+"' /><label class='rowLabel' for='"+Var2Char(FieldGet(1))+"'>"+Var2Char(FieldGet(2))+"</label></td>"

      FOR j:=3 to FCount()
         result+="<td><label class='rowLabel' for='"+Var2Char(FieldGet(1))+"'>"+::RepairPolishSymbols(Var2Char(FieldGet(j)))+"</label></td>"
      NEXT

      /*IF editUrl!=NIL
         result+="<td>"+::a(editUrl+Var2Char(FieldGet(1)), "Edytuj")+"</td>"
      ENDIF

      IF deleteUrl!=NIL
         result+="<td>"+::a(deleteUrl+Var2Char(FieldGet(1)), "Usu"+::_n())+"</td>"
      ENDIF

      IF browseUrl!=NIL
         result+="<td>"+::a(browseUrl+Var2Char(FieldGet(1)), "Przegl"+::_a()+"daj")+"</td>"
      ENDIF

      IF extraUrls!=NIL
       FOR j:=1 to Len(extraUrls)
          result+="<td>"+::a(extraUrls[j]+Var2Char(FieldGet(1)), extraUrlsTexts[j])+"</td>"
       NEXT
      ENDIF*/

      result+="</tr>"

      DbSkip()
   NEXT

   result+="</table>"
RETURN result

CLASS METHOD HTMLWriter: a(href, text, className)
   aResult:="<a href='"+href+"'"

   IF className!=NIL
      aResult+=" class='"+className+"'"
   ENDIF

   aResult+=">"+text+"</a>"
RETURN aResult

CLASS METHOD HTMLWriter: h2(text)
RETURN "<h2>"+text+"</h2>"

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

   result+="<input type='text' name='"+name+"' size='"+maxlength+"' maxlength='"+maxlength+"' value='"+::RepairPolishSymbols(value)+"' "+disabled+" onkeypress='"+onkeypress+"' />"
RETURN result

CLASS METHOD HTMLWriter: inputRadio(name, label, ids, values, labels, checked, disabled)
   IF checked==NIL
      checked:="-1"
   ENDIF

   IF label!=NIL
      result:="<label for='"+name+"'>"+label+"</label><br />"
   ENDIF

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

CLASS METHOD HTMLWriter: inputPassword(name)
RETURN "<input type='password' name='"+name+"' />"

CLASS METHOD HTMLWriter: textarea(name, label, rows, maxlength, text, disabled)
   result:=""

   IF text==NIL
      text:=""
   ENDIF

   text:=RTrim(text)

   IF label!=NIL
      result+="<label for='"+name+"'>"+label+"</label><br />"
   ENDIF

   result+="<textarea name='"+name+"' cols='"+Var2Char(Val(maxlength)/Val(rows))+"' rows='"+rows+"' maxlength='"+maxlength+"' "+disabled+">"+::RepairPolishSymbols(text)+"</textarea>"
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
   result+="<option value='-1' selected hidden></option>"

   FOR i:=1 to LastRec()
      result+="<option value='"+Var2Char(FieldGet(1))+"'"

      IF Var2Char(FieldGet(1))==selected
         result+=" selected "
      ENDIF

      result+=">"

      FOR j:=2 to Len(columns)
         result+=RTrim(::RepairPolishSymbols(Var2Char(FieldGet(j))))+", "
      NEXT

      result:=SubStr(result, 1, Len(result)-2)
      result+="</option>"

      DbSkip()
   NEXT

   result+="</select>"
RETURN result

CLASS METHOD HTMLWriter: buttonSubmit(name, value, text)
RETURN "<button type='submit' name='"+name+"' value='"+value+"'>"+text+"</button>"

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

CLASS METHOD HTMLWriter: ReplacePolishSymbols(chars)
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
   chars:=StrTran(chars, Chr(1), '&#261;') //a
   chars:=StrTran(chars, Chr(2), '&#263;') //c
   chars:=StrTran(chars, Chr(3), '&#281;') //e
   chars:=StrTran(chars, Chr(4), '&#322;') //l
   chars:=StrTran(chars, Chr(5), '&#324;') //n
   chars:=StrTran(chars, Chr(6), '&#243;') //o
   chars:=StrTran(chars, Chr(7), '&#347;') //s
   chars:=StrTran(chars, Chr(8), '&#378;') //x
   chars:=StrTran(chars, Chr(9), '&#380;') //z

   chars:=StrTran(chars, Chr(10), '&#260;') //A
   chars:=StrTran(chars, Chr(11), '&#262;') //C
   chars:=StrTran(chars, Chr(12), '&#280;') //E
   chars:=StrTran(chars, Chr(13), '&#321;') //L
   chars:=StrTran(chars, Chr(14), '&#323;') //N
   chars:=StrTran(chars, Chr(15), '&#211;') //O WTF
   chars:=StrTran(chars, Chr(16), '&#346;') //S
   chars:=StrTran(chars, Chr(17), '&#377;') //X WTF
   chars:=StrTran(chars, Chr(18), '&#379;') //Z
RETURN chars