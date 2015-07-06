{$INCLUDE settings}
unit db_sorting_classrooms;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  {$IfDef ARRAY_MODE}
  db_data_arrays,
  {$Else}
  db_data_lists,
  {$EndIf}
  SysUtils,
  db_basicthings;

{****f* db_sorting_classrooms/sort_classrooms
 *  SYNOPSIS
 *    sort_classrooms(field : integer; _order : TSortOrder);
 *  DESCRIPTION
 *    Sorts storage of classrooms.
 *  ARGUMENTS
 *    field : integer     - sorting field.
 *                          0 - number;
 *                          1 - workplaces;
 *                          2 - projector;
 *
 *    _order : TSortOrder - sorting order.
 ******}
procedure sort_classrooms(field : integer; _order : TSortOrder);

implementation

type
  bool_func = function : Boolean;

var
  tmp1, tmp2  : TClassroomRecord;
  compare : bool_func;
  order : TSortOrder;

function compare_number : boolean;
begin
  if order = or_ascend then
    Result := tmp1.number < tmp2.number
  else
    Result := tmp1.number > tmp2.number;
end;
function compare_projector : boolean;
begin
  if order = or_ascend then
    Result := ord(tmp1.has_projector) > ord(tmp2.has_projector)
  else
    Result := ord(tmp1.has_projector) < ord(tmp2.has_projector);
end;
function compare_workplaces : boolean;
begin
  if order = or_ascend then
    Result := tmp1.workplaces > tmp2.workplaces
  else
    Result := tmp1.workplaces < tmp2.workplaces;
end;

procedure sort_classrooms(field : integer; _order : TSortOrder);
var
  i, j : integer;
begin
  case field of
    0 : compare := @compare_number;
    1 : compare := @compare_workplaces;
    2 : compare := @compare_projector;
  end;
  order := _order;
  for i := 0 to getClassroomsCount - 1 do
    for j := 1 to (getClassroomsCount - 1) - i do
    begin
      tmp1 := get_classroom(j - 1);
      tmp2 := get_classroom(j);

      if compare() then swap_classrooms(j - 1, j);
    end;
end;

end.

