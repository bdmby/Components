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

function NumToStr(n: double; c: byte = 0): string;
(*
c=0 - 21.05 -> '�������� ���� ����� 05 ������.'
�=1 - 21.05 -> '�������� ����'
c=2 - 21.05 -> '21-05', 21.00 -> '21='
*)
const
  digit: array[0..9] of string = ('����', '���', '���', '���', '�����', '���', '����', '���', '�����', '�����');
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
          0: result := '������ ';
          2: result := '���������� ';
        else
          result := digit[d] + '������� ';
        end;

        case pos of
          4: result := result + '����� ';
          7: result := result + '��������� ';
          10: result := result + '���������� ';
        end;

        SecDes := false;
        mln := false;
        mlrd := false;
        ts := false;
      end else begin
        if (pos = 2) or (pos = 5) or (pos = 8) or (pos = 11) then begin
          case d of
            1: SecDes := true;
            2, 3: result := digit[d] + '����� ';
            4: result := '����� ';
            9: result := '��������� ';
            5..8: result := digit[d] + '������ ';
          end;
        end;

        if (pos = 3) or (pos = 6) or (pos = 9) or (pos = 12) then begin
          case d of
            1: result := '��� ';
            2: result := '������ ';
            3: result := '������ ';
            4: result := '��������� ';
            5..9: result := digit[d] + '���� ';
          end;
        end;

        if (pos = 1) or (pos = 4) or (pos = 7) or (pos = 10) then begin
          case d of
            1: result := '���� ';
            2, 3: result := digit[d] + ' ';
            4: result := '������ ';
            5..9: result := digit[d] + '� ';
          end;
        end;

        if pos = 4 then begin
          case d of
            0: if ts then
                result := '����� ';
            1: result := '���� ������ ';
            2: result := '��� ������ ';
            3, 4: result := result + '������ ';
            5..9: result := result + '����� ';
          end;
          ts := false;
        end;

        if (pos = 7) then begin
          case d of
            0: if mln then begin
                result := '��������� ';
               end;
            1: result := result + '������� ';
            2, 3, 4: result := result + '�������� ';
            5..9: result := result + '��������� ';
          end;
          mln := false;
        end;

        if (pos = 10) then begin
          case d of
            0: if mlrd then begin
                result := '���������� ';
               end;
            1: result := result + '�������� ';
            2, 3, 4: result := result + '��������� ';
            5..9: result := result + '���������� ';
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
      result := result + '����������� ������';
    end else begin
      case StrToInt(copy(n, len, 1)) of
        1: result := result + '����������� �����';
        2, 3, 4: result := result + '����������� �����';
      else
        result := result + '����������� ������';
      end;
    end;

    len := length(number);
    n := copy(number, len - 1, len);
    if copy(n, 1, 1) = '1' then begin
      n := n + ' ������';
    end else begin
      case StrToInt(copy(n, 2, 1)) of
        1: n := n + ' �������';
        2, 3, 4: n := n + ' �������';
      else
        n := n + ' ������';
      end;
    end;

    result := result + ' ' + n;
  end;

  // �������� �����
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
    AddMethod('function Propis(int:integer, masculine:boolean):string', CallMethod, '������� SC-Retail', '����� ��������');
    AddMethod('function MonthStr(value:integer):string', CallMethod, '������� SC-Retail', '����� ��������');
    AddMethod('function MonthStrCase(value:integer):string', CallMethod, '������� SC-Retail', '����� �������� � ���������');
    AddMethod('function NumToStr(n:real, c:integer):string', CallMethod, '������� SC-Retail', '����� (�����) ��������');
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