{$INCLUDE settings}
unit db_windows_add_entry;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Crt,
  db_windows,
  db_windows_controls,
  db_basicthings,
  {$IfDef ARRAY_MODE}
  db_data_arrays,
  {$Else}
  db_data_lists,
  {$EndIf}
  db_windows_main,
  db_windows_message,
  sysutils,
  dateutils;

procedure show_windows_add_entry(editID : integer = -1);
procedure windows_add_entry_free_memory;

implementation

var
  add_window             : TWindow;
  label1, label2, label3 : TLabel;
  datebox                : TDateBox;
  start_timebox          : TTimeBox;
  end_timebox            : TTimeBox;
  teacher_options        : TOptions;
  classroom_options      : TOptions;

procedure show_windows_add_entry(editID : integer = -1);
procedure set_header_and_values;
begin
  if editID = -1 then
  begin
    add_window.Header       := 'Add timetable entry';
    teacher_options.Index   := 0;
    classroom_options.Index := 0;
    datebox.DateTime        := Date;
    start_timebox.DateTime  := Now;
    end_timebox.DateTime    := Now + StrToTime('01:30');
  end
  else
    with get_entry(editID) do
    begin
      add_window.Header       := 'Edit timetable entry';
      teacher_options.Index   := teacher_id;
      classroom_options.Index := classroom_id;
      datebox.DateTime        := startTime;
      start_timebox.DateTime  := startTime;
      end_timebox.DateTime    := endTime;
    end;
end;
procedure set_options_items;
var
  i : integer;
begin
  teacher_options.ClearItems;
  classroom_options.ClearItems;

  for i := 0 to getTeachersCount - 1 do
    with get_teacher(i) do
      teacher_options.AddItem(surname + ' ' + name[1] + '. ' + patronymic[1] + '.');

  for i := 0 to getClassroomsCount - 1 do
    classroom_options.AddItem(get_classroom(i).number);
end;
var
  result : TModalResult;
begin
  set_options_items;

  set_header_and_values;

  add_window.Draw;

  result := add_window.Focus;
  repeat
    if ((result = mr_enter) and not (TimeOf(start_timebox.DateTime) < TimeOf(end_timebox.DateTime))) then
    begin
      show_windows_message('', 'Invalid time');
      result := add_window.Focus(1);
    end;
  until ((result = mr_enter) and (TimeOf(start_timebox.DateTime) < TimeOf(end_timebox.DateTime))) or (result = mr_escape);

  if result = mr_enter then
  begin
    start_timebox.DateTime := RecodeDate(start_timebox.DateTime, YearOf(datebox.DateTime), MonthOf(datebox.DateTime), DayOf(datebox.DateTime));
    set_entry(start_timebox.DateTime, TimeOf(end_timebox.DateTime), teacher_options.Index, classroom_options.Index, editID);
    counters_refresh;
  end;

  add_window.Hide;
end;

procedure windows_add_entry_free_memory;
begin
  add_window.Free;
  label1.Free;
  label2.Free;
  label3.Free;
  datebox.Free;
  start_timebox.Free;
  end_timebox.Free;
  teacher_options.Free;
  classroom_options.Free;
end;

const
  add_window_bounds         : TBounds = (32, 2, 32, 11);

  label1_bounds             : TBounds = (1, 2, 30, 0);
  datebox_bounds            : TBounds = (1, 3, 12, 0);
  start_timebox_bounds      : TBounds = (15, 3, 7, 0);
  end_timebox_bounds        : TBounds = (24, 3, 7, 0);

  label2_bounds             : TBounds = (1, 5, 30, 0);
  teacher_options_bounds    : TBounds = (1, 6, 25, 0);

  label3_bounds             : TBounds = (1, 8, 30, 0);
  classroom_options_bounds  : TBounds = (1, 9, 25, 0);

begin
  add_window := TWindow.Create(add_window_bounds);

  label1 := TLabel.Create(label1_bounds,
      trim_('Lesson date:', start_timebox_bounds[0] - 1)
    + trim_('Start:', (end_timebox_bounds[0] - start_timebox_bounds[0])) + 'End:');
  label2 := TLabel.Create(label2_bounds, 'Teacher:');
  label3 := TLabel.Create(label3_bounds, 'Classroom:');

  datebox       := TDateBox.Create(datebox_bounds, StrToDate('01.01.1970'), StrToDate('31.12.2030'));
  start_timebox := TTimeBox.Create(start_timebox_bounds);
  end_timebox   := TTimeBox.Create(end_timebox_bounds);

  teacher_options   := TOptions.Create(teacher_options_bounds);
  classroom_options := TOptions.Create(classroom_options_bounds);

  with add_window do
  begin
    AddControl(datebox);
    AddControl(start_timebox);
    AddControl(end_timebox);
    AddControl(teacher_options);
    AddControl(classroom_options);
    AddControl(label1);
    AddControl(label2);
    AddControl(label3);
  end;
end.

