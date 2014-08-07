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

CLASS METHOD Validation: Building(dbHelper, validate_kod_1, kod_1, il_miesz, udzial_w_k)
   result:=""

   IF validate_kod_1
    dbHelper: SQLSelect({"kod_1"}, "budynki", "kod_1="+kod_1)

    IF LastRec()>0
          result+="Kod budynku jest ju"+HTMLWriter(): _z()+" u"+HTMLWriter(): _z()+"ywany! <br />"
    ENDIF

    IF Len(kod_1)==0
          result+="Nale"+HTMLWriter(): _z()+"y poda"+HTMLWriter(): _c()+" kod budynku! <br />"
    ENDIF

    FOR i:=1 to Len(kod_1)
          IF !IsDigit(kod_1[i])
             result+="Kod budynku musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+"! <br />"
             exit
          ENDIF
    NEXT
   ENDIF

   FOR i:=1 to Len(il_miesz)
      IF !IsDigit(il_miesz[i])
         result+="Ilo"+HTMLWriter(): _s()+HTMLWriter(): _c()+" lokali musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+"! <br />"

         exit
      ENDIF
   NEXT

   IF Len(il_miesz)==0
      il_miesz:="0"
   ENDIF

   dots:=0
   FOR i:=1 to Len(udzial_w_k)
      IF udzial_w_k[i]=="."
         dots++
      ENDIF

      /*IF (!IsDigit(udzial_w_k[i]) .AND. udzial_w_k[i]!=".")
         result+="Udzia"+HTMLWriter(): _l()+" w kosztach musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+" z dwoma miejscami dziesi"+HTMLWriter(): _e()+"tnymi! <br />"

         exit
      ENDIF*/
   NEXT

   IF dots>1 .OR. Val(udzial_w_k)>999
      result+="Udzia"+HTMLWriter(): _l()+" w kosztach musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+" z dwoma miejscami dziesi"+HTMLWriter(): _e()+"tnymi! <br />"
   ENDIF

   IF Len(udzial_w_k)==0
      udzial_w_k:="0"
   ENDIF

RETURN result