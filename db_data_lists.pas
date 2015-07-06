unit db_data_lists;

{$mode objfpc}{$H+}

interface

uses
  db_basicthings;

{****f* db_data_lists/get_teacher
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
{****f* db_data_lists/get_classroom
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
{****f* db_data_lists/get_entry
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

{****f* db_data_lists/set_teacher
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
{****f* db_data_lists/set_classroom
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
{****f* db_data_lists/set_entry
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

{****f* db_data_lists/del_teacher
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
{****f* db_data_lists/del_classroom
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
{****f* db_data_lists/del_entry
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

{****f* db_data_lists/getTeachersCount
 *  SYNOPSIS
 *    getTeachersCount : integer;
 *  DESCRIPTION
 *    Number of teachers currently in storage.
 ******}
function getTeachersCount : integer;
{****f* db_data_lists/getClassroomsCount
 *  SYNOPSIS
 *    getClassroomsCount : integer;
 *  DESCRIPTION
 *    Number of classrooms currently in storage.
 ******}
function getClassroomsCount : integer;
{****f* db_data_lists/getEntriesCount
 *  SYNOPSIS
 *    getEntriesCount : integer;
 *  DESCRIPTION
 *    Number of timetable entries currently in storage.
 ******}
function getEntriesCount : integer;

{****f* db_data_lists/is_teacher_linked
 *  SYNOPSIS
 *    is_teacher_linked(tchr_id : integer) : boolean;
 *  DESCRIPTION
 *    Checking if there are entries linked to this teacher. It's good to check
 *    this before removing item from database.
 *  ARGUMENTS
 *    tchr_id : integer - item identificator.
 ******}
function is_teacher_linked(tchr_id : integer) : boolean;
{****f* db_data_lists/is_classroom_linked
 *  SYNOPSIS
 *    is_classroom_linked(room_id : integer) : boolean;
 *  DESCRIPTION
 *    Checking if there are entries linked to this classroom. It's good to check
 *    this before removing item from database.
 *  ARGUMENTS
 *    room_id : integer - item identificator.
 ******}
function is_classroom_linked(room_id : integer) : boolean;

{****f* db_data_lists/swap_teachers
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
{****f* db_data_lists/swap_classrooms
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
{****f* db_data_lists/swap_entries
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

{****f* db_data_lists/clean_teachers
 *  SYNOPSIS
 *    clean_teachers;
 *  DESCRIPTION
 *    Remove all teachers from storage.
 ******}
procedure clean_teachers;
{****f* db_data_lists/clean_classrooms
 *  SYNOPSIS
 *    clean_classrooms;
 *  DESCRIPTION
 *    Remove all classrooms from storage.
 ******}
procedure clean_classrooms;
{****f* db_data_lists/clean_entries
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

type
  teacher_list_item = record
    data : TTeacher;
    next : ^teacher_list_item;
    prev : ^teacher_list_item;
  end;
  classroom_list_item = record
    data : TClassroom;
    next : ^classroom_list_item;
    prev : ^classroom_list_item;
  end;
  entires_list_item = record
    data : TTTEntry;
    next : ^entires_list_item;
    prev : ^entires_list_item;
  end;

var
  count_teachers, count_classrooms, count_entries : integer;

  first_teacher   : ^teacher_list_item;
  first_classroom : ^classroom_list_item;
  first_entry     : ^entires_list_item;

  last_teacher    : ^teacher_list_item;
  last_classroom  : ^classroom_list_item;
  last_entry      : ^entires_list_item;

function get_teacher(id : integer) : TTeacherRecord;
var
  p : ^teacher_list_item;
  i : integer;
begin
  p := first_teacher;
  for i := 0 to id - 1 do p := p^.next;
  with p^.data do
  begin
    Result.name       := Name;
    Result.surname    := Surname;
    Result.patronymic := Patronymic;
  end;
end;
function get_classroom(id : integer) : TClassroomRecord;
var
  p : ^classroom_list_item;
  i : integer;
begin
  p := first_classroom;
  for i := 0 to id - 1 do p := p^.next;
  with p^.data do
  begin
    Result.number        := Number;
    Result.has_projector := HasProjector;
    Result.workplaces    := Workplaces;
  end;
end;
function get_entry(id : integer) : TTTEntryRecord;
var
  p : ^entires_list_item;
  i : integer;
begin
  p := first_entry;
  for i := 0 to id - 1 do p := p^.next;
  with p^.data do
  begin
    Result.startTime    := StartTime;
    Result.endTime      := EndTime;
    Result.teacher_id   := Teacher.id;
    Result.classroom_id := Classroom.id;
  end;
end;

function set_teacher(name_, surname_, patronymic_ : ShortString; id : integer = -1) : integer;

procedure edit;
var
  i : integer;
  p : ^teacher_list_item;
begin
  p := first_teacher;
  for i := 0 to id - 1 do p := p^.next;
  with p^.data do
  begin
    Name := name_;
    Surname := surname_;
    Patronymic := patronymic_;
  end;
end;
procedure add;
begin
  if first_teacher = nil then
  begin
    new(first_teacher);
    first_teacher^.prev := nil;
    first_teacher^.data := TTeacher.Create(name_, surname_, patronymic_, count_teachers);
    last_teacher := first_teacher;
  end
  else
  begin
    new(last_teacher^.next);
    last_teacher^.next^.data := TTeacher.Create(name_, surname_, patronymic_, count_teachers);
    last_teacher^.next^.prev := last_teacher;
    last_teacher := last_teacher^.next;
  end;
  id := count_teachers;
  inc(count_teachers);
end;

begin
  if (count_teachers <> 0) and ((id >= 0) and (id <= (count_teachers - 1))) then edit else add;
  Result := id;
end;
function set_classroom(number_ : ShortString; workplaces_ : Integer; projector_  : boolean; id : integer = -1) : integer;

procedure edit;
var
  i : integer;
  p : ^classroom_list_item;
begin
  p := first_classroom;
  for i := 0 to id - 1 do p := p^.next;
  with p^.data do
  begin
    Number := number_;
    Workplaces := workplaces_;
    HasProjector := projector_;
  end;
end;
procedure add;
begin
  if first_classroom = nil then
  begin
    new(first_classroom);
    first_classroom^.prev := nil;
    first_classroom^.data := TClassroom.Create(number_, workplaces_, projector_, count_classrooms);
    last_classroom := first_classroom;
  end
  else
  begin
    new(last_classroom^.next);
    last_classroom^.next^.data := TClassroom.Create(number_, workplaces_, projector_, count_classrooms);
    last_classroom^.next^.prev := last_classroom;
    last_classroom := last_classroom^.next;
  end;
  id := count_classrooms;
  inc(count_classrooms);
end;

begin
  if (count_classrooms <> 0) and ((id >= 0) and (id <= (count_classrooms - 1))) then edit else add;
  Result := id;
end;
function set_entry(startTime_, endTime_ : TDateTime; teacher_id, classroom_id : integer; id : integer = -1) : integer;
var
  tchr_tmp : ^teacher_list_item;
  room_tmp : ^classroom_list_item;

procedure getLinkedObjects;
var
  i : integer;
begin
  tchr_tmp := first_teacher;
  for i := 0 to teacher_id - 1 do tchr_tmp := tchr_tmp^.next;

  room_tmp := first_classroom;
  for i := 0 to classroom_id - 1 do room_tmp := room_tmp^.next;
end;
procedure edit;
var
  i : integer;
  p : ^entires_list_item;
begin
  p := first_entry;
  for i := 0 to id - 1 do p := p^.next;
  with p^.data do
  begin
    StartTime := startTime_;
    EndTime := endTime_;
    Teacher := tchr_tmp^.data;
    Classroom := room_tmp^.data;
  end;
end;
procedure add;
begin
  if first_entry = nil then
  begin
    new(first_entry);
    first_entry^.prev := nil;
    first_entry^.data := TTTEntry.Create(startTime_, endTime_, tchr_tmp^.data, room_tmp^.data, count_entries);
    last_entry := first_entry;
  end
  else
  begin
    new(last_entry^.next);
    last_entry^.next^.data := TTTEntry.Create(startTime_, endTime_, tchr_tmp^.data, room_tmp^.data, count_entries);
    last_entry^.next^.prev := last_entry;
    last_entry := last_entry^.next;
  end;
  id := count_entries;
  inc(count_entries);
end;

begin
  getLinkedObjects;
  if (count_entries <> 0) and ((id >= 0) and (id <= (count_entries - 1))) then edit else add;
  Result := id;
end;

function del_teacher(id : integer) : Boolean;
var
  p : ^teacher_list_item;
  i : integer;
begin
  if ((id >= 0) and (id <= count_teachers - 1)) and (count_teachers > 0) then
  begin
    Result := true;

    p := first_teacher;
    for i := 0 to id - 1 do p := p^.next;
    if p^.next <> nil then p^.next^.prev := p^.prev;
    if p^.prev <> nil then p^.prev^.next := p^.next;
    if p = first_teacher then first_teacher := p^.next;
    if p = last_teacher  then last_teacher  := p^.prev;
    p^.data.Free;
    Dispose(p);
    dec(count_teachers);

    p := first_teacher;
    for i := 0 to count_teachers - 1 do
    begin
      p^.data.id := i;
      p := p^.next;
    end;
  end
  else
    Result := false;
end;
function del_classroom(id : integer) : Boolean;
var
  p : ^classroom_list_item;
  i : integer;
begin
  if ((id >= 0) and (id <= count_classrooms - 1)) and (count_classrooms > 0) then
  begin
    Result := true;

    p := first_classroom;
    for i := 0 to id - 1 do p := p^.next;
    if p^.next <> nil then p^.next^.prev := p^.prev;
    if p^.prev <> nil then p^.prev^.next := p^.next;
    if p = first_classroom then first_classroom := p^.next;
    if p = last_classroom  then last_classroom  := p^.prev;
    p^.data.Free;
    Dispose(p);
    dec(count_classrooms);

    p := first_classroom;
    for i := 0 to count_classrooms - 1 do
    begin
      p^.data.id := i;
      p := p^.next;
    end;
  end
  else
    Result := false;
end;
function del_entry(id : integer) : Boolean;
var
  p : ^entires_list_item;
  i : integer;
begin
  if ((id >= 0) and (id <= count_entries - 1)) and (count_entries > 0) then
  begin
    Result := true;

    p := first_entry;
    for i := 0 to id - 1 do p := p^.next;
    if p^.next <> nil then p^.next^.prev := p^.prev;
    if p^.prev <> nil then p^.prev^.next := p^.next;
    if p = first_entry then first_entry := p^.next;
    if p = last_entry  then last_entry  := p^.prev;
    p^.data.Free;
    Dispose(p);
    dec(count_entries);

    p := first_entry;
    for i := 0 to count_entries - 1 do
    begin
      p^.data.id := i;
      p := p^.next;
    end;
  end
  else
    Result := false;
end;

function getTeachersCount : integer;   begin Result := count_teachers; end;
function getClassroomsCount : integer; begin Result := count_classrooms; end;
function getEntriesCount : integer;    begin Result := count_entries; end;

function is_teacher_linked(tchr_id : integer) : boolean;
var
  p : ^entires_list_item;
  i : integer;
begin
  Result := false;

  p := first_entry;
  for i := 0 to count_entries - 1 do
  begin
    if p^.data.Teacher.id = tchr_id then Result := true;
    p := p^.next;
  end;
end;
function is_classroom_linked(room_id : integer) : boolean;
var
  p : ^entires_list_item;
  i : integer;
begin
  Result := false;

  p := first_entry;
  for i := 0 to count_entries - 1 do
  begin
    if p^.data.Classroom.id = room_id then Result := true;
    p := p^.next;
  end;
end;

procedure swap_teachers(id1, id2 : integer);
var
  i : integer;
  p1, p2 : ^teacher_list_item;
  tmp : TTeacher;
begin
  id2 := id2; // escaping hint lol

  p1 := first_teacher;
  for i := 0 to id1 - 1 do p1 := p1^.next;
  p2 := p1^.next;

  i := p1^.data.id;
  p1^.data.id := p2^.data.id;
  p2^.data.id := i;

  tmp := p1^.data;
  p1^.data := p2^.data;
  p2^.data := tmp;
end;
procedure swap_classrooms(id1, id2 : integer);
var
  i : integer;
  p1, p2 : ^classroom_list_item;
  tmp : TClassroom;
begin
  id2 := id2; // escaping hint

  p1 := first_classroom;
  for i := 0 to id1 - 1 do p1 := p1^.next;
  p2 := p1^.next;

  i := p1^.data.id;
  p1^.data.id := p2^.data.id;
  p2^.data.id := i;

  tmp := p1^.data;
  p1^.data := p2^.data;
  p2^.data := tmp;
end;
procedure swap_entries(id1, id2 : integer);
var
  i : integer;
  p1, p2 : ^entires_list_item;
  tmp : TTTEntry;
begin
  id2 := id2; // escaping hint

  p1 := first_entry;
  for i := 0 to id1 - 1 do p1 := p1^.next;
  p2 := p1^.next;

  i := p1^.data.id;
  p1^.data.id := p2^.data.id;
  p2^.data.id := i;

  tmp := p1^.data;
  p1^.data := p2^.data;
  p2^.data := tmp;
end;

procedure clean_teachers;
var
  p : ^teacher_list_item;
begin
  while first_teacher <> nil do
  begin
    p := first_teacher^.next;
    first_teacher^.data.Free;
    dispose(first_teacher);
    first_teacher := p;
  end;
  count_teachers := 0;
end;
procedure clean_classrooms;
var
  p : ^classroom_list_item;
begin
  while first_classroom <> nil do
  begin
    p := first_classroom^.next;
    first_classroom^.data.Free;
    dispose(first_classroom);
    first_classroom := p;
  end;
  count_classrooms := 0;
end;
procedure clean_entries;
var
  p : ^entires_list_item;
begin
  while first_entry <> nil do
  begin
    p := first_entry^.next;
    first_entry^.data.Free;
    dispose(first_entry);
    first_entry := p;
  end;
  count_entries := 0;
end;

begin
  count_teachers   := 0;
  count_classrooms := 0;
  count_entries    := 0;
end.

