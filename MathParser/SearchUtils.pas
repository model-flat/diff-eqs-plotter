{ *********************************************************************** }
{                                                                         }
{ SearchUtils                                                             }
{                                                                         }
{ Copyright (c) 2003-2004 Pisarev Yuriy (mail@pisarev.net)                }
{                                                                         }
{ *********************************************************************** }

unit SearchUtils;

{$B-}

interface

uses
  Windows, SysUtils, Classes, Types;

type
  TDriveType = (dtUnknown, dtNoDrive, dtFloppy, dtFixed, dtNetwork, dtCDROM, dtRAM);
  TDriveTypes = set of TDriveType;

const
  AnyFile = '*.*';

function GetDriveArray(const DriveTypes: TDriveTypes): TStringDynArray;

function Search(const Target: string; const FileList: TStrings; const SubFolder: Boolean = False;
  const FolderList: TStrings = nil; const IncludeApplication: Boolean = False;
  const Lock: PRTLCriticalSection = nil): Boolean;

implementation

uses
  MemoryUtils, TextConsts, TextUtils, ThreadUtils;

function GetDriveArray(const DriveTypes: TDriveTypes): TStringDynArray;
const
  DriveCount = 26;
  CharOffset = Ord('a');
  NameSuffix = ':\';
var
  Drives: set of 0..DriveCount - 1;
  Drive: Integer;
  DriveName: string;
begin
  Integer(Drives) := GetLogicalDrives;
  for Drive := 0 to DriveCount - 1 do
    if Drive in Drives then
    begin
      DriveName := Char(Drive + CharOffset) + NameSuffix;
      if TDriveType(GetDriveType(PChar(DriveName))) in DriveTypes then
        Add(Result, DriveName);
    end;
end;

function Search(const Target: string; const FileList: TStrings; const SubFolder: Boolean;
  const FolderList: TStrings; const IncludeApplication: Boolean;
  const Lock: PRTLCriticalSection): Boolean;
const
  Current = '.';
  Parent = '..';
var
  ApplicationFileName, S, Prefix, Suffix, Folder, FileName: string;
  F: TSearchRec;
  Flag: Boolean;

  procedure Add(const FileName: string);
  begin
    if Assigned(Lock) then
    begin
      Enter(Lock^);
      try
        FileList.Add(FileName);
      finally
        Leave(Lock^);
      end;
    end
    else FileList.Add(FileName);
  end;

begin
  ApplicationFileName := ParamStr(0);
  S := ExtractFileName(Target);
  Prefix := Extract(S, Dot, 0);
  Suffix := Extract(S, Dot, SubTextCount(Target, Dot));
  S := ExtractFilePath(Target) + AnyFile;
  try
    if FindFirst(S, faAnyFile, F) = 0 then
    begin
      Folder := ExtractFilePath(S);
      repeat
        FileName := Folder + F.Name;
        Flag := F.Attr and faDirectory = 0;
        if Flag and ((Prefix = '') or TextUtils.SameText(Prefix, Extract(F.Name, Dot, 0))) and
          ((Suffix = '') or TextUtils.SameText(Suffix, Extract(F.Name, Dot, SubTextCount(F.Name, Dot)))) and
          (IncludeApplication or not TextUtils.SameText(ApplicationFileName, FileName)) then
            Add(FileName);
        if not Flag and SubFolder and not TextUtils.SameText(F.Name, Current) and
          not TextUtils.SameText(F.Name, Parent) then
          begin
            Search(IncludeTrailingPathDelimiter(FileName) + ExtractFileName(Target),
              FileList, SubFolder, FolderList, IncludeApplication, Lock);
            if Assigned(FolderList) then Add(FileName);
          end;
      until FindNext(F) <> 0;
    end;
  finally
    FindClose(F);
  end;
  Result := FileList.Count > 0;
end;

end.
