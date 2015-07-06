{$INCLUDE settings}
unit db_filework;

{$mode objfpc}{$H+}

interface

uses
  {$IfDef ARRAY_MODE}
  db_data_arrays,
  {$Else}
  db_data_lists,
  {$EndIf}
  Classes,
  SysUtils,
  db_basicthings;

{****f* db_filework/save_typed
 *  SYNOPSIS
 *    save_typed(filename : string) : integer;
 *  DESCRIPTION
 *    Saves database to typed files.
 *  ARGUMENTS
 *    filename : string - file name.
 *  RESULT
 *    Returns errors info. 0 = no errors.
 *  NOTES
 *    Filename is a name for 3 files:
 *    [filename].tchrs - TTeacherRecord typed file;
 *    [filename].rooms - TClassroomRecord typed file;
 *    [filename].entrs - TTTEntryRecord typed file.
 ******}
function save_typed(filename : string) : integer;
{****f* db_filework/load_typed
 *  SYNOPSIS
 *    load_typed(filename : string) : integer;
 *  DESCRIPTION
 *    Loads database from typed files.
 *  ARGUMENTS
 *    filename : string - file name.
 *  RESULT
 *    Returns errors info. 0 = no errors.
 *  NOTES
 *    Filename is a name for 3 files:
 *    [filename].tchrs - TTeacherRecord typed file;
 *    [filename].rooms - TClassroomRecord typed file;
 *    [filename].entrs - TTTEntryRecord typed file.
 ******}
function load_typed(filename : string) : integer;

{****f* db_filework/save_untyped
 *  SYNOPSIS
 *    save_untyped(filename : string) : integer;
 *  DESCRIPTION
 *    Saves database to untyped file.
 *  ARGUMENTS
 *    filename : string - file name.
 *  RESULT
 *    Returns errors info. 0 = no errors.
 ******}
function save_untyped(filename : string) : integer;
{****f* db_filework/load_untyped
 *  SYNOPSIS
 *    load_untyped(filename : string) : integer;
 *  DESCRIPTION
 *    Loads database from untyped file.
 *  ARGUMENTS
 *    filename : string - file name.
 *  RESULT
 *    Returns errors info. 0 = no errors.
 ******}
function load_untyped(filename : string) : integer;

implementation

function save_typed(filename : string) : integer;
var
  t_file  : file of TTeacherRecord;
  c_file  : file of TClassroomRecord;
  e_file  : file of TTTEntryRecord;
  _result : integer;
procedure save_teachers;
var
  tmp : TTeacherRecord;
  i : integer;
begin
  AssignFile(t_file, filename + '.tchrs');

  {$I-}Rewrite(t_file);{$I+}

  _result := IOResult;

  i := 0;
  while (_result = 0) and (i < getTeachersCount) do
  begin
    tmp := get_teacher(i);
    {$I-}Write(t_file, tmp);{$I+}
    _result :=  IOResult;
    inc(i);
  end;

  if _result = 0 then Close(t_file);
end;
procedure save_classrooms;
var
  tmp : TClassroomRecord;
  i : integer;
begin
  AssignFile(c_file, filename + '.rooms');

  {$I-}Rewrite(c_file);{$I+}

  _result := IOResult;

  i := 0;
  while (_result = 0) and (i < getClassroomsCount) do
  begin
    tmp := get_classroom(i);
    {$I-}Write(c_file, tmp);{$I+}
    _result :=  IOResult;
    inc(i);
  end;

  Close(c_file);
end;
procedure save_entry;
var
  tmp : TTTEntryRecord;
  i : integer;
begin
  AssignFile(e_file, filename + '.entrs');

  {$I-}Rewrite(e_file);{$I+}

  _result := IOResult;

  i := 0;
  while (_result = 0) and (i < getEntriesCount) do
  begin
    tmp := get_entry(i);
    {$I-}Write(e_file, tmp);{$I+}
    _result :=  IOResult;
    inc(i);
  end;

  Close(e_file);
end;
begin
  save_teachers;
  save_classrooms;
  save_entry;

  Result := _result;
end;
function load_typed(filename : string) : integer;
var
  t_file  : file of TTeacherRecord;
  c_file  : file of TClassroomRecord;
  e_file  : file of TTTEntryRecord;
  _result : integer;
procedure load_teachers;
var
  tmp : TTeacherRecord;
begin
  AssignFile(t_file, filename + '.tchrs');

  {$I-}Reset(t_file);{$I+}

  _result := IOResult;

  while (_result = 0) and not EOF(t_file) do
  begin
    {$I-}Read(t_file, tmp);{$I+}
    _result :=  IOResult;
    if _result = 0 then set_teacher(tmp.name, tmp.surname, tmp.patronymic);
  end;

  if _result = 0 then Close(t_file);
end;
procedure load_classrooms;
var
  tmp : TClassroomRecord;
begin
  AssignFile(c_file, filename + '.rooms');

  {$I-}Reset(c_file);{$I+}

  _result := IOResult;

  while (_result = 0) and not EOF(c_file) do
  begin
    {$I-}Read(c_file, tmp);{$I+}
    _result :=  IOResult;
    if _result = 0 then set_classroom(tmp.number, tmp.workplaces, tmp.has_projector);
  end;

  if _result = 0 then Close(c_file);
end;
procedure load_entries;
var
  tmp : TTTEntryRecord;
begin
  AssignFile(e_file, filename + '.entrs');

  {$I-}Reset(e_file);{$I+}

  _result := IOResult;

  while (_result = 0) and not EOF(e_file) do
  begin
    {$I-}Read(e_file, tmp);{$I+}
    _result :=  IOResult;
    if _result = 0 then set_entry(tmp.startTime, tmp.endTime, tmp.teacher_id, tmp.classroom_id);
  end;

  if _result = 0 then Close(e_file);
end;
begin
  clean_teachers;
  clean_classrooms;
  clean_entries;
  load_teachers;
  load_classrooms;
  load_entries;

  Result := _result;
end;

function save_untyped(filename : string) : integer;
var
  f : file;
  _result : integer;
  count_tchrs, count_rooms, count_entrs : integer;

procedure write_string(s : string);
var
  i : integer;
begin
  i := Length(s);
  if _result = 0 then {$I-}BlockWrite(f, i, SizeOf(i));{$I+}
  _result := IOResult;
  for i := 1 to Length(s) do
    if _result = 0 then
    begin
      {$I-}BlockWrite(f, s[i], SizeOf(s[i]));{$I+}
      _result := IOResult;
    end;
end;
procedure save_teachers;
var
  i : integer;
begin
  for i := 0 to count_tchrs - 1 do
    with get_teacher(i) do
    begin
      write_string(name);
      write_string(surname);
      write_string(patronymic);
    end;
end;
procedure save_classrooms;
var
  c : char;
  i : integer;
begin
  for i := 0 to count_rooms - 1 do
    with get_classroom(i) do
    begin
      write_string(number);
      if _result = 0 then {$I-}BlockWrite(f, workplaces, SizeOf(workplaces));{$I+}
      _result := IOResult;
      if has_projector then c := 'y' else c := 'n';
      if _result = 0 then {$I-}BlockWrite(f, c, SizeOf(c));{$I+}
      _result := IOResult;
    end;
end;
procedure save_entries;
var
  i : integer;
begin
  for i := 0 to count_entrs - 1 do
    with get_entry(i) do
    begin
      if _result = 0 then {$I-}BlockWrite(f, startTime, SizeOf(startTime));{$I+}
      _result := IOResult;
      if _result = 0 then {$I-}BlockWrite(f, endTime, SizeOf(endTime));{$I+}
      _result := IOResult;
      if _result = 0 then {$I-}BlockWrite(f, teacher_id, SizeOf(teacher_id));{$I+}
      _result := IOResult;
      if _result = 0 then {$I-}BlockWrite(f, classroom_id, SizeOf(classroom_id));{$I+}
      _result := IOResult;
    end;
end;

begin
  AssignFile(f, filename);

  {$I-}Rewrite(f, 1);{$I+}
  _result := IOResult;

  count_tchrs := getTeachersCount;
  count_rooms := getClassroomsCount;
  count_entrs := getEntriesCount;

  if _result = 0 then
  begin
    {$I-}BlockWrite(f, count_tchrs, SizeOf(count_tchrs));{$I+}
    {$I-}BlockWrite(f, count_rooms, SizeOf(count_rooms));{$I+}
    {$I-}BlockWrite(f, count_entrs, SizeOf(count_entrs));{$I+}
    _result := IOResult;
  end;

  if _result = 0 then
  begin
    save_teachers;
    save_classrooms;
    save_entries;
  end;

  if _result = 0 then Close(f);
  Result := _result;
end;
function load_untyped(filename : string) : integer;
var
  f : file;
  _result : integer;
  count_tchrs, count_rooms, count_entrs : integer;

function read_string : string;
var
  i, len : integer;
  c : char;
begin
  Result := '';
  len := 0;
  if _result = 0 then {$I-}BlockRead(f, len, SizeOf(len));{$I+}
  _result := IOResult;
  for i := 1 to len do
    if _result = 0 then
    begin
      c := #0;
      {$I-}BlockRead(f, c, SizeOf(c));{$I+}
      Result := Result + c;
      _result := IOResult;
    end;
end;
procedure load_teachers;
var
  i : integer;
  nam, sur, pat : string;
begin
  for i := 0 to count_tchrs - 1 do
  begin
    nam := read_string;
    sur := read_string;
    pat := read_string;
    set_teacher(nam, sur, pat);
  end;
end;
procedure load_classrooms;
var
  i : integer;
  num : string;
  plc : integer;
  c   : char;
begin
  for i := 0 to count_rooms - 1 do
  begin
    num := read_string;
    plc := 0;
    if _result = 0 then {$I-}BlockRead(f, plc, SizeOf(plc));{$I+}
    _result := IOResult;
    c := #0;
    if _result = 0 then {$I-}BlockRead(f, c, SizeOf(c));{$I+}
    _result := IOResult;
    set_classroom(num, plc, c = 'y');
  end;
end;
procedure load_entries;
var
  i : integer;
  sTime, eTime : TDateTime;
  t_id, c_id : integer;
begin
  sTime := 0;
  eTime := 0;
  t_id  := 0;
  c_id  := 0;
  for i := 0 to count_entrs - 1 do
  begin
    if _result = 0 then {$I-}BlockRead(f, sTime, SizeOf(sTime));{$I+}
    _result := IOResult;
    if _result = 0 then {$I-}BlockRead(f, eTime, SizeOf(eTime));{$I+}
    _result := IOResult;
    if _result = 0 then {$I-}BlockRead(f, t_id, SizeOf(t_id));{$I+}
    _result := IOResult;
    if _result = 0 then {$I-}BlockRead(f, c_id, SizeOf(c_id));{$I+}
    _result := IOResult;
    set_entry(sTime, eTime, t_id, c_id);
  end;
end;

begin
  clean_teachers;
  clean_classrooms;
  clean_entries;

  AssignFile(f, filename);

  {$I-}Reset(f, 1);{$I+}
  _result := IOResult;

  count_tchrs := 0;
  count_rooms := 0;
  count_entrs := 0;

  if _result = 0 then
  begin
    {$I-}BlockRead(f, count_tchrs, SizeOf(count_tchrs));{$I+}
    {$I-}BlockRead(f, count_rooms, SizeOf(count_rooms));{$I+}
    {$I-}BlockRead(f, count_entrs, SizeOf(count_entrs));{$I+}
    _result := IOResult;
  end;

  if _result = 0 then
  begin
    load_teachers;
    load_classrooms;
    load_entries;
  end;

  if _result = 0 then Close(f);
  Result := _result;
end;

end.

