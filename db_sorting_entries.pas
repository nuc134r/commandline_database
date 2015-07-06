{$INCLUDE settings}
unit db_sorting_entries;

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

{****f* db_sorting_entries/sort_entries
 *  SYNOPSIS
 *    sort_entries(_order : TSortOrder);
 *  DESCRIPTION
 *    Sorts storage of timetable entries.
 *  ARGUMENTS
 *    _order : TSortOrder - sorting order.
 ******}
procedure sort_entries(_order : TSortOrder);

implementation

var
  tmp1, tmp2  : TTTEntryRecord;
  order : TSortOrder;

function compare_date : boolean;
begin
  if order = or_ascend then
    Result := tmp1.startTime < tmp2.startTime
  else
    Result := tmp1.startTime > tmp2.startTime;
end;

procedure sort_entries(_order : TSortOrder);
var
  i, j : integer;
begin
  order := _order;
  for i := 0 to getEntriesCount - 1 do
    for j := 1 to (getEntriesCount - 1) - i do
    begin
      tmp1 := get_entry(j - 1);
      tmp2 := get_entry(j);

      if compare_date then swap_entries(j - 1, j);
    end;
end;

end.

