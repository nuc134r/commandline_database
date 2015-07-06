{$INCLUDE settings}
unit db_search;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  {$IfDef ARRAY_MODE}
  db_data_arrays,
  {$Else}
  db_data_lists,
  {$EndIf}
  db_data_string_output;

{****f* db_search/search_teachers
 *  SYNOPSIS
 *    search_teachers(query : string) : integer;
 *  DESCRIPTION
 *    Searches through teachers with a query and returns number of results.
 *    Use get_results_teacher_* functions to get search results.
 *  ARGUMENTS
 *    query : string - search query.
 ******}
function search_teachers(query : string) : integer;
{****f* db_search/get_results_teacher_id
 *  SYNOPSIS
 *    get_results_teacher_id(id : integer) : string;
 *  DESCRIPTION
 *    Get teacher id from results as string value.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_teacher_id(id : integer) : string;
{****f* db_search/get_results_teacher_name
 *  SYNOPSIS
 *    get_results_teacher_name(id : integer) : string;
 *  DESCRIPTION
 *    Get teacher name from results as string value.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_teacher_name(id : integer) : string;
{****f* db_search/get_results_teacher_surname
 *  SYNOPSIS
 *    get_results_teacher_surname(id : integer) : string;
 *  DESCRIPTION
 *    Get teacher surname from results as string value.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_teacher_surname(id : integer) : string;
{****f* db_search/get_results_teacher_patronymic
 *  SYNOPSIS
 *    get_results_teacher_patronymic(id : integer) : string;
 *  DESCRIPTION
 *    Get teacher patronymic from results as string value.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_teacher_patronymic(id : integer) : string;

{****f* db_search/search_classrooms
 *  SYNOPSIS
 *    search_classrooms(query : string) : integer;
 *  DESCRIPTION
 *    Searches through classrooms with a query and returns number of results.
 *    Use get_results_classrooms_* functions to get search results.
 *  ARGUMENTS
 *    query : string - search query.
 ******}
function search_classrooms(query : string) : integer;
{****f* db_search/get_results_classrooms_id
 *  SYNOPSIS
 *    get_results_classrooms_id(id : integer) : string;
 *  DESCRIPTION
 *    Get classroom id from results as string value.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_classrooms_id(id : integer) : string;
{****f* db_search/get_results_classrooms_number
 *  SYNOPSIS
 *    get_results_classrooms_number(id : integer) : string;
 *  DESCRIPTION
 *    Get classroom number from results as string value.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_classrooms_number(id : integer) : string;
{****f* db_search/get_results_classrooms_wrkplcs
 *  SYNOPSIS
 *    get_results_classrooms_wrkplcs(id : integer) : string;
 *  DESCRIPTION
 *    Get number of workplaces of a classroom from results as string value.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_classrooms_wrkplcs(id : integer) : string;
{****f* db_search/get_results_classrooms_projector
 *  SYNOPSIS
 *    get_results_classrooms_projector(id : integer) : string;
 *  DESCRIPTION
 *    Get classroom projector info from results as string value.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_classrooms_projector(id : integer) : string;

{****f* db_search/search_entries
 *  SYNOPSIS
 *    search_entries(query : string) : integer;
 *  DESCRIPTION
 *    Searches through timetable with a query and returns number of results.
 *    Use get_results_entries_* functions to get results.
 *  ARGUMENTS
 *    query : string - search query.
 ******}
function search_entries(query : string) : integer;
{****f* db_search/get_results_entries_id
 *  SYNOPSIS
 *    get_results_entries_id(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry id from results as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_entries_id(id : integer) : string;
{****f* db_search/get_results_entries_date
 *  SYNOPSIS
 *    get_results_entries_date(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry date from results as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_entries_date(id : integer) : string;
{****f* db_search/get_results_entries_start_time
 *  SYNOPSIS
 *    get_results_entries_start_time(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry start time from results as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_entries_start_time(id : integer) : string;
{****f* db_search/get_results_entries_end_time
 *  SYNOPSIS
 *    get_results_entries_end_time(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry end time from results as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_entries_end_time(id : integer) : string;
{****f* db_search/get_results_entries_teacher
 *  SYNOPSIS
 *    get_results_entries_teacher(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry teacher from results as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_entries_teacher(id : integer) : string;
{****f* db_search/get_results_entries_classroom
 *  SYNOPSIS
 *    get_results_entries_classroom(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry classroom from results as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_results_entries_classroom(id : integer) : string;

implementation

var
  results : array of integer;

function to_lower_case(s : string) : string;
var
  i : integer;
begin
  for i := 1 to Length(s) do
  begin
    if s[i] in [#65..#90]   then s[i] := chr(ord(s[i]) + 32); // latin
    if s[i] in [#128..#143] then s[i] := chr(ord(s[i]) + 32); // cyr 1
    if s[i] in [#144..#159] then s[i] := chr(ord(s[i]) + 80); // cyr 2
  end;
  Result := s;
end;

function search_teachers(query : string) : integer;
var
  i : integer;
  tmp : string;
begin
  SetLength(results, 0);
  query := to_lower_case(query);
  for i := 0 to getTeachersCount - 1 do
  begin
    with get_teacher(i) do tmp := IntToStr(i + 1) + name + surname + patronymic;
    tmp := to_lower_case(tmp);
    if pos(query, tmp) <> 0 then
    begin
      SetLength(results, Length(results) + 1);
      results[High(results)] := i;
    end;
  end;
  Result := Length(results);
end;
function get_results_teacher_id(id : integer) : string;         begin Result := get_teacher_id(results[id]);         end;
function get_results_teacher_name(id : integer) : string;       begin Result := get_teacher_name(results[id]);       end;
function get_results_teacher_surname(id : integer) : string;    begin Result := get_teacher_surname(results[id]);    end;
function get_results_teacher_patronymic(id : integer) : string; begin Result := get_teacher_patronymic(results[id]); end;

function search_classrooms(query : string) : integer;
var
  i : integer;
  tmp : string;
begin
  SetLength(results, 0);
  query := to_lower_case(query);
  for i := 0 to getClassroomsCount - 1 do
  begin
    with get_classroom(i) do tmp := IntToStr(i + 1) + number + ' ' + IntToStr(workplaces);
    tmp := to_lower_case(tmp);
    if pos(query, tmp) <> 0 then
    begin
      SetLength(results, Length(results) + 1);
      results[High(results)] := i;
    end;
  end;
  Result := Length(results);
end;
function get_results_classrooms_id(id : integer) : string;        begin Result := get_classroom_id(results[id]);         end;
function get_results_classrooms_number(id : integer) : string;    begin Result := get_classroom_number(results[id]);     end;
function get_results_classrooms_wrkplcs(id : integer) : string;   begin Result := get_classroom_workplaces(results[id]); end;
function get_results_classrooms_projector(id : integer) : string; begin Result := get_classroom_projector(results[id]);  end;

function search_entries(query : string) : integer;
var
  i : integer;
  tmp : string;
begin
  SetLength(results, 0);
  query := to_lower_case(query);
  for i := 0 to getEntriesCount - 1 do
  begin
    tmp := IntToStr(i + 1) + get_entry_date(i) + get_entry_start_time(i)
         + get_entry_end_time(i) + get_entry_teacher(i) + get_entry_classroom(i);
    tmp := to_lower_case(tmp);
    if pos(query, tmp) <> 0 then
    begin
      SetLength(results, Length(results) + 1);
      results[High(results)] := i;
    end;
  end;
  Result := Length(results);
end;
function get_results_entries_id(id : integer) : string;         begin Result := get_entry_id(results[id]);         end;
function get_results_entries_date(id : integer) : string;       begin Result := get_entry_date(results[id]);       end;
function get_results_entries_start_time(id : integer) : string; begin Result := get_entry_start_time(results[id]); end;
function get_results_entries_end_time(id : integer) : string;   begin Result := get_entry_end_time(results[id]);   end;
function get_results_entries_teacher(id : integer) : string;    begin Result := get_entry_teacher(results[id]);    end;
function get_results_entries_classroom(id : integer) : string;  begin Result := get_entry_classroom(results[id]);  end;

end.

