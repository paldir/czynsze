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
      CLASS METHOD Building, LocalTable, RentComponent, TenantFiles
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

CLASS METHOD Validation: LocalTable(dbHelper, validate_nr_lok, kod_lok, nr_lok, pow_uzyt, pow_miesz, udzial, dat_od, dat_do, p_1, p_2, p_3, p_4, p_5, p_6, il_osob)
   result:=""

   IF validate_nr_lok
      nr_lok:=::ReplaceNull(nr_lok, "0")

      IF !::IsFloatValid(pow_uzyt, 999999.99)
         result+=::WarningAboutFloats("Powierzchnia u"+HTMLWriter(): _z()+"ytkowa")
      ENDIF

      dbHelper: SQLSelect({"kod_lok"}, "lokale", "kod_lok="+kod_lok+" AND nr_lok="+nr_lok)

      IF LastRec()>0
         result+="W wybranym budynku istnieje ju"+HTMLWriter(): _z()+" lokal o podanym numerze! <br />"
      ENDIF
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

CLASS METHOD Validation: RentComponent(dbHelper, validate_nr_skl, nr_skl, stawka, stawka_inf, data_1, data_2, stawka_00, stawka_01, stawka_02, stawka_03, stawka_04, stawka_05, stawka_06, stawka_07, stawka_08, stawka_09)
   result:=""

   IF validate_nr_skl
      dbHelper: SQLSelect({"nr_skl"}, "czynsz", "nr_skl="+nr_skl)

      IF LastRec()>0
         result+="Numer sk"+HTMLWriter(): _l()+"adnika jest ju"+HTMLWriter(): _z()+" u"+HTMLWriter(): _z()+"ywany! <br />"
      ENDIF

      IF Len(nr_skl)==0
            result+="Nale"+HTMLWriter(): _z()+"y poda"+HTMLWriter(): _c()+" numer sk"+HTMLWriter(): _l()+"adnika! <br />"
      ENDIF

      FOR i:=1 to Len(nr_skl)
            IF !IsDigit(nr_skl[i])
               result+="Numer sk"+HTMLWriter(): _l()+"adnika musi by"+HTMLWriter(): _c()+" liczb"+HTMLWriter(): _a()+"! <br />"
               exit
            ENDIF
      NEXT
   ENDIF

   IF !::IsFloatValid(stawka, 9999999.99)
      result+=::WarningAboutFloats("Stawka")
   ENDIF

   stawka:=::ReplaceNull(stawka, "0")
   stawka:=Var2Char(Round(Val(stawka), 2))

   IF !::IsFloatValid(stawka_inf, 9999999.99)
      result+=::WarningAboutFloats("Stawka do korespondencji")
   ENDIF

   stawka_inf:=::ReplaceNull(stawka_inf, "0")
   stawka_inf:=Var2Char(Round(Val(stawka_inf), 2))

   SET DATE format TO "yyyy-mm-dd"

   data_1:=::ReplaceNull(data_1, Var2Char(DtoC(Date())))
   data_2:=::ReplaceNull(data_2, Var2Char(DtoC(Date())))

   IF !::isDateValid(data_1)
      result+=::WarningAboutDates("Pocz"+HTMLWriter(): _a()+"tek zakresu dat")
   ENDIF

   IF !::isDateValid(data_2)
      result+=::WarningAboutDates("Koniec zakresu dat")
   ENDIF

   IF !::IsFloatValid(stawka_00, 9999999.99)
      result+=::WarningAboutFloats("Stawka za zero os"+HTMLWriter(): _o()+"b")
   ENDIF

   stawka_00:=::ReplaceNull(stawka_00, "0")
   stawka_00:=Var2Char(Round(Val(stawka_00), 2))

   IF !::IsFloatValid(stawka_01, 9999999.99)
      result+=::WarningAboutFloats("Stawka za jedn"+HTMLWriter(): _a()+" osob"+HTMLWriter(): _e())
   ENDIF

   stawka_01:=::ReplaceNull(stawka_01, "0")
   stawka_01:=Var2Char(Round(Val(stawka_01), 2))

   IF !::IsFloatValid(stawka_02, 9999999.99)
      result+=::WarningAboutFloats("Stawka za dwie osoby")
   ENDIF

   stawka_02:=::ReplaceNull(stawka_02, "0")
   stawka_02:=Var2Char(Round(Val(stawka_02), 2))

   IF !::IsFloatValid(stawka_03, 9999999.99)
      result+=::WarningAboutFloats("Stawka za trzy osoby")
   ENDIF

   stawka_03:=::ReplaceNull(stawka_03, "0")
   stawka_03:=Var2Char(Round(Val(stawka_03), 2))

   IF !::IsFloatValid(stawka_04, 9999999.99)
      result+=::WarningAboutFloats("Stawka za cztery osoby")
   ENDIF

   stawka_04:=::ReplaceNull(stawka_04, "0")
   stawka_04:=Var2Char(Round(Val(stawka_04), 2))

   IF !::IsFloatValid(stawka_05, 9999999.99)
      result+=::WarningAboutFloats("Stawka za pi"+HTMLWriter(): _e()+"c os"+HTMLWriter(): _o()+"b")
   ENDIF

   stawka_05:=::ReplaceNull(stawka_05, "0")
   stawka_05:=Var2Char(Round(Val(stawka_05), 2))

   IF !::IsFloatValid(stawka_06, 9999999.99)
      result+=::WarningAboutFloats("Stawka za sze"+HTMLWriter(): _s()+HTMLWriter(): _c()+" os"+HTMLWriter(): _o()+"b")
   ENDIF

   stawka_06:=::ReplaceNull(stawka_06, "0")
   stawka_06:=Var2Char(Round(Val(stawka_06), 2))

   IF !::IsFloatValid(stawka_07, 9999999.99)
      result+=::WarningAboutFloats("Stawka za siedem os"+HTMLWriter(): _o()+"b")
   ENDIF

   stawka_07:=::ReplaceNull(stawka_07, "0")
   stawka_07:=Var2Char(Round(Val(stawka_07), 2))

   IF !::IsFloatValid(stawka_08, 9999999.99)
      result+=::WarningAboutFloats("Stawka za osiem os"+HTMLWriter(): _o()+"b")
   ENDIF

   stawka_08:=::ReplaceNull(stawka_08, "0")
   stawka_08:=Var2Char(Round(Val(stawka_08), 2))

   IF !::IsFloatValid(stawka_09, 9999999.99)
      result+=::WarningAboutFloats("Stawka za dziewi"+HTMLWriter(): _e()+HTMLWriter(): _c()+" i wi"+HTMLWriter(): _e()+"cej os"+HTMLWriter(): _o()+"b")
   ENDIF

   stawka_09:=::ReplaceNull(stawka_09, "0")
   stawka_09:=Var2Char(Round(Val(stawka_09), 2))
RETURN result

CLASS METHOD Validation: TenantFiles(validate_plik, nazwa_pliku)
   result:=""

   IF validate_plik
      i:=Len(nazwa_pliku)

      IF i==0
         result+="Nie wybrano "+HTMLWriter(): _z()+"adnego pliku! "
      ELSE
         DO WHILE i>0 .AND. nazwa_pliku[i]!='.'
            i--
         END DO

         IF Lower(SubStr(nazwa_pliku, i+1))!="pdf"
            result+="Plik nie jest w formacie pdf! <br />"
            //result+=Lower(SubStr(nazwa_pliku, i+1))
         ENDIF
      ENDIF
   ENDIF
RETURN result


CLASS METHOD Validation: ReplaceNull(chars, newChars)
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