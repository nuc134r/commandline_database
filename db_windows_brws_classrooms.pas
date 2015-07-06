{$INCLUDE settings}
unit db_windows_brws_classrooms;

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
  db_windows_add_classroom,
  db_windows_delete_dlg,
  db_windows_message;

procedure show_windows_brws_classrooms(id : integer = -1);
procedure windows_brws_classrooms_free_memory;

implementation

var
  brws_window  : TWindow;
  brws_listbox : TListBox;
  num_col, nam_col, wrkplc_col, proj_col : TListColumn;
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
  brws_listbox.Count := getClassroomsCount;
  if brws_listbox.Index = getClassroomsCount then
    brws_listbox.Index := brws_listbox.Index - 1
  else
    brws_listbox.Index := brws_listbox.Index;
  counters_refresh;
  count_label.Text := 'Total ' + IntToStr(getClassroomsCount) + ' item(s)';
  with cur_page_label, brws_listbox do Text := 'Page ' + IntToStr(CurPage) + ' of ' + IntToStr(Pages);
end;

procedure show_windows_brws_classrooms(id : integer = -1);
var
  result : TModalResult;
procedure delete;
begin
  brws_window.Hide;
  if not is_classroom_linked(brws_listbox.Index) then
  begin
    if show_windows_delete_dlg('Delete?', '', get_classroom(brws_listbox.Index).number) then
    begin
      del_classroom(brws_listbox.Index);
      updateCounters;
    end;
  end
  else
    show_windows_message('Remove all timetable', 'entries referring to this', 'item to delete it.');
  brws_window.Draw;
end;
begin
  brws_listbox.Count := getClassroomsCount;

  if id = -1 then brws_listbox.Index := 0 else brws_listbox.Index := id;

  count_label.Text := 'Total ' + IntToStr(getClassroomsCount) + ' item(s)';
  with cur_page_label, brws_listbox do Text := 'Page ' + IntToStr(CurPage) + ' of ' + IntToStr(Pages);

  brws_window.Draw;
  repeat
    result := brws_window.Focus;
    case result of
      mr_enter :
        begin
          brws_window.Hide;
          show_windows_add_classroom(brws_listbox.Index);
          brws_window.Draw;
        end;
      mr_delete : delete;
    end;
  until result = mr_escape;

  brws_window.Hide;
end;

procedure windows_brws_classrooms_free_memory;
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
  num_col_width    = 4;
  nam_col_width    = 20;
  wrkplc_col_width = 16;
  proj_col_width   = 16;

procedure set_columns;
begin
  num_col.legend      := '#';
  num_col.width       := num_col_width;
  num_col.getItemFunc := @get_classroom_id;

  nam_col.legend      := 'Number';
  nam_col.width       := nam_col_width;
  nam_col.getItemFunc := @get_classroom_number;

  wrkplc_col.legend      := 'Workplaces';
  wrkplc_col.width       := wrkplc_col_width;
  wrkplc_col.getItemFunc := @get_classroom_workplaces;

  proj_col.legend      := 'Projector';
  proj_col.width       := proj_col_width;
  proj_col.getItemFunc := @get_classroom_projector;

  brws_listbox.AddColumn(num_col);
  brws_listbox.AddColumn(nam_col);
  brws_listbox.AddColumn(wrkplc_col);
  brws_listbox.AddColumn(proj_col);
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

