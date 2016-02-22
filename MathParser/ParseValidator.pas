{ *********************************************************************** }
{                                                                         }
{ ParseValidator                                                          }
{                                                                         }
{ Copyright (c) 2006 Pisarev Yuriy (mail@pisarev.net)                     }
{                                                                         }
{ *********************************************************************** }

unit ParseValidator;

{$B-}

interface

uses
  SysUtils, Types, TextConsts;

type
  TReserveType = (rtName, rtText);

  EValidatorError = class(Exception);

  TValidator = class
  protected
    function Error(const Message: string): Exception; overload; virtual;
    function Error(const Message: string; const Arguments: array of const): Exception; overload; virtual;
  public
    procedure Check(const AText: string; const AType: TReserveType); virtual;
  end;

var
  Validator: TValidator;
  Reserve: array[TReserveType] of string;

implementation

uses
  NumberConsts, ParseErrors, TextUtils;

{ TValidator }

procedure TValidator.Check(const AText: string; const AType: TReserveType);
var
  I: Integer;
begin
  for I := 1 to Length(Reserve[AType]) do if Contains(AText, Reserve[AType][I]) then
    raise Error(ReserveError, [AText, Reserve[AType][I]]);
  if (AType = rtName) and (Length(AText) > 0) and Number(AText[1]) then
    raise Error(DefinitionError, [AText]);
end;

function TValidator.Error(const Message: string): Exception;
begin
  Result := Error(Message, []);
end;

function TValidator.Error(const Message: string;
  const Arguments: array of const): Exception;
begin
  Result := EValidatorError.CreateFmt(Message, Arguments);
end;

initialization
  Validator := TValidator.Create;
  Reserve[rtName] := LeftBrace + RightBrace + LeftParenthesis + RightParenthesis +
    LeftBracket + RightBracket + Comma + DecimalSeparator +
    DoubleQuote + Minus + Plus + Quote + Semicolon + Space;
  Reserve[rtText] := LeftBrace + RightBrace;

finalization
  Validator.Free;

end.
