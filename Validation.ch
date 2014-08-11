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
      CLASS METHOD Building, LocalTable
   HIDDEN:
      CLASS METHOD ReplaceNull
      CLASS METHOD IntegerWithoutChars
      CLASS METHOD IsFloatValid
      CLASS METHOD IsDateValid
      CLASS METHOD WarningAboutFloats, WarningAboutDates
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

   IF !::IntegerWithoutChars(il_miesz)
      result+="Ilo"+HTMLWriter(): _s()+HTMLWriter(): _c()+" lokali musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+"! <br />"
   ENDIF

   il_miesz:=::ReplaceNull(il_miesz, "0")

   IF !::IsFloatValid(udzial_w_k, 999.99)
      result+=::WarningAboutFloats("Udzia"+HTMLWriter(): _l()+" w kosztach")
   ENDIF

   udzial_w_k:=::ReplaceNull(udzial_w_k, "0")

RETURN result

CLASS METHOD Validation: LocalTable(nr_lok, pow_uzyt, pow_miesz, udzial, dat_od, dat_do, p_1, p_2, p_3, p_4, p_5, p_6, il_osob)
   result:=""

   nr_lok:=::ReplaceNull(nr_lok, "0")

   IF !::IsFloatValid(pow_uzyt, 999999.99)
      result+=::WarningAboutFloats("Powierzchnia u"+HTMLWriter(): _z()+"ytkowa")
   ENDIF

   pow_uzyt:=::ReplaceNull(pow_uzyt, "0")

   IF !::IsFloatValid(pow_miesz, 999999.99)
      result+=::WarningAboutFloats("Powierzchnia mieszkalna")
   ENDIF

   pow_miesz:=::ReplaceNull(pow_miesz, "0")

   IF !::IsFloatValid(udzial, 999.99)
      result+=::WarningAboutFloats("Udzia"+HTMLWriter(): _l())
   ENDIF

   udzial:=::ReplaceNull(udzial, "0")

   SET DATE format TO "yyyy-mm-dd"

   dat_od:=::ReplaceNull(dat_od, Var2Char(DtoC(Date())))
   dat_do:=::ReplaceNull(dat_do, Var2Char(DtoC(Date())))

   IF !::isDateValid(dat_od)
      result+=::WarningAboutDates("Pocz"+HTMLWriter(): _a()+"tek zakresu dat")
      //result+="Od"+dat_od+"<br />"
   ENDIF

   IF !::isDateValid(dat_do)
      result+=::WarningAboutDates("Koniec zakresu dat")
      //result+="Do"+dat_do+"<br />"
   ENDIF

   IF !::IsFloatValid(p_1, 999.99)
      result+=::WarningAboutFloats("Powierzchnia pierwszego pokoju")
   ENDIF

   p_1:=::ReplaceNull(p_1, "0")

   IF !::IsFloatValid(p_2, 999.99)
      result+=::WarningAboutFloats("Powierzchnia drugiego pokoju")
   ENDIF

   p_2:=::ReplaceNull(p_2, "0")

   IF !::IsFloatValid(p_3, 999.99)
      result+=::WarningAboutFloats("Powierzchnia trzeciego pokoju")
   ENDIF

   p_3:=::ReplaceNull(p_3, "0")

   IF !::IsFloatValid(p_4, 999.99)
      result+=::WarningAboutFloats("Powierzchnia czwartego pokoju")
   ENDIF

   p_4:=::ReplaceNull(p_4, "0")

   IF !::IsFloatValid(p_5, 999.99)
      result+=::WarningAboutFloats("Powierzchnia pi"+HTMLWriter(): _a()+"tego pokoju")
   ENDIF

   p_5:=::ReplaceNull(p_5, "0")

   IF !::IsFloatValid(p_6, 999.99)
      result+=::WarningAboutFloats("Powierzchnia sz"+HTMLWriter(): _o()+"stego pokoju")
   ENDIF

   p_6:=::ReplaceNull(p_6, "0")

   il_osob:=::ReplaceNull(il_osob, "0")
RETURN result

CLASS METHOD ReplaceNull(chars, newChars)
   IF Len(chars)==0
      chars:=newChars
   ENDIF
RETURN chars

CLASS METHOD Validation: IntegerWithoutChars(number)
   FOR i:=1 to Len(number)
      IF !IsDigit(number[i])
         RETURN .F.

         exit
      ENDIF
   NEXT

RETURN .T.

CLASS METHOD Validation: IsFloatValid(number, max)
   dots:=0

   FOR i:=1 to Len(number)
      IF number[i]=="."
         dots++
      ENDIF

      IF (!IsDigit(number[i]) .AND. number[i]!=".")
         RETURN .F.
      ENDIF
   NEXT

   IF dots>1 .OR. Val(number)>max
      RETURN .F.
   ENDIF

RETURN .T.

CLASS METHOD Validation: WarningAboutFloats(nameOfFloat)
RETURN nameOfFloat+" musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+" z dwoma miejscami dziesi"+HTMLWriter(): _e()+"tnymi! <br />"

CLASS METHOD Validation: WarningAboutDates(nameOfDate)
RETURN nameOfDate+" musi mie"+HTMLWriter(): _c()+" format rrrr-mm-dd! <br />"

CLASS METHOD Validation: IsDateValid(date)
   IF Len(date)!=10
      RETURN .F.
   ENDIF

   IF !IsDigit(date[1]) .OR. !IsDigit(date[2]) .OR. !IsDigit(date[3]) .OR. !IsDigit(date[4]) .OR. date[5]!="-" .OR. !IsDigit(date[6]) .OR. !IsDigit(date[7]) .OR. date[8]!="-" .OR. !IsDigit(date[9]) .OR. !IsDigit(date[10])
      RETURN .F.
   ENDIF

   IF Val(SubStr(date, 6, 2))>12 .OR. Val(SubStr(date, 9, 2))>31
      RETURN .F.
   ENDIF
RETURN .T.