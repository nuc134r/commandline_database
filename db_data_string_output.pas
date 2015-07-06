{$INCLUDE settings}
unit db_data_string_output;

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
  dateutils;

{****f* db_data_string_output/get_teacher_id
 *  SYNOPSIS
 *    get_teacher_id(id : integer) : string;
 *  DESCRIPTION
 *    Get teacher id as string value.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_teacher_id(id : integer)         : string;
{****f* db_data_string_output/get_teacher_name
 *  SYNOPSIS
 *    get_teacher_name(id : integer) : string;
 *  DESCRIPTION
 *    Get teacher name as string value.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_teacher_name(id : integer)       : string;
{****f* db_data_string_output/get_teacher_surname
 *  SYNOPSIS
 *    get_teacher_surname(id : integer) : string;
 *  DESCRIPTION
 *    Get teacher surname as string value.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_teacher_surname(id : integer)    : string;
{****f* db_data_string_output/get_teacher_patronymic
 *  SYNOPSIS
 *    get_teacher_patronymic(id : integer) : string;
 *  DESCRIPTION
 *    Get teacher patronymic (second name) as string value.
 *  ARGUMENTS
 *    id : integer - teacher identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_teacher_patronymic(id : integer) : string;

{****f* db_data_string_output/get_classroom_id
 *  SYNOPSIS
 *    get_classroom_id(id : integer) : string;
 *  DESCRIPTION
 *    Get classroom id as string value.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_classroom_id(id : integer)         : string;
{****f* db_data_string_output/get_classroom_number
 *  SYNOPSIS
 *    get_classroom_number(id : integer) : string;
 *  DESCRIPTION
 *    Get classroom number as string value.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_classroom_number(id : integer)     : string;
{****f* db_data_string_output/get_classroom_workplaces
 *  SYNOPSIS
 *    get_classroom_workplaces(id : integer) : string;
 *  DESCRIPTION
 *    Get number of workplaces in classroom as string value.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_classroom_workplaces(id : integer) : string;
{****f* db_data_string_output/get_classroom_projector
 *  SYNOPSIS
 *    get_classroom_projector(id : integer) : string;
 *  DESCRIPTION
 *    Get projector info of a classroom as string value.
 *  ARGUMENTS
 *    id : integer - classroom identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_classroom_projector(id : integer)  : string;

{****f* db_data_string_output/get_entry_id
 *  SYNOPSIS
 *    get_entry_id(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry id as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_entry_id(id : integer)         : string;
{****f* db_data_string_output/get_entry_date
 *  SYNOPSIS
 *    get_entry_date(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry date as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_entry_date(id : integer)       : string;
{****f* db_data_string_output/get_entry_start_time
 *  SYNOPSIS
 *    get_entry_start_time(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry start time as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_entry_start_time(id : integer) : string;
{****f* db_data_string_output/get_entry_end_time
 *  SYNOPSIS
 *    get_entry_end_time(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry end time as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_entry_end_time(id : integer)   : string;
{****f* db_data_string_output/get_entry_teacher
 *  SYNOPSIS
 *    get_entry_teacher(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry teacher as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_entry_teacher(id : integer)    : string;
{****f* db_data_string_output/get_entry_classroom
 *  SYNOPSIS
 *    get_entry_classroom(id : integer) : string;
 *  DESCRIPTION
 *    Get timetable entry classroom as string value.
 *  ARGUMENTS
 *    id : integer - timetable entry identificator.
 *  BUGS
 *    You better not request for unexisting id.
 ******}
function get_entry_classroom(id : integer)  : string;

implementation

function get_teacher_id(id : integer)         : string; begin Result := IntToStr(id + 1);           end;
function get_teacher_name(id : integer)       : string; begin Result := get_teacher(id).name;       end;
function get_teacher_surname(id : integer)    : string; begin Result := get_teacher(id).surname;    end;
function get_teacher_patronymic(id : integer) : string; begin Result := get_teacher(id).patronymic; end;

function get_classroom_id(id : integer)         : string; begin Result := IntToStr(id + 1);                                                  end;
function get_classroom_number(id : integer)     : string; begin Result := get_classroom(id).number;                                          end;
function get_classroom_workplaces(id : integer) : string; begin Result := IntToStr(get_classroom(id).workplaces);                            end;
function get_classroom_projector(id : integer)  : string; begin if get_classroom(id).has_projector then Result := 'Yes' else Result := 'No'; end;

function get_entry_id(id : integer)         : string; begin Result := IntToStr(id + 1);                                      end;
function get_entry_date(id : integer)       : string; begin DateTimeToString(Result, 'dd.mm.yyyy', get_entry(id).startTime); end;
function get_entry_start_time(id : integer) : string; begin DateTimeToString(Result, 'hh:nn', get_entry(id).startTime);      end;
function get_entry_end_time(id : integer)   : string; begin DateTimeToString(Result, 'hh:nn', get_entry(id).endTime);        end;
function get_entry_teacher(id : integer)    : string;
begin
  with get_teacher(get_entry(id).teacher_id) do
    Result := surname + ' ' + name[1] + '. ' + patronymic[1] + '.';
end;
function get_entry_classroom(id : integer)  : string;
begin
  Result := get_classroom(get_entry(id).classroom_id).number;
end;

end.

