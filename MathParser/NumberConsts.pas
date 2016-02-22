{ *********************************************************************** }
{                                                                         }
{ NumberConsts                                                            }
{                                                                         }
{ Copyright (c) 2007 Pisarev Yuriy (mail@pisarev.net)                     }
{                                                                         }
{ *********************************************************************** }

unit NumberConsts;

{$B-}
{$I Directives.inc}

interface

uses
  SysUtils, TextConsts, Types;

type
  TNumberType = (ntZero, ntOne, ntTwo, ntThree, ntFour, ntFive, ntSix, ntSeven, ntEight, ntNine);
  TNumberTypes = set of TNumberType;
  TIndexFlag = (ifA, ifB, ifC, ifD, ifE, ifF, ifG, ifH, ifI, ifJ);
  TIndexFlags = set of TIndexFlag;

const
  GreaterThanOrEqual = [EqualsValue, GreaterThanValue];

  NumberChar: array[TNumberType] of Char = '0123456789';
  IndexChar: array[TIndexFlag] of Char = 'ABCDEFGHIJ';

  AIndex = Ord(ifA);
  BIndex = Ord(ifB);
  CIndex = Ord(ifC);
  DIndex = Ord(ifD);
  EIndex = Ord(ifE);
  FIndex = Ord(ifF);
  GIndex = Ord(ifG);
  HIndex = Ord(ifH);
  IIndex = Ord(ifI);
  JIndex = Ord(ifJ);

  Zero = Ord(ntZero);
  One = Ord(ntOne);
  Two = Ord(ntTwo);
  Three = Ord(ntThree);
  Four = Ord(ntFour);
  Five = Ord(ntFive);
  Six = Ord(ntSix);
  Seven = Ord(ntSeven);
  Eight = Ord(ntEight);
  Nine = Ord(ntNine);

  Kilobyte = 1024;
  Megabyte = Kilobyte * Kilobyte;
  Gigabyte = Kilobyte * Megabyte;

const
  Signs: TSysCharSet = [Minus, Plus];
  Digits: TSysCharSet = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

function Number(const Text: string): Boolean;

implementation

{$IFNDEF UNICODE}
uses
  TextUtils;
{$ENDIF}

function Number(const Text: string): Boolean;
var
  I: Integer;
begin
  Result := Text <> '';
  if Result then
    for I := 1 to Length(Text) do
    begin
      Result := CharInSet(Text[I], Digits);
      if not Result then Break;
    end;
end;

end.
