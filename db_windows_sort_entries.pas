{$INCLUDE settings}
unit db_windows_sort_entries;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  db_windows,
  db_windows_controls,
  db_data_string_output,
  {$IfDef ARRAY_MODE}
  db_data_arrays,
  {$Else}
  db_data_lists,
  {$EndIf}
  db_basicthings,
  db_sorting_entries;

procedure show_windows_sort_entries;
procedure windows_sort_entries_free_memory;

implementation

var
  sort_window : TWindow;
  preview_listbox : TListBox;
  order_options, field_options : TOptions;
  label1, label2 : TLabel;

procedure show_windows_sort_entries;
var
  result : TModalResult;
begin
  sort_window.Draw;
  preview_listbox.Count := getEntriesCount;
  preview_listbox.Index := 0;
  preview_listbox.Draw(sort_window.Position);

  repeat
    result := sort_window.Focus(sort_window.FocusedControl);
    if result = mr_enter then
    begin
      if order_options.Index = 0 then
        sort_entries(or_descend)
      else
        sort_entries(or_ascend);
      preview_listbox.Count := getEntriesCount;
      preview_listbox.Index := 0;
      preview_listbox.Draw(sort_window.Position);
    end;
  until result = mr_escape;
  sort_window.Hide;
end;

procedure windows_sort_entries_free_memory;
begin
  sort_window.Free;
  preview_listbox.Free;
  order_options.Free;
  field_options.Free;
  label1.Free;
  label2.Free;
end;

const
  sort_window_bounds     : TBounds = (21, 2, 59, 23);
  preview_listbox_bounds : TBounds = (0, 5, 59, 17);
  label1_bounds          : TBounds = (1, 2, 12, 0);
  label2_bounds          : TBounds = (20, 2, 12, 0);
  field_options_bounds   : TBounds = (1, 3, 15, 0);
  order_options_bounds   : TBounds = (20, 3, 15, 0);
  num_col_width   = 4;
  date_col_width  = 12;
  time1_col_width = 5;
  time2_col_width = 7;
  tchr_col_width  = 17;
  room_col_width  = 10;

var
  num_col, date_col, time1_col, time2_col, time_sep_col, tchr_col, room_col : TListColumn;

function getDash(id : integer) : string;
begin
  id := id;
  Result := '-';
end;

procedure set_columns;
begin
  num_col.legend        := '#';
  num_col.width         := num_col_width;
  num_col.getItemFunc   := @get_entry_id;

  date_col.legend       := 'Date';
  date_col.width        := date_col_width;
  date_col.getItemFunc  := @get_entry_date;

  time1_col.legend      := 'Time';
  time1_col.width       := time1_col_width;
  time1_col.getItemFunc := @get_entry_start_time;

  time_sep_col.legend   := '';
  time_sep_col.width    := 1;
  time_sep_col.getItemFunc := @getDash;

  time2_col.legend      := '';
  time2_col.width       := time2_col_width;
  time2_col.getItemFunc := @get_entry_end_time;

  tchr_col.legend      := 'Teacher';
  tchr_col.width       := tchr_col_width;
  tchr_col.getItemFunc := @get_entry_teacher;

  room_col.legend      := 'Classroom';
  room_col.width       := room_col_width;
  room_col.getItemFunc := @get_entry_classroom;

  preview_listbox.AddColumn(num_col);
  preview_listbox.AddColumn(date_col);
  preview_listbox.AddColumn(time1_col);
  preview_listbox.AddColumn(time_sep_col);
  preview_listbox.AddColumn(time2_col);
  preview_listbox.AddColumn(tchr_col);
  preview_listbox.AddColumn(room_col);
end;

begin
  sort_window     := TWindow.Create(sort_window_bounds, 'Sort entries');
  preview_listbox := TListBox.Create(preview_listbox_bounds);

  set_columns;

  label1 := TLabel.Create(label1_bounds, 'Sort by');
  label2 := TLabel.Create(label2_bounds, 'Order');

  field_options := TOptions.Create(field_options_bounds);
  field_options.AddItem('Date''n''time');
  order_options := TOptions.Create(order_options_bounds);
  order_options.AddItem('Descending');
  order_options.AddItem('Ascending');

  sort_window.AddControl(field_options);
  sort_window.AddControl(order_options);
  sort_window.AddControl(label1);
  sort_window.AddControl(label2);
end.

