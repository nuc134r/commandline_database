{$INCLUDE settings}
unit db_windows_brws_entries;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Crt,
  sysutils,
  db_windows,
  db_windows_controls,
  db_basicthings,
  {$IfDef ARRAY_MODE}
  db_data_arrays,
  {$Else}
  db_data_lists,
  {$EndIf}
  db_windows_main,
  db_data_string_output,
  db_constants,
  db_windows_add_entry,
  db_windows_delete_dlg,
  db_windows_message;

procedure show_windows_brws_entries(id : integer = -1);
procedure windows_brws_entries_free_memory;

implementation

var
  brws_window  : TWindow;
  brws_listbox : TListBox;
  count_label, cur_page_label : TLabel;

procedure brws_listbox_on_change(id : integer);
begin
  IntToStr(id);

  with cur_page_label, brws_listbox do
    Text := 'Page ' + IntToStr(CurPage) + ' of ' + IntToStr(Pages);

  cur_page_label.Draw(brws_window.Position);
end;

procedure updateCounters;
begin
  brws_listbox.Count := getEntriesCount;
  if brws_listbox.Index = getEntriesCount then
    brws_listbox.Index := brws_listbox.Index - 1
  else
    brws_listbox.Index := brws_listbox.Index;
  counters_refresh;
  count_label.Text := 'Total ' + IntToStr(getEntriesCount) + ' item(s)';
  with cur_page_label, brws_listbox do Text := 'Page ' + IntToStr(CurPage) + ' of ' + IntToStr(Pages);
end;

procedure show_windows_brws_entries(id : integer = -1);
var
  result : TModalResult;
procedure delete;
begin
  brws_window.Hide;
  if show_windows_delete_dlg('', 'Delete this entry?', '') then
  begin
    del_entry(brws_listbox.Index);
    updateCounters;
  end;
  brws_window.Draw;
end;
begin
  brws_listbox.Count := getEntriesCount;

  if id = -1 then brws_listbox.Index := 0 else brws_listbox.Index := id;

  count_label.Text := 'Total ' + IntToStr(getEntriesCount) + ' item(s)';
  with cur_page_label, brws_listbox do Text := 'Page ' + IntToStr(CurPage) + ' of ' + IntToStr(Pages);

  brws_window.Draw;
  repeat
    result := brws_window.Focus;
    case result of
      mr_enter :
        begin
          brws_window.Hide;
          show_windows_add_entry(brws_listbox.Index);
          brws_window.Draw;
        end;
      mr_delete : delete;
    end;
  until result = mr_escape;

  brws_window.Hide;
end;

procedure windows_brws_entries_free_memory;
begin
  brws_window.Free;
  brws_listbox.Free;
  count_label.Free;
  cur_page_label.Free;
end;

const
  brws_window_bounds     : TBounds = (22, 2, 57, 23);
  brws_listbox_bounds    : TBounds = (0, 0, 57, 22);
  count_label_bounds     : TBounds = (1, 22, 21, 0);
  cur_page_label_bounds  : TBounds = (34, 22, 22, 0);
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

  brws_listbox.AddColumn(num_col);
  brws_listbox.AddColumn(date_col);
  brws_listbox.AddColumn(time1_col);
  brws_listbox.AddColumn(time_sep_col);
  brws_listbox.AddColumn(time2_col);
  brws_listbox.AddColumn(tchr_col);
  brws_listbox.AddColumn(room_col);
end;

begin
  brws_window  := TWindow.Create(brws_window_bounds);
  brws_listbox := TListBox.Create(brws_listbox_bounds);

  count_label    := TLabel.Create(count_label_bounds);
  cur_page_label := TLabel.Create(cur_page_label_bounds, '', al_right);

  count_label.Color    := c_textDimColor;
  cur_page_label.Color := c_textDimColor;

  set_columns;

  brws_listbox.OnChange  := @brws_listbox_on_change;
  brws_listbox.CanDelete := true;

  brws_window.AddControl(count_label);
  brws_window.AddControl(cur_page_label);
  brws_window.AddControl(brws_listbox);
end.

