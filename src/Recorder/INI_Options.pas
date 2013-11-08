unit INI_Options;

interface
uses Windows, SysUtils, IniFiles;

type
 TIniSettings = record
   modid: integer;
   demosprefix: string;
   name: string;
   regname : string;
   version: string;
   weaponidpatch: boolean;
   unitlimit: integer;
 end;

 function GetINIFileName: string;
 function ReadINISettings: boolean;
 function fnRemoveInvalidChar(const sString: string) : String;
var iniSettings: TIniSettings;

const
  INIFILENAME_MAXLENGTH = 12;

implementation
uses COB_extensions, TADemoConsts,
  PluginEngine,
  ErrorLog_ExtraData,
  Thread_marshaller,
  UnitLimit, ModsList, idplay;

function fnRemoveInvalidChar(const sString: string) : String;
var
  sInvalidCharacters : array [1..10] of String;
  iIndex : Integer;
  sNewCharacter : String;
begin
  sNewCharacter := '';
  sInvalidCharacters[1] := ':';
  sInvalidCharacters[2] := '/';
  sInvalidCharacters[3] := '*';
  sInvalidCharacters[4] := '\';
  sInvalidCharacters[5] := '?';
  sInvalidCharacters[6] := '>';
  sInvalidCharacters[7] := '<';
  sInvalidCharacters[8] := '|';
  sInvalidCharacters[9] := '&';
  sInvalidCharacters[10] := '"';

  Result := sString;

  for iIndex := 1 to Length(sInvalidCharacters) do
  begin
    Result := StringReplace(Result, sInvalidCharacters[iIndex], sNewCharacter, [rfReplaceAll]);
  end;
end;

// read INI file name from TA's memory
var
  iniFileName_cache : string;
function GetINIFileName: string;
var
 tadir: string;
 iniName: string;
 address: Cardinal;
 buffer: array of Byte;
 i: Byte;
begin
if iniFileName_cache = '' then
begin
  Result:= #0;
  tadir:= IncludeTrailingPathDelimiter(ExtractFilePath(SelfLocation));
  address:= $5098A3;
  try
    SetLength(buffer, INIFILENAME_MAXLENGTH + 1);
    for i := 0 to INIFILENAME_MAXLENGTH do
      begin
        buffer[i]:= PByte(address)^;
        Inc(address);
      end;
    SetString(ininame, PAnsiChar(@Buffer[0]), INIFILENAME_MAXLENGTH);
    Trim(ininame);
    if FileExists(tadir + ininame) then
        iniFileName_cache:= tadir + iniName
        else iniFileName_cache:= #0;
    result:= iniFileName_cache;
  except
    //shouldn't fail, however ...
    if FileExists(tadir + 'totala.ini') then
      iniFileName_cache:= tadir + 'totala.ini' else iniFileName_cache:= #0;
    result:= iniFileName_cache;
  end;
end else
  result:= iniFileName_cache;
end;

function ReadINISettings: boolean;
var
  iniFile: TIniFile;
  tempstring, tempstring2: string;
begin
Result:= False;

iniSettings.modid:= 0;
iniSettings.demosprefix:= '';
iniSettings.weaponidpatch:= False;
if GetINIFileName <> #0 then
  begin
    iniFile:= TIniFile.Create(GetINIFileName);
    try
      iniSettings.modid:= iniFile.ReadInteger('MOD','ID', -1);
      iniSettings.name:= iniFile.ReadString('MOD','Name', '');
      iniSettings.version:= iniFile.ReadString('MOD','Version', '');
      iniSettings.demosprefix:= iniFile.ReadString('MOD','DemosFileNamePrefix', '');

      tempstring:= Trim(iniFile.ReadString('Preferences','WeaponType', '256;'));
      tempstring:= Copy(tempstring, 1, Length(tempstring) - 1);

      tempstring2:= Trim(iniFile.ReadString('Preferences','MultiGameWeapon', 'FALSE;'));
      tempstring2:= Copy(tempstring2, 1, Length(tempstring2) - 1);

      iniSettings.weaponidpatch:= (StrToInt(tempstring) > 256) and (tempstring2 = 'TRUE');

      tempstring:= Trim(iniFile.ReadString('Preferences','UnitLimit', '1500;'));
      tempstring:= Copy(tempstring, 1, Length(tempstring) - 1);
      iniSettings.unitlimit:= StrToInt(tempstring);
    finally
      Result:= True;
      iniFile.Free;
    end;
  end;
end;

end.
 