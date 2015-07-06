{$INCLUDE settings}
unit db_basicthings;

{$mode objfpc}{$H+}

interface

uses
  Crt, Classes, SysUtils, db_constants;

type
  {****s* db_basicthings/TPosition
   *  DESCRIPTION
   *    Here we store position of windows and components.
   *  SOURCE
   *}
  TPosition = record
    X : Integer;
    Y : Integer;
  end;
  {******}
  {****s* db_basicthings/TSize
   *  DESCRIPTION
   *    Here we store size of windows and components.
   *  SOURCE
   *}
  TSize = record
    W : integer;
    H : integer;
  end;
  {******}
  {****s* db_basicthings/TSortOrder
   *  DESCRIPTION
   *    Sorting order setting structure.
   *  SOURCE
   *}
  TSortOrder = (or_ascend, or_descend);
  {******}
  {****s* db_basicthings/TBounds
   *  DESCRIPTION
   *    Array of left offset, top offset, width and height.
   *  SOURCE
   *}
  TBounds = array[0..3] of integer;
  {******}
  {****s* db_basicthings/TAlign
   *  DESCRIPTION
   *    Align setting structure.
   *  SOURCE
   *}
  TAlign = (al_right, al_left, al_center);
  {******}
  {****s* db_basicthings/TModalResult
   *  DESCRIPTION
   *    Window dialog results.
   *  SOURCE
   *}
  TModalResult = (mr_enter, mr_escape, mr_tab, mr_delete);
  {******}
  {****s* db_basicthings/TTeacherRecord
   *  DESCRIPTION
   *    Here we store teacher info.
   *  SOURCE
   *}
  TTeacherRecord   = record
    name       : ShortString;
    surname    : ShortString;
    patronymic : ShortString;
  end;
  {******}
  {****s* db_basicthings/TClassroomRecord
   *  DESCRIPTION
   *    Here we store classrooms info.
   *  SOURCE
   *}
  TClassroomRecord = record
    number        : ShortString;
    workplaces    : Integer;
    has_projector : boolean;
  end;
  {******}
  {****s* db_basicthings/TTTEntryRecord
   *  DESCRIPTION
   *    Here we store classrooms info.
   *  SOURCE
   *}
  TTTEntryRecord   = record
    startTime    : TDateTime;
    endTime      : TDateTime;
    teacher_id   : integer;
    classroom_id : integer;
  end;
  {******}

{****f* db_basicthings/readkey_
 *  SYNOPSIS
 *    readkey_ : TKey
 *  DESCRIPTION
 *    Waits for user to press a key and returns TKey value.
 ******}
function readkey_ : TKey;
{****f* db_basicthings/trim_
 *  SYNOPSIS
 *    trim_(text : string; count : integer; dotted : boolean = false) : string;
 *  EXAMPLE
 *    tmp := trim('A quick brown fox', 12, true); //tmp = 'A quick br..'
 *  DESCRIPTION
 *    Trims a string into a string given length/appends it with spaces to make
 *    it that length.
 *  ARGUMENTS
 *    text : string            - string line to trim/append;
 *    count : integer;         - number of symbols in output string;
 *    dotted : boolean = false - replace 2 last symbols with "..".
 ******}
function trim_(text : string; count : integer; dotted : boolean = false) : String;
{****f* db_basicthings/KeyCodeToModalResult
 *  SYNOPSIS
 *    KeyCodeToModalResult(k : TKey) : TModalResult;
 *  DESCRIPTION
 *    Converts TKey values to following TModalResult values:
 *    k_enter  - mr_enter
 *    k_escape - mr_escape
 *    k_tab    - mr_tab
 *    k_delete - mr_delete
 *  ARGUMENTS
 *    k : TKey - value to be convert into TModalResult
 ******}
function KeyCodeToModalResult(k : TKey) : TModalResult;

implementation

function readkey_ : TKey;
begin
  Result.code0 := readkey;
  if Result.code0 = #0 then
    Result.code1 := readkey
  else
    Result.code1 := #0;
end;
function trim_(text : string; count : integer; dotted : boolean = false) : String;
begin
  if Length(text) > count then
    if dotted then
      text := Copy(text, 1, count - 2) + '..'
    else
      text := Copy(text, 1, count);

  if Length(text) < count then while Length(text) <> count do text := text + ' ';

  Result := text;
end;
function KeyCodeToModalResult(k : TKey) : TModalResult;
begin
  if k = k_escape then Result := mr_escape;
  if k = k_enter  then Result := mr_enter;
  if k = k_tab    then Result := mr_tab;
  if k = k_delete then Result := mr_delete;
end;

end.

