{ *********************************************************************** }
{                                                                         }
{ ParseCommon                                                             }
{                                                                         }
{ Copyright (c) 2006 Pisarev Yuriy (mail@pisarev.net)                     }
{                                                                         }
{ *********************************************************************** }

unit ParseCommon;

{$B-}

interface

uses
  Classes, ParseTypes, TextConsts, ValueTypes;

type
  TCommonItemType = (itUnknown, itNumber, itScript);
  PCommonItem = ^TCommonItem;
  TCommonItem = record
    ItemType: TCommonItemType;
    Value: TValue;
    Script: TScript;
  end;

const
  Lock = Exclamation;

function IndexOf(Strings: TStrings; const Text: string; ByName: Boolean;
  ItemName: PString = nil): Integer;
function Find(Strings: TStrings; const Text: string; ByName: Boolean; out Index: Integer;
  ItemName: PString = nil): Boolean;
procedure AssignValue(var Data: TCommonItem; const AValue: TValue);

implementation

uses
  SysUtils, StrUtils, TextUtils;

function IndexOf(Strings: TStrings; const Text: string; ByName: Boolean;
  ItemName: PString): Integer;
var
  S: string;
begin
  if not Assigned(ItemName) then ItemName := @S;
  ItemName^ := Trim(Text);
  if AnsiStartsText(Lock, ItemName^) then System.Delete(ItemName^, 1, Length(Lock));
  if ByName then Result := Strings.IndexOfName(ItemName^)
  else Result := Strings.IndexOf(ItemName^);
end;

function Find(Strings: TStrings; const Text: string; ByName: Boolean; out Index: Integer;
  ItemName: PString): Boolean;
begin
  Index := IndexOf(Strings, Text, ByName, ItemName);
  Result := Index >= 0;
end;

procedure AssignValue(var Data: TCommonItem; const AValue: TValue);
begin
  FillChar(Data, SizeOf(TCommonItem), 0);
  with Data do
  begin
    ItemType := itNumber;
    Value := AValue;
  end;
end;

end.
