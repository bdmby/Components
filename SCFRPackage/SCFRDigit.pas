unit SCFRDigit;
interface
uses SysUtils, Classes, fs_iinterpreter, fs_itools;

type
  TBRSDigitFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end; { TBRSDigitFunctions }

implementation

//„исло прописью
function Propis(Value: integer; Masculine: boolean): string;
var
  Rend: boolean;
  ValueTemp: integer;

  procedure Num(Value: byte);
  begin
    case Value of
      1: if Rend = true then Result := Result + 'один ' else Result := Result + 'одна ';
      2: if Rend = true then Result := Result + 'два ' else Result := Result + 'две ';
      3: Result := Result + 'три ';
      4: Result := Result + 'четыре ';
      5: Result := Result + 'п€ть ';
      6: Result := Result + 'шесть ';
      7: Result := Result + 'семь ';
      8: Result := Result + 'восемь ';
      9: Result := Result + 'дев€ть ';
      10: Result := Result + 'дес€ть ';
      11: Result := Result + 'одиннадцать ';
      12: Result := Result + 'двенадцать ';
      13: Result := Result + 'тринадцать ';
      14: Result := Result + 'четырнадцать ';
      15: Result := Result + 'п€тнадцать ';
      16: Result := Result + 'шестнадцать ';
      17: Result := Result + 'семнадцать ';
      18: Result := Result + 'восемнадцать ';
      19: Result := Result + 'дев€тнадцать ';
    end
  end;

  procedure Num10(Value: byte);
  begin
    case Value of
      2: Result := Result + 'двадцать ';
      3: Result := Result + 'тридцать ';
      4: Result := Result + 'сорок ';
      5: Result := Result + 'п€тьдес€т ';
      6: Result := Result + 'шестьдес€т ';
      7: Result := Result + 'семьдес€т ';
      8: Result := Result + 'восемьдес€т ';
      9: Result := Result + 'дев€носто ';
    end;
  end;

  procedure Num100(Value: byte);
  begin
    case Value of
      1: Result := Result + 'сто ';
      2: Result := Result + 'двести ';
      3: Result := Result + 'триста ';
      4: Result := Result + 'четыреста ';
      5: Result := Result + 'п€тьсот ';
      6: Result := Result + 'шестьсот ';
      7: Result := Result + 'семьсот ';
      8: Result := Result + 'восемьсот ';
      9: Result := Result + 'дев€тьсот ';
    end
  end;

  procedure Num00;
  begin
    Num100(ValueTemp div 100);
    ValueTemp := ValueTemp mod 100;
    if ValueTemp < 20 then Num(ValueTemp)
    else
    begin
      Num10(ValueTemp div 10);
      ValueTemp := ValueTemp mod 10;
      Num(ValueTemp);
    end;
  end;

  procedure NumMult(Mult: integer; s1, s2, s3: string);
  var ValueRes: integer;
  begin
    if Value >= Mult then
    begin
      ValueTemp := Value div Mult;
      ValueRes := ValueTemp;
      Num00;
      if ValueTemp = 1 then Result := Result + s1
      else if (ValueTemp > 1) and (ValueTemp < 5) then Result := Result + s2
      else Result := Result + s3;
      Value := Value - Mult * ValueRes;
    end;
  end;

begin
  if (Value = 0) then Result := 'ноль'
  else
  begin
    Result := '';
    Rend := true;
    NumMult(1000000000, 'миллиард ', 'миллиарда ', 'миллиардов ');
    NumMult(1000000, 'миллион ', 'миллиона ', 'миллионов ');
    Rend := false;
    NumMult(1000, 'тыс€ча ', 'тыс€чи ', 'тыс€ч ');
    Rend := Masculine;
    ValueTemp := Value;
    Num00;
  end;
end;

function MonthStr(Value: integer): string;
begin
  Result:= '<мес€ц не определЄн>';
  case Value of
    1: Result:= '€нвар€';
    2: Result:= 'феврал€';
    3: Result:= 'марта';
    4: Result:= 'апрел€';
    5: Result:= 'ма€';
    6: Result:= 'июн€';
    7: Result:= 'июл€';
    8: Result:= 'августа';
    9: Result:= 'сент€бр€';
    10: Result:= 'окт€бр€';
    11: Result:= 'но€бр€';
    12: Result:= 'декабр€';
  end;
end;

function MonthStrCase(Value: integer): string;
begin
  Result:= '<мес€ц не определЄн>';
  case Value of
    1: Result:= '€нваре';
    2: Result:= 'феврале';
    3: Result:= 'марте';
    4: Result:= 'апреле';
    5: Result:= 'мае';
    6: Result:= 'июне';
    7: Result:= 'июле';
    8: Result:= 'августе';
    9: Result:= 'сент€бре';
    10: Result:= 'окт€бре';
    11: Result:= 'но€бре';
    12: Result:= 'декабре';
  end;
end;

function NumToStr(n: double; c: byte = 0): string;
(*
c=0 - 21.05 -> 'ƒвадцать один рубль 05 копеек.'
с=1 - 21.05 -> 'двадцать один'
c=2 - 21.05 -> '21-05', 21.00 -> '21='
*)
const
  digit: array[0..9] of string = ('ноль', 'оди', 'два', 'три', 'четыр', 'п€т', 'шест', 'сем', 'восем', 'дев€т');
var
  ts, mln, mlrd, SecDes: Boolean;
  len: byte;
  summa: string;

  function NumberString(number: string): string;
  var
    d, pos: byte;

    function DigitToStr: string;
    begin
      result := '';
      if (d <> 0)
         and ((pos = 11) or (pos = 12)) then begin
        mlrd := true;
      end;

      if (d <> 0)
         and ((pos = 8) or (pos = 9)) then begin
        mln := true;
      end;

      if (d <> 0)
         and ((pos = 5) or (pos = 6)) then begin
        ts := true;
      end;

      if SecDes then begin
        case d of
          0: result := 'дес€ть ';
          2: result := 'двенадцать ';
        else
          result := digit[d] + 'надцать ';
        end;

        case pos of
          4: result := result + 'тыс€ч ';
          7: result := result + 'миллионов ';
          10: result := result + 'миллиардов ';
        end;

        SecDes := false;
        mln := false;
        mlrd := false;
        ts := false;
      end else begin
        if (pos = 2) or (pos = 5) or (pos = 8) or (pos = 11) then begin
          case d of
            1: SecDes := true;
            2, 3: result := digit[d] + 'дцать ';
            4: result := 'сорок ';
            9: result := 'дев€носто ';
            5..8: result := digit[d] + 'ьдес€т ';
          end;
        end;

        if (pos = 3) or (pos = 6) or (pos = 9) or (pos = 12) then begin
          case d of
            1: result := 'сто ';
            2: result := 'двести ';
            3: result := 'триста ';
            4: result := 'четыреста ';
            5..9: result := digit[d] + 'ьсот ';
          end;
        end;

        if (pos = 1) or (pos = 4) or (pos = 7) or (pos = 10) then begin
          case d of
            1: result := 'один ';
            2, 3: result := digit[d] + ' ';
            4: result := 'четыре ';
            5..9: result := digit[d] + 'ь ';
          end;
        end;

        if pos = 4 then begin
          case d of
            0: if ts then
                result := 'тыс€ч ';
            1: result := 'одна тыс€ча ';
            2: result := 'две тыс€чи ';
            3, 4: result := result + 'тыс€чи ';
            5..9: result := result + 'тыс€ч ';
          end;
          ts := false;
        end;

        if (pos = 7) then begin
          case d of
            0: if mln then begin
                result := 'миллионов ';
               end;
            1: result := result + 'миллион ';
            2, 3, 4: result := result + 'миллиона ';
            5..9: result := result + 'миллионов ';
          end;
          mln := false;
        end;

        if (pos = 10) then begin
          case d of
            0: if mlrd then begin
                result := 'миллиардов ';
               end;
            1: result := result + 'миллиард ';
            2, 3, 4: result := result + 'миллиарда ';
            5..9: result := result + 'миллиардов ';
          end;
          mlrd := false;
        end;
      end;
    end;

  begin
    result := '';
    ts := false;
    mln := false;
    mlrd := false;
    SecDes := false;
    len := length(number);
    if (len = 0) or (number = '0') then begin
      result := digit[0]
    end else begin
      for pos := len downto 1 do begin
        d := StrToInt(copy(number, len - pos + 1, 1));
        result := result + DigitToStr;
      end;
    end;
  end;

  function MoneyString(number: string): string;
  var
    s: string;
    n: string;
  begin
    len := length(number);
    n := copy(number, 1, len - 3);
    result := NumberString(n);
    s := UpperCase(Copy(result, 1, 1));
    delete(result, 1, 1);
    result := s + result;
    if (len < 2) then begin
      if len = 0 then begin
        n := '0';
      end;
      len := 2;
      n := '0' + n;
    end;

    if (copy(n, len - 1, 1) = '1') then begin
      result := result + 'белорусских рублей';
    end else begin
      case StrToInt(copy(n, len, 1)) of
        1: result := result + 'белорусский рубль';
        2, 3, 4: result := result + 'белорусских рубл€';
      else
        result := result + 'белорусских рублей';
      end;
    end;

    len := length(number);
    n := copy(number, len - 1, len);
    if copy(n, 1, 1) = '1' then begin
      n := n + ' копеек';
    end else begin
      case StrToInt(copy(n, 2, 1)) of
        1: n := n + ' копейка';
        2, 3, 4: n := n + ' копейки';
      else
        n := n + ' копеек';
      end;
    end;

    result := result + ' ' + n;
  end;

  // ќсновна€ часть
begin
  case c of
    0: result := MoneyString(FormatFloat('0.00', n));
    1: result := NumberString(FormatFloat('0', n));
    2:
      begin
        summa := FormatFloat('0.00', n);
        len := length(summa);
        if (copy(summa, len - 1, 2) = '00') then begin
          delete(summa, len - 2, 3);
          result := summa + '=';
        end else begin
          delete(summa, len - 2, 1);
          insert('-', summa, len - 2);
          result := summa;
        end;
      end
  end;
end;

{ TBRSDigitFunctions }
constructor TBRSDigitFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);

  with AScript do begin
    AddMethod('function Propis(int:integer, masculine:boolean):string', CallMethod, '‘ункции SC-Retail', '„исло прописью');
    AddMethod('function MonthStr(value:integer):string', CallMethod, '‘ункции SC-Retail', 'ћес€ц прописью');
    AddMethod('function MonthStrCase(value:integer):string', CallMethod, '‘ункции SC-Retail', 'ћес€ц прописью в склонении');
    AddMethod('function NumToStr(n:real, c:integer):string', CallMethod, '‘ункции SC-Retail', '„исло (сумма) прописью');
  end;
end;

function TBRSDigitFunctions.CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;
begin
  if (UpperCase(MethodName) = 'PROPIS') then begin
    Result := Propis(Params[0], Params[1]);
  end else
  if (UpperCase(MethodName) = 'MONTHSTR') then begin
    Result := MonthStr(Params[0]);
  end else
  if (UpperCase(MethodName) = 'MONTHSTRCASE') then begin
    Result := MonthStrCase(Params[0]);
  end else
  if (UpperCase(MethodName) = 'NUMTOSTR') then begin
    Result := NumToStr(Params[0], Params[1]);
  end;
end;

begin
  fsRTTIModules.Add(TBRSDigitFunctions);
end.