{ Author   : Mr.Theera Tangtirmthong.
  Modified : August 30, 2002.
  Email    : Pu121@lemononline.com
 }

 { ThaiCopy('วันที่',1,2)    = 'วัน'
   ThaiLength('วันที่')    = 3
   ThaiLeft('วันที่',2)    = 'วัน'
   ThaiLeft('วันที่',5)    = 'วันที่  '
   Thaimid('ที่',5)        = '  ที่  '
   ThaiRight('วันที่',2)    = 'นที่'
   ThaiRight('วันที่',5)    = '  วันที่'
   Rem_space('วันที่   ')    = 'วันที่'  // un thaileft
   ThaiMoney(5)    = 'ห้าบาท'
 }
unit UThai2;

interface
uses Sysutils;

  function ThaiCopy(S: string; index, Tcount: integer): string;
  function ThaiLength(S: string): integer;
  function ThaiLeft(S: string; Wide : integer ): string;
  function ThaiRight(S: string; wide : integer): string;
  function ThaiMID(S: string; wide : integer): string;
  function Rem_space(S:string):string;
  function Rem_comma(S:string):string;
  Function ThaiMoney(Tm_Money : Double) :String;
  function EngLeft(S: string; Wide : integer ): string;
implementation

function ThaiCopy(S: string; index, Tcount: integer): string;
var i :integer;
    Thaiindex : integer;
    Thaicount : integer;
    S2:string;
begin
  //เริ่มต้นที่พยัญชนะตัวแรก
  i:=ThaiLength(ThaiLeft(S,Index));
  S2:=ThaiLeft(S,i-1);
  Thaiindex:=Length(S2)+1;
  //สิ้นสุทที่สระตัวสุดท้าย
  i:=ThaiLength(ThaiLeft(S,Index+tcount));

  S2:=ThaiLeft(S,i-1);
  Thaicount:=(Length(S2)+1)-ThaiIndex;
  ThaiCopy:=copy(S,Thaiindex,Thaicount);
end;

function ThaiLength(S: string): integer;
var TLength :integer;
    i : integer;
begin
  Tlength:=Length(S);
  for i:=1 to Length(S) do
  begin
    //สระภาษาไทยที่ไม่นับ   กั กิ-กู ก็-กํ
    case S[i] of
    'ั', 'ิ'..'ู', '็'..'ํ' :
      begin
        Tlength := Tlength-1;
      end
    end;
  end;
  ThaiLength:=Tlength;

end;

function ThaiLeft(S: string; Wide : integer): string;
var ii:integer;
   // point_Cut : integer;
    LWide : integer;
    S_Left : string;
begin
  if ThaiLength(S) >= Wide then
  begin
    if wide <= 1 then ii:=3
    else ii:=Length(S);
    repeat
      S_Left:= copy(S,1,ii);
      LWide := ThaiLength(S_Left);
      ii:=ii-1;
    until (Lwide <= Wide);
    //return
    ThaiLeft := S_Left;
  end
  else
  begin
    S_Left := '';
    for ii:=ThaiLength(S) to Wide-1 do
    begin
      S_Left:=S_left+' ';
    end;
    //return
    ThaiLeft := S+S_Left;
  end;
end;

function EngLeft(S: string; Wide : integer): string;
var ii:integer;
   // point_Cut : integer;
    LWide : integer;
    S_Left : string;
begin
  if Length(S) >= Wide then
  begin
    EngLeft := copy(S,1,Wide);
  end
  else
  begin
    EngLeft := S+thaileft('',Wide-Length(S));
  end;
end;


function ThaiMid(S: string; wide: integer): string;
var S_mid :string;
begin
  s_mid := ThaiLeft('',(wide-ThaiLength(S))div 2)
          +S;
 result := S_mid+ThaiLeft('',wide-thaiLength(S_mid));

end;

function ThaiRight(S: string; wide: integer): string;
var ii:integer;
  //  point_Cut : integer;
    LWide : integer;
    S_Right : string;
begin
  if ThaiLength(S) >= Wide then
  begin
    ii:=1;
    repeat
      S_Right:= copy(S,Length(S)-ii,ii+1);
      LWide := ThaiLength(S_Right);
      ii:=ii+1;
    until (Lwide = Wide);
    //return
    ThaiRight := S_Right;
  end
  else
  begin
    S_Right := '';
    for ii:=ThaiLength(S) to Wide-1 do
    begin
      S_Right:=S_Right+' ';
    end;
    //return
    thaiRight := S_Right+S;
  end;

end;


function Rem_space(S:string):string;
var Space_rem : integer;
    ret : string;
    i : integer;
begin
  ret := '';
  i:=1;
  Space_rem := 0;
  while i <= Length(S) do
  begin
    case S[i] of
    'ั', 'ิ'..'ู', '็'..'ํ' :
      begin
        Space_rem := Space_rem+1;
      end
    end;
    while (i <= Length(S)) and (S[i] = ' ') do
    begin
      if (Space_rem > 0) and (S[i+1] = ' ') then  Space_rem := Space_rem - 1
      else
      begin
        ret := ret+S[i];
      end;
      i:=i+1;
    end;
//    Space_rem := 0;
    ret := ret+S[i];
    i:=i+1;
  end;
  result := ret;
end;

function Rem_comma(S:string):string;
var Space_rem : integer;
    ret : string;
    i : integer;
begin
  ret := '';
  i:=1;
  Space_rem := 0;
  while i <= Length(S) do
  begin
    case S[i] of
    ',' :
      begin
        Space_rem := Space_rem+1;
      end
    end;
    while (i <= Length(S)) and (S[i] = ',') do
    begin
      i:=i+1;
    end;
//    Space_rem := 0;
    ret := ret+S[i];
    i:=i+1;
  end;
  result := ret;
end;

function ThaiMoney(Tm_Money : Double) :String;
var
  Tm_ThiVAL : Array[1..10] Of String;
  Tm_ThiDigit : Array[1..7] Of String;
  sMoney,Tm_Major,Tm_Minor,Tm_Value : String;
  Tm_Pos,Tm_Loop,Tm_MaxDigit,Tm_Count,Tm_CurVal,Tm_Point : Integer;
  Tm_result,Tm_CurStr,Tm_CurDigit : String;
begin
   Tm_ThiVAL[1]    := '';
   Tm_ThiVAL[2]    := 'หนึ่ง';
   Tm_ThiVAL[3]    := 'สอง';
   Tm_ThiVAL[4]    := 'สาม';
   Tm_ThiVAL[5]    := 'สี่';
   Tm_ThiVAL[6]    := 'ห้า';
   Tm_ThiVAL[7]    := 'หก';
   Tm_ThiVAL[8]    := 'เจ็ด';
   Tm_ThiVAL[9]    := 'แปด';
   Tm_ThiVAL[10]   := 'เก้า';
   Tm_ThiDigit[1]  := '';
   Tm_ThiDigit[2]  := 'สิบ';
   Tm_ThiDigit[3]  := 'ร้อย';
   Tm_ThiDigit[4]  := 'พัน';
   Tm_ThiDigit[5]  := 'หมื่น';
   Tm_ThiDigit[6]  := 'แสน';
   Tm_ThiDigit[7]  := 'ล้าน';
//--- convert value to string
   If Tm_Money = 0 Then
     sMoney := ''
   Else
    begin
     sMoney := FormatFloat('############0.00',Tm_Money);
//--- search position of '.' in money string
     Tm_Pos := Pos('.',sMoney);
//--- classifly major and minor value
     If Tm_Pos > 0 Then
       begin
         Tm_Major := COPY(sMoney, 1, Tm_Pos-1);
         Tm_Minor := COPY(sMoney, Tm_Pos+1, Length(sMoney));
       end
     Else
       begin
         Tm_Major := sMoney;
         Tm_Minor := '';
       end;
    end;
//*--- convert value to thai
   Tm_Loop  := 1;   //--- Tm_Loop 1=Major   2=Minor
   Tm_Value := Tm_Major;
   While (Tm_Loop <= 2) AND (Length(sMoney)<>0) Do
     begin
//   &&--- begin convert english value to thai
       Tm_Result := '';
       Tm_MaxDigit := Length(Tm_Value);  // Tm_Value IF write by PROCEDURE
       Tm_Count := 1;
       While Tm_Count <= Tm_MaxDigit Do
         begin
          Tm_CurVal := StrToInt(Copy(Tm_Value, Tm_MaxDigit-Tm_Count+1, 1));
          If (Tm_Count Mod 6) = 0 Then
            Tm_Point  :=  6
          Else
            Tm_Point := Tm_Count Mod 6;
          If (Tm_Point=1) AND (Tm_MaxDigit<>Tm_Count) AND (Tm_CurVal=1) Then
              Tm_CurStr := 'เอ็ด'
          Else If (Tm_Point=2) AND (Tm_CurVal=2) Then
              Tm_CurStr := 'ยี่'
          Else If (Tm_Point=2) AND (Tm_CurVal=1) Then
              Tm_CurStr := ''
          Else
              Tm_CurStr := Tm_ThiVAL[Tm_CurVal+1];
          If ((Tm_Count Mod 6) = 1) AND (Tm_Count > 6) Then
              Tm_CurDigit := Tm_ThiDigit[7]
          Else If Tm_CurVal = 0 Then
              Tm_CurDigit := ''
          Else
              Tm_CurDigit := Tm_ThiDigit[Tm_Point];
          Tm_Result := Tm_CurStr + Tm_CurDigit + Tm_Result;
          Tm_Count  := Tm_Count + 1;
         end;   //--- end convert english value to thai
       If Tm_Loop = 1 Then
          Tm_Major := Tm_Result
       Else
          Tm_Minor := Tm_Result;
       Tm_Loop  := Tm_Loop + 1;
       Tm_Value := Tm_Minor;
     end;
   If (Length(TRIM(Tm_Major))>0)  AND (Length(TRIM(Tm_Minor))>0) Then
        Tm_Result := Tm_Major + 'บาท'+Tm_Minor + 'สตางค์'
   Else If (Length(TRIM(Tm_Major))=0) AND (Length(TRIM(Tm_Minor))=0) then
        Tm_Result := ''
   Else If (Length(TRIM(Tm_Minor))=0) Then
        Tm_Result := Tm_Major + 'บาท'
   Else If (Length(TRIM(Tm_Major))=0) Then
        Tm_Result := Tm_Minor + 'สตางค์'
   Else
        Tm_Result := '';
   result := Tm_Result;
end;

end.

