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

CLASS Validation
   EXPORTED:
      CLASS METHOD Building
ENDCLASS

CLASS METHOD Validation: Building(dbHelper, kod_1, il_miesz, udzial_w_k)
   result:=""

   dbHelper: SQLSelect({"kod_1"}, "budynki", "kod_1="+kod_1)

   IF LastRec()>0
      result+="Kod budynku jest ju"+HTMLWriter(): _z()+" u"+HTMLWriter(): _z()+"ywany! <br />"
   ENDIF

   FOR i:=1 to Len(kod_1)
      IF !IsDigit(kod_1[i])
         result+="Kod budynku musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+"! <br />"
         exit
      ENDIF
   NEXT

   FOR i:=1 to Len(il_miesz)
      IF !IsDigit(il_miesz[i])
         result+="Ilo"+HTMLWriter(): _s()+HTMLWriter(): _c()+" lokali musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+"! <br />"

         exit
      ENDIF
   NEXT

   FOR i:=1 to Len(udzial_w_k)
      IF !IsDigit(udzial_w_k[i]) .AND. udzial_w_k[i]!="."
         result+="Udzia"+HTMLWriter(): _l()+" w kosztach musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+"! <br />"

         exit
      ENDIF
   NEXT
RETURN result