{$INCLUDE settings}
unit db_sorting_teachers;

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

{****f* db_sorting_teachers/sort_teachers
 *  SYNOPSIS
 *    sort_teachers(field : integer; _order : TSortOrder);
 *  DESCRIPTION
 *    Sorts storage of teachers.
 *  ARGUMENTS
 *    field : integer     - sorting field.
 *                          0 - surname;
 *                          1 - name;
 *                          2 - patronymic;
 *
 *    _order : TSortOrder - sorting order.
 ******}
procedure sort_teachers(field : integer; _order : TSortOrder);

implementation

type
  bool_func = function : Boolean;

var
  tmp1, tmp2  : TTeacherRecord;
  compare : bool_func;
  order : TSortOrder;

function compare_name : boolean;
begin
  if order = or_ascend then
    Result := tmp1.name < tmp2.name
  else
    Result := tmp1.name > tmp2.name;
end;
function compare_surname : boolean;
begin
  if order = or_ascend then
    Result := tmp1.surname < tmp2.surname
  else
    Result := tmp1.surname > tmp2.surname;
end;
function compare_patronymic : boolean;
begin
  if order = or_ascend then
    Result := tmp1.patronymic < tmp2.patronymic
  else
    Result := tmp1.patronymic > tmp2.patronymic;
end;

procedure sort_teachers(field : integer; _order : TSortOrder);
var
  i, j : integer;
begin
  case field of
    0 : compare := @compare_surname;
    1 : compare := @compare_name;
    2 : compare := @compare_patronymic;
  end;
  order := _order;
  for i := 0 to getTeachersCount - 1 do
    for j := 1 to (getTeachersCount - 1) - i do
    begin
      tmp1 := get_teacher(j - 1);
      tmp2 := get_teacher(j);

      if compare() then swap_teachers(j - 1, j);
    end;
end;

end.

