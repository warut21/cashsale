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
function ThaiLeft(S: string; Wide: integer): string;
function ThaiRight(S: string; wide: integer): string;
function ThaiMID(S: string; wide: integer): string;
function Rem_space(S: string): string;
function Rem_comma(S: string): string;
function ThaiMoney(Tm_Money: Double): string;
function EngLeft(S: string; Wide: integer): string;
implementation

function ThaiCopy(S: string; index, Tcount: integer): string;
var i: integer;
  Thaiindex: integer;
  Thaicount: integer;
  S2: string;
begin
  //เริ่มต้นที่พยัญชนะตัวแรก
  i := ThaiLength(ThaiLeft(S, Index));
  S2 := ThaiLeft(S, i - 1);
  Thaiindex := Length(S2) + 1;
  //สิ้นสุทที่สระตัวสุดท้าย
  i := ThaiLength(ThaiLeft(S, Index + tcount));

  S2 := ThaiLeft(S, i - 1);
  Thaicount := (Length(S2) + 1) - ThaiIndex;
  ThaiCopy := copy(S, Thaiindex, Thaicount);
end;

function ThaiLength(S: string): integer;
var TLength: integer;
  i: integer;
begin
  Tlength := Length(S);
  for i := 1 to Length(S) do
  begin
    //สระภาษาไทยที่ไม่นับ   กั กิ-กู ก็-กํ
    case S[i] of
      'ั', 'ิ'..'ู', '็'..'ํ':
        begin
          Tlength := Tlength - 1;
        end
    end;
  end;
  ThaiLength := Tlength;

end;

function ThaiLeft(S: string; Wide: integer): string;
var ii: integer;
   // point_Cut : integer;
  LWide: integer;
  S_Left: string;
begin
  if ThaiLength(S) >= Wide then
  begin
    if wide <= 1 then ii := 3
    else ii := Length(S);
    repeat
      S_Left := copy(S, 1, ii);
      LWide := ThaiLength(S_Left);
      ii := ii - 1;
    until (Lwide <= Wide);
    //return
    ThaiLeft := S_Left;
  end
  else
  begin
    S_Left := '';
    for ii := ThaiLength(S) to Wide - 1 do
    begin
      S_Left := S_left + ' ';
    end;
    //return
    ThaiLeft := S + S_Left;
  end;
end;

function EngLeft(S: string; Wide: integer): string;
var ii: integer;
   // point_Cut : integer;
  LWide: integer;
  S_Left: string;
begin
  if Length(S) >= Wide then
  begin
    EngLeft := copy(S, 1, Wide);
  end
  else
  begin
    EngLeft := S + thaileft('', Wide - Length(S));
  end;
end;


function ThaiMid(S: string; wide: integer): string;
var S_mid: string;
begin
  s_mid := ThaiLeft('', (wide - ThaiLength(S)) div 2)
    + S;
  result := S_mid + ThaiLeft('', wide - thaiLength(S_mid));

end;

function ThaiRight(S: string; wide: integer): string;
var ii: integer;
  //  point_Cut : integer;
  LWide: integer;
  S_Right: string;
begin
  if ThaiLength(S) >= Wide then
  begin
    ii := 1;
    repeat
      S_Right := copy(S, Length(S) - ii, ii + 1);
      LWide := ThaiLength(S_Right);
      ii := ii + 1;
    until (Lwide = Wide);
    //return
    ThaiRight := S_Right;
  end
  else
  begin
    S_Right := '';
    for ii := ThaiLength(S) to Wide - 1 do
    begin
      S_Right := S_Right + ' ';
    end;
    //return
    thaiRight := S_Right + S;
  end;

end;


function Rem_space(S: string): string;
var Space_rem: integer;
  ret: string;
  i: integer;
begin
  ret := '';
  i := 1;
  Space_rem := 0;
  while i <= Length(S) do
  begin
    case S[i] of
      'ั', 'ิ'..'ู', '็'..'ํ':
        begin
          Space_rem := Space_rem + 1;
        end
    end;
    while (i <= Length(S)) and (S[i] = ' ') do
    begin
      if (Space_rem > 0) and (S[i + 1] = ' ') then Space_rem := Space_rem - 1
      else
      begin
        ret := ret + S[i];
      end;
      i := i + 1;
    end;
//    Space_rem := 0;
    ret := ret + S[i];
    i := i + 1;
  end;
  result := ret;
end;

function Rem_comma(S: string): string;
var Space_rem: integer;
  ret: string;
  i: integer;
begin
  ret := '';
  i := 1;
  Space_rem := 0;
  while i <= Length(S) do
  begin
    case S[i] of
      ',':
        begin
          Space_rem := Space_rem + 1;
        end
    end;
    while (i <= Length(S)) and (S[i] = ',') do
    begin
      i := i + 1;
    end;
//    Space_rem := 0;
    ret := ret + S[i];
    i := i + 1;
  end;
  result := ret;
end;

function ThaiMoney(Tm_Money: Double): string;
var
  Tm_ThiVAL: array[1..10] of string;
  Tm_ThiDigit: array[1..7] of string;
  sMoney, Tm_Major, Tm_Minor, Tm_Value: string;
  Tm_Pos, Tm_Loop, Tm_MaxDigit, Tm_Count, Tm_CurVal, Tm_Point: Integer;
  Tm_result, Tm_CurStr, Tm_CurDigit: string;
begin
  Tm_ThiVAL[1] := '';
  Tm_ThiVAL[2] := 'หนึ่ง';
  Tm_ThiVAL[3] := 'สอง';
  Tm_ThiVAL[4] := 'สาม';
  Tm_ThiVAL[5] := 'สี่';
  Tm_ThiVAL[6] := 'ห้า';
  Tm_ThiVAL[7] := 'หก';
  Tm_ThiVAL[8] := 'เจ็ด';
  Tm_ThiVAL[9] := 'แปด';
  Tm_ThiVAL[10] := 'เก้า';
  Tm_ThiDigit[1] := '';
  Tm_ThiDigit[2] := 'สิบ';
  Tm_ThiDigit[3] := 'ร้อย';
  Tm_ThiDigit[4] := 'พัน';
  Tm_ThiDigit[5] := 'หมื่น';
  Tm_ThiDigit[6] := 'แสน';
  Tm_ThiDigit[7] := 'ล้าน';
//--- convert value to string
  if Tm_Money = 0 then
    sMoney := ''
  else
  begin
    sMoney := FormatFloat('############0.00', Tm_Money);
//--- search position of '.' in money string
    Tm_Pos := Pos('.', sMoney);
//--- classifly major and minor value
    if Tm_Pos > 0 then
    begin
      Tm_Major := COPY(sMoney, 1, Tm_Pos - 1);
      Tm_Minor := COPY(sMoney, Tm_Pos + 1, Length(sMoney));
    end
    else
    begin
      Tm_Major := sMoney;
      Tm_Minor := '';
    end;
  end;
//*--- convert value to thai
  Tm_Loop := 1; //--- Tm_Loop 1=Major   2=Minor
  Tm_Value := Tm_Major;
  while (Tm_Loop <= 2) and (Length(sMoney) <> 0) do
  begin
//   &&--- begin convert english value to thai
    Tm_Result := '';
    Tm_MaxDigit := Length(Tm_Value); // Tm_Value IF write by PROCEDURE
    Tm_Count := 1;
    while Tm_Count <= Tm_MaxDigit do
    begin
      Tm_CurVal := StrToInt(Copy(Tm_Value, Tm_MaxDigit - Tm_Count + 1, 1));
      if (Tm_Count mod 6) = 0 then
        Tm_Point := 6
      else
        Tm_Point := Tm_Count mod 6;
      if (Tm_Point = 1) and (Tm_MaxDigit <> Tm_Count) and (Tm_CurVal = 1) then
        Tm_CurStr := 'เอ็ด'
      else if (Tm_Point = 2) and (Tm_CurVal = 2) then
        Tm_CurStr := 'ยี่'
      else if (Tm_Point = 2) and (Tm_CurVal = 1) then
        Tm_CurStr := ''
      else
        Tm_CurStr := Tm_ThiVAL[Tm_CurVal + 1];
      if ((Tm_Count mod 6) = 1) and (Tm_Count > 6) then
        Tm_CurDigit := Tm_ThiDigit[7]
      else if Tm_CurVal = 0 then
        Tm_CurDigit := ''
      else
        Tm_CurDigit := Tm_ThiDigit[Tm_Point];
      Tm_Result := Tm_CurStr + Tm_CurDigit + Tm_Result;
      Tm_Count := Tm_Count + 1;
    end; //--- end convert english value to thai
    if Tm_Loop = 1 then
      Tm_Major := Tm_Result
    else
      Tm_Minor := Tm_Result;
    Tm_Loop := Tm_Loop + 1;
    Tm_Value := Tm_Minor;
  end;
  if (Length(TRIM(Tm_Major)) > 0) and (Length(TRIM(Tm_Minor)) > 0) then
    Tm_Result := Tm_Major + 'บาท' + Tm_Minor + 'สตางค์'
  else if (Length(TRIM(Tm_Major)) = 0) and (Length(TRIM(Tm_Minor)) = 0) then
    Tm_Result := ''
  else if (Length(TRIM(Tm_Minor)) = 0) then
    Tm_Result := Tm_Major + 'บาท'
  else if (Length(TRIM(Tm_Major)) = 0) then
    Tm_Result := Tm_Minor + 'สตางค์'
  else
    Tm_Result := '';
  result := Tm_Result;
end;

end.
