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

{ TBRSDigitFunctions }
constructor TBRSDigitFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);

  with AScript do begin
    AddMethod('function Propis(int:integer, masculine:boolean):string', CallMethod, '‘ункции SC-Retail', '„исло прописью');
    AddMethod('function MonthStr(value:integer):string', CallMethod, '‘ункции SC-Retail', 'ћес€ц прописью');
    AddMethod('function MonthStrCase(value:integer):string', CallMethod, '‘ункции SC-Retail', 'ћес€ц прописью в склонении');
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
  end;
end;

begin
  fsRTTIModules.Add(TBRSDigitFunctions);
end.