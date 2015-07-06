{$INCLUDE settings}
unit db_windows_brws_teachers;

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
  db_windows_add_teacher,
  db_windows_delete_dlg,
  db_windows_message;

procedure show_windows_brws_teachers(id : integer = -1);
procedure windows_brws_teachers_free_memory;

implementation

var
  brws_window  : TWindow;
  brws_listbox : TListBox;
  num_col, nam_col, sur_col, pat_col : TListColumn;
  count_label, cur_page_label : TLabel;

procedure brws_listbox_on_change(num : integer);
begin
  cur_page_label.Text := 'Page ' + IntToStr(num) + ' of ' + IntToStr(brws_listbox.Pages);
  cur_page_label.Draw(brws_window.Position);
end;

procedure updateCounters;
begin
  brws_listbox.Count := getTeachersCount;
  if brws_listbox.Index = getTeachersCount then
    brws_listbox.Index := brws_listbox.Index - 1
  else
    brws_listbox.Index := brws_listbox.Index;
  counters_refresh;
  count_label.Text := 'Total ' + IntToStr(getTeachersCount) + ' item(s)';
  with cur_page_label, brws_listbox do Text := 'Page ' + IntToStr(CurPage) + ' of ' + IntToStr(Pages);
end;

procedure show_windows_brws_teachers(id : integer = -1);
var
  result : TModalResult;
  tmp : string;
procedure delete;
begin
  brws_window.Hide;
  if not is_teacher_linked(brws_listbox.Index) then
  begin
    with get_teacher(brws_listbox.Index) do tmp := surname + ' ' + name + ' ' + patronymic;
    if show_windows_delete_dlg('Delete?', '', tmp) then
    begin
      del_teacher(brws_listbox.Index);
      updateCounters;
    end;
  end
  else
    show_windows_message('Remove all timetable', 'entries referring to this', 'item to delete it.');
  brws_window.Draw;
end;
begin
  brws_listbox.Count := getTeachersCount;

  if id = -1 then brws_listbox.Index := 0 else brws_listbox.Index := id;

  count_label.Text := 'Total ' + IntToStr(getTeachersCount) + ' item(s)';
  with cur_page_label, brws_listbox do Text := 'Page ' + IntToStr(CurPage) + ' of ' + IntToStr(Pages);

  brws_window.Draw;
  repeat
    result := brws_window.Focus;
    case result of
      mr_enter :
        begin
          brws_window.Hide;
          show_windows_add_teacher(brws_listbox.Index);
          brws_window.Draw;
        end;
      mr_delete : delete;
    end;
  until result = mr_escape;

  brws_window.Hide;
end;

procedure windows_brws_teachers_free_memory;
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
  num_col_width = 4;
  nam_col_width = 17;
  sur_col_width = 17;
  pat_col_width = 18;

procedure set_columns;
begin
  num_col.legend      := '#';
  num_col.width       := num_col_width;
  num_col.getItemFunc := @get_teacher_id;

  nam_col.legend      := 'Name';
  nam_col.width       := nam_col_width;
  nam_col.getItemFunc := @get_teacher_name;

  sur_col.legend      := 'Surame';
  sur_col.width       := sur_col_width;
  sur_col.getItemFunc := @get_teacher_surname;

  pat_col.legend      := 'Patronymic';
  pat_col.width       := pat_col_width;
  pat_col.getItemFunc := @get_teacher_patronymic;

  brws_listbox.AddColumn(num_col);
  brws_listbox.AddColumn(sur_col);
  brws_listbox.AddColumn(nam_col);
  brws_listbox.AddColumn(pat_col);
end;

begin
  brws_window  := TWindow.Create(brws_window_bounds);
  brws_listbox := TListBox.Create(brws_listbox_bounds);

  count_label    := TLabel.Create(count_label_bounds);
  cur_page_label := TLabel.Create(cur_page_label_bounds, '', al_right);

  count_label.Color    := c_textDimColor;
  cur_page_label.Color := c_textDimColor;

  set_columns;

  brws_listbox.OnChange := @brws_listbox_on_change;
  brws_listbox.CanDelete := true;

  brws_window.AddControl(count_label);
  brws_window.AddControl(cur_page_label);
  brws_window.AddControl(brws_listbox);
end.

