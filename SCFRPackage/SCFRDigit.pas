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

//����� ��������
function Propis(Value: integer; Masculine: boolean): string;
var
  Rend: boolean;
  ValueTemp: integer;

  procedure Num(Value: byte);
  begin
    case Value of
      1: if Rend = true then Result := Result + '���� ' else Result := Result + '���� ';
      2: if Rend = true then Result := Result + '��� ' else Result := Result + '��� ';
      3: Result := Result + '��� ';
      4: Result := Result + '������ ';
      5: Result := Result + '���� ';
      6: Result := Result + '����� ';
      7: Result := Result + '���� ';
      8: Result := Result + '������ ';
      9: Result := Result + '������ ';
      10: Result := Result + '������ ';
      11: Result := Result + '����������� ';
      12: Result := Result + '���������� ';
      13: Result := Result + '���������� ';
      14: Result := Result + '������������ ';
      15: Result := Result + '���������� ';
      16: Result := Result + '����������� ';
      17: Result := Result + '���������� ';
      18: Result := Result + '������������ ';
      19: Result := Result + '������������ ';
    end
  end;

  procedure Num10(Value: byte);
  begin
    case Value of
      2: Result := Result + '�������� ';
      3: Result := Result + '�������� ';
      4: Result := Result + '����� ';
      5: Result := Result + '��������� ';
      6: Result := Result + '���������� ';
      7: Result := Result + '��������� ';
      8: Result := Result + '����������� ';
      9: Result := Result + '��������� ';
    end;
  end;

  procedure Num100(Value: byte);
  begin
    case Value of
      1: Result := Result + '��� ';
      2: Result := Result + '������ ';
      3: Result := Result + '������ ';
      4: Result := Result + '��������� ';
      5: Result := Result + '������� ';
      6: Result := Result + '�������� ';
      7: Result := Result + '������� ';
      8: Result := Result + '��������� ';
      9: Result := Result + '��������� ';
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
  if (Value = 0) then Result := '����'
  else
  begin
    Result := '';
    Rend := true;
    NumMult(1000000000, '�������� ', '��������� ', '���������� ');
    NumMult(1000000, '������� ', '�������� ', '��������� ');
    Rend := false;
    NumMult(1000, '������ ', '������ ', '����� ');
    Rend := Masculine;
    ValueTemp := Value;
    Num00;
  end;
end;

function MonthStr(Value: integer): string;
begin
  Result:= '<����� �� ��������>';
  case Value of
    1: Result:= '������';
    2: Result:= '�������';
    3: Result:= '�����';
    4: Result:= '������';
    5: Result:= '���';
    6: Result:= '����';
    7: Result:= '����';
    8: Result:= '�������';
    9: Result:= '��������';
    10: Result:= '�������';
    11: Result:= '������';
    12: Result:= '�������';
  end;
end;

function MonthStrCase(Value: integer): string;
begin
  Result:= '<����� �� ��������>';
  case Value of
    1: Result:= '������';
    2: Result:= '�������';
    3: Result:= '�����';
    4: Result:= '������';
    5: Result:= '���';
    6: Result:= '����';
    7: Result:= '����';
    8: Result:= '�������';
    9: Result:= '��������';
    10: Result:= '�������';
    11: Result:= '������';
    12: Result:= '�������';
  end;
end;

{ TBRSDigitFunctions }
constructor TBRSDigitFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);

  with AScript do begin
    AddMethod('function Propis(int:integer, masculine:boolean):string', CallMethod, '������� SC-Retail', '����� ��������');
    AddMethod('function MonthStr(value:integer):string', CallMethod, '������� SC-Retail', '����� ��������');
    AddMethod('function MonthStrCase(value:integer):string', CallMethod, '������� SC-Retail', '����� �������� � ���������');
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