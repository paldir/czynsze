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

CLASS METHOD Validation: Building(kod_1, il_miesz, udzial_w_k)
   result:=""

   FOR i:=1 to Len(kod_1)
      IF !IsDigit(kod_1[i])
         result+="Kod budynku musi byc liczba! <br />"
         exit
      ENDIF
   NEXT

   FOR i:=1 to Len(il_miesz)
      IF !IsDigit(il_miesz[i])
         result+="Ilosc lokali musi byc liczba! <br />"
         exit
      ENDIF
   NEXT

   FOR i:=1 to Len(udzial_w_k)
      IF !IsDigit(udzial_w_k[i])
         result+="Udzial w kosztach musi byc liczba! <br />"
         exit
      ENDIF
   NEXT
RETURN result