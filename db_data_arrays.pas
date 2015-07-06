{$INCLUDE settings}
unit db_data_arrays;

{$mode objfpc}{$H+}

interface

uses
  db_basicthings;

{****f* db_data_arrays/get_teacher
 *  SYNOPSIS
 *    get_teacher(id : integer) : TTeacherRecord;
 *  DESCRIPTION
 *    Gets teacher from storage.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_teacher(id : integer) : TTeacherRecord;
{****f* db_data_arrays/get_classroom
 *  SYNOPSIS
 *    get_classroom(id : integer) : TClassroomRecord;
 *  DESCRIPTION
 *    Gets classroom from storage.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_classroom(id : integer) : TClassroomRecord;
{****f* db_data_arrays/get_entry
 *  SYNOPSIS
 *    get_entry(id : integer) : TTTEntryRecord;
 *  DESCRIPTION
 *    Gets timetable entry from storage.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_entry(id : integer) : TTTEntryRecord;

{****f* db_data_arrays/set_teacher
 *  SYNOPSIS
 *    set_teacher(name_, surname_, patronymic_ : ShortString; id : integer = -1) : integer;
 *  DESCRIPTION
 *    Edit item info or add new teacher into storage.
 *  ARGUMENTS
 *    name_ : ShortString       - teacher name;
 *    surname_ : ShortString    - teacher surname;
 *    patronymic_ : ShortString - teacher patronymic (second name);
 *    id : integer = -1         - left this empty to add new teacher or
 *                                pass item identificator to reset info.
 ******}
function set_teacher(name_, surname_, patronymic_ : ShortString; id : integer = -1) : integer;
{****f* db_data_arrays/set_classroom
 *  SYNOPSIS
 *    set_classroom(number_ : ShortString; workplaces_ : Integer; projector_  : boolean; id : integer = -1) : integer;
 *  DESCRIPTION
 *    Edit item info or add new classroom into storage.
 *  ARGUMENTS
 *    number_ : ShortString - classroom number(label);
 *    workplaces_ : Integer - number of workplaces;
 *    projector_  : boolean - is classroom equipped with a projector;
 *    id : integer = -1     - left this empty to add new classroom or
 *                            pass item identificator to reset info.
 ******}
function set_classroom(number_ : ShortString; workplaces_ : Integer; projector_  : boolean; id : integer = -1) : integer;
{****f* db_data_arrays/set_entry
 *  SYNOPSIS
 *    set_entry(startTime_, endTime_ : TDateTime; teacher_id, classroom_id : integer; id : integer = -1) : integer;
 *  DESCRIPTION
 *    Edit item info or add new timetable entry into storage.
 *  ARGUMENTS
 *    startTime_ : TDateTime - lesson start date and time;
 *    endTime_ : TDateTime   - lesson end time;
 *    teacher_id : integer   - linked teacher identificator;
 *    classroom_id : integer - linked classroom identificator;
 *    id : integer = -1      - left this empty to add new timetable entry or
 *                             pass item identificator to reset info.
 ******}
function set_entry(startTime_, endTime_ : TDateTime; teacher_id, classroom_id : integer; id : integer = -1) : integer;

{****f* db_data_arrays/del_teacher
 *  SYNOPSIS
 *    del_teacher(id : integer) : Boolean;
 *  DESCRIPTION
 *    Remove teacher from storage.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function del_teacher(id : integer) : Boolean;
{****f* db_data_arrays/del_classroom
 *  SYNOPSIS
 *    del_classroom(id : integer) : Boolean;
 *  DESCRIPTION
 *    Remove classroom from storage.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function del_classroom(id : integer) : Boolean;
{****f* db_data_arrays/del_entry
 *  SYNOPSIS
 *    del_entry(id : integer) : Boolean;
 *  DESCRIPTION
 *    Remove timetable entry from storage.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function del_entry(id : integer) : Boolean;

{****f* db_data_arrays/getTeachersCount
 *  SYNOPSIS
 *    getTeachersCount : integer;
 *  DESCRIPTION
 *    Number of teachers currently in storage.
 ******}
function getTeachersCount : integer;
{****f* db_data_arrays/getClassroomsCount
 *  SYNOPSIS
 *    getClassroomsCount : integer;
 *  DESCRIPTION
 *    Number of classrooms currently in storage.
 ******}
function getClassroomsCount : integer;
{****f* db_data_arrays/getEntriesCount
 *  SYNOPSIS
 *    getEntriesCount : integer;
 *  DESCRIPTION
 *    Number of timetable entries currently in storage.
 ******}
function getEntriesCount : integer;

{****f* db_data_arrays/is_teacher_linked
 *  SYNOPSIS
 *    is_teacher_linked(tchr_id : integer) : boolean;
 *  DESCRIPTION
 *    Checking if there are entries linked to this teacher. It's good to check
 *    this before removing item from database.
 *  ARGUMENTS
 *    tchr_id : integer - item identificator.
 ******}
function is_teacher_linked(tchr_id : integer) : boolean;
{****f* db_data_arrays/is_classroom_linked
 *  SYNOPSIS
 *    is_classroom_linked(room_id : integer) : boolean;
 *  DESCRIPTION
 *    Checking if there are entries linked to this classroom. It's good to check
 *    this before removing item from database.
 *  ARGUMENTS
 *    room_id : integer - item identificator.
 ******}
function is_classroom_linked(room_id : integer) : boolean;

{****f* db_data_arrays/swap_teachers
 *  SYNOPSIS
 *    swap_teachers(id1, id2 : integer);
 *  DESCRIPTION
 *    Change indexes between teachers #id1 and #id2. Basic bubblesort operation.
 *    For proper working in list mode id2 should be (id1 + 1).
 *  ARGUMENTS
 *    id1 : integer - first item index to swap;
 *    id2 : integer - second item index to swap.
 ******}
procedure swap_teachers(id1, id2 : integer);
{****f* db_data_arrays/swap_classrooms
 *  SYNOPSIS
 *    swap_classrooms(id1, id2 : integer);
 *  DESCRIPTION
 *    Change indexes between classrooms #id1 and #id2. Basic bubblesort operation.
 *    For proper working in list mode id2 should be (id1 + 1).
 *  ARGUMENTS
 *    id1 : integer - first item index to swap;
 *    id2 : integer - second item index to swap.
 ******}
procedure swap_classrooms(id1, id2 : integer);
{****f* db_data_arrays/swap_entries
 *  SYNOPSIS
 *    swap_entries(id1, id2 : integer);
 *  DESCRIPTION
 *    Change indexes between timetable entries #id1 and #id2. Basic bubblesort
 *    operation. For proper working in list mode id2 should be (id1 + 1).
 *  ARGUMENTS
 *    id1 : integer - first item index to swap;
 *    id2 : integer - second item index to swap.
 ******}
procedure swap_entries(id1, id2 : integer);

{****f* db_data_arrays/clean_teachers
 *  SYNOPSIS
 *    clean_teachers;
 *  DESCRIPTION
 *    Remove all teachers from storage.
 ******}
procedure clean_teachers;
{****f* db_data_arrays/clean_classrooms
 *  SYNOPSIS
 *    clean_classrooms;
 *  DESCRIPTION
 *    Remove all classrooms from storage.
 ******}
procedure clean_classrooms;
{****f* db_data_arrays/clean_entries
 *  SYNOPSIS
 *    clean_entries;
 *  DESCRIPTION
 *    Remove all timetable entries from storage.
 ******}
procedure clean_entries;

implementation

uses
  Classes, SysUtils;

type
  TObjectWithId = class
    private
      _id : integer;
    public
      property id : integer read _id write _id;
  end;
  TTeacher = class(TObjectWithId)
    private
      _name       : ShortString;
      _surname    : ShortString;
      _patronymic : ShortString;
    public
      property Name : ShortString read _name write _name;
      property Surname : ShortString read _surname write _surname;
      property Patronymic : ShortString read _patronymic write _patronymic;
      constructor Create(name_, surname_, patronymic_ : ShortString; id_ : integer);
  end;
  TClassroom = class(TObjectWithId)
    private
      _number     : ShortString;
      _workplaces : Integer;
      _projector  : boolean;
    public
      property Number : ShortString read _number write _number;
      property Workplaces : Integer read _workplaces write _workplaces;
      property HasProjector : Boolean read _projector write _projector;
      constructor Create(number_ : ShortString;
                         workplaces_ : Integer;
                         projector_  : boolean;
                         id_ : integer);
  end;
  TTTEntry = class(TObjectWithId)
    private
      _startTime : TDateTime;
      _endTime   : TDateTime;
      _teacher   : TTeacher;
      _classroom : TClassroom;
    public
      property StartTime : TDateTime read _startTime write _startTime;
      property EndTime : TDateTime read _endTime write _endTime;
      property Teacher : TTeacher read _teacher write _teacher;
      property Classroom : TClassroom read _classroom write _classroom;
      constructor Create(startTime_, endTime_ : TDateTime;
                         teacher_ : TTeacher; classroom_ : TClassroom;
                         id_ : integer);
  end;

constructor TTeacher.Create(name_, surname_, patronymic_ : ShortString; id_ : integer);
begin
  _name       := name_;
  _surname    := surname_;
  _patronymic := patronymic_;
  _id         := id_;
end;
constructor TClassroom.Create(number_ : ShortString; workplaces_ : Integer; projector_  : boolean; id_ : integer);
begin
  _number     := number_;
  _workplaces := workplaces_;
  _projector  := projector_;
  _id         := id_;
end;
constructor TTTEntry.Create(startTime_, endTime_ : TDateTime; teacher_ : TTeacher; classroom_ : TClassroom; id_ : integer);
begin
  _startTime := startTime_;
  _endTime   := endTime_;
  _teacher   := teacher_;
  _classroom := classroom_;
  _id        := id_;
end;

var
  teachers   : array of TTeacher;
  classrooms : array of TClassroom;
  entries    : array of TTTEntry;

function get_teacher(id : integer) : TTeacherRecord;
begin
  Result.name       := teachers[id].Name;
  Result.surname    := teachers[id].Surname;
  Result.patronymic := teachers[id].Patronymic;
end;
function get_classroom(id : integer) : TClassroomRecord;
begin
  Result.number        := classrooms[id].Number;
  Result.has_projector := classrooms[id].HasProjector;
  Result.workplaces    := classrooms[id].Workplaces;
end;
function get_entry(id : integer) : TTTEntryRecord;
begin
  Result.startTime    := entries[id].StartTime;
  Result.endTime      := entries[id].EndTime;
  Result.teacher_id   := entries[id].Teacher.id;
  Result.classroom_id := entries[id].Classroom.id;
end;

function set_teacher(name_, surname_, patronymic_ : ShortString; id : integer = -1) : integer;
begin
  if (Length(teachers) <> 0) and ((id >= 0) and (id <= High(teachers))) then
    with teachers[id] do
    begin
      Name       := name_;
      Surname    := surname_;
      Patronymic := patronymic_;
    end
  else
  begin
    id := Length(teachers);
    SetLength(teachers, Length(teachers) + 1);
    teachers[id] := TTeacher.Create(name_, surname_, patronymic_, id);
  end;
  Result := id;
end;
function set_classroom(number_ : ShortString; workplaces_ : Integer; projector_  : boolean; id : integer = -1) : integer;
begin
  if (Length(classrooms) <> 0) and ((id >= 0) and (id <= High(classrooms))) then
    with classrooms[id] do
    begin
      Number       := number_;
      Workplaces   := workplaces_;
      HasProjector := projector_;
    end
  else
  begin
    id := Length(classrooms);
    SetLength(classrooms, Length(classrooms) + 1);
    classrooms[id] := TClassroom.Create(number_, workplaces_, projector_, id);
  end;
  Result := id;
end;
function set_entry(startTime_, endTime_ : TDateTime; teacher_id, classroom_id : integer; id : integer = -1) : integer;
begin
  if (Length(entries) <> 0) and ((id >= 0) and (id <= High(entries))) then
    with entries[id] do
    begin
      StartTime := startTime_;
      EndTime   := endTime_;
      Teacher   := teachers[teacher_id];
      Classroom := classrooms[classroom_id];
    end
  else
  begin
    id := Length(entries);
    SetLength(entries, Length(entries) + 1);
    entries[id] := TTTEntry.Create(startTime_, endTime_, teachers[teacher_id], classrooms[classroom_id], id);
  end;
  Result := id;
end;

function del_teacher(id : integer) : Boolean;
var
  i : integer;
begin
  if (id in [0..High(teachers)]) and (Length(teachers) > 0) then
  begin
    Result := true;
    for i := id to High(teachers) do teachers[i] := teachers[i + 1];
    SetLength(teachers, Length(teachers) - 1);
    for i := 0  to High(teachers) do teachers[i].id := i;
  end
  else
    Result := false;
end;
function del_classroom(id : integer) : Boolean;
var
  i : integer;
begin
  if (id in [0..High(classrooms)]) and (Length(classrooms) > 0) then
  begin
    Result := true;
    for i := id to High(classrooms) do classrooms[i] := classrooms[i + 1];
    SetLength(classrooms, Length(classrooms) - 1);
    for i := 0  to High(classrooms) do classrooms[i].id := i;
  end
  else
    Result := false;
end;
function del_entry(id : integer) : Boolean;
var
  i : integer;
begin
  if (id in [0..High(entries)]) and (Length(entries) > 0) then
  begin
    Result := true;
    for i := id to High(entries) do entries[i] := entries[i + 1];
    SetLength(entries, Length(entries) - 1);
    for i := 0  to High(entries) do entries[i].id := i;
  end
  else
    Result := false;
end;

function getTeachersCount : integer;
begin
  Result := Length(teachers);
end;
function getClassroomsCount : integer;
begin
  Result := Length(classrooms);
end;
function getEntriesCount : integer;
begin
  Result := Length(entries);
end;

function is_teacher_linked(tchr_id : integer) : boolean;
var
  i : integer;
begin
  Result := false;
  for i := 0 to High(entries) do if entries[i].Teacher.id = tchr_id then Result := true;
end;
function is_classroom_linked(room_id : integer) : boolean;
var
  i : integer;
begin
  Result := false;
  for i := 0 to High(entries) do if entries[i].Classroom.id = room_id then Result := true;
end;

procedure swap_teachers(id1, id2 : integer);
var
  temporary : TTeacher;
  i : integer;
begin
  i := teachers[id1].id;
  teachers[id1].id := teachers[id2].id;
  teachers[id2].id := i;

  temporary := teachers[id1];
  teachers[id1] := teachers[id2];
  teachers[id2] := temporary;
end;
procedure swap_classrooms(id1, id2 : integer);
var
  temporary : TClassroom;
  i : integer;
begin
  i := classrooms[id1].id;
  classrooms[id1].id := classrooms[id2].id;
  classrooms[id2].id := i;

  temporary := classrooms[id1];
  classrooms[id1] := classrooms[id2];
  classrooms[id2] := temporary;
end;
procedure swap_entries(id1, id2 : integer);
var
  temporary : TTTEntry;
begin
  temporary := entries[id1];
  entries[id1] := entries[id2];
  entries[id2] := temporary;
end;

procedure clean_teachers;
var
  i : integer;
begin
  for i := 0 to High(teachers) do teachers[i].Free;
  SetLength(teachers, 0);
end;
procedure clean_classrooms;
var
  i : integer;
begin
  for i := 0 to High(classrooms) do classrooms[i].Free;
  SetLength(classrooms, 0);
end;
procedure clean_entries;
var
  i : integer;
begin
  for i := 0 to High(entries) do entries[i].Free;
  SetLength(entries, 0);
end;

end.

