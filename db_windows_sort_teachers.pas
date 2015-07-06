{$INCLUDE settings}
unit db_windows_sort_teachers;

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
  db_sorting_teachers;

procedure show_windows_sort_teachers;
procedure windows_sort_teachers_free_memory;

implementation

var
  sort_window : TWindow;
  preview_listbox : TListBox;
  order_options, field_options : TOptions;
  label1, label2 : TLabel;

procedure show_windows_sort_teachers;
var
  result : TModalResult;
begin
  sort_window.Draw;
  preview_listbox.Count := getTeachersCount;
  preview_listbox.Index := 0;
  preview_listbox.Draw(sort_window.Position);

  repeat
    result := sort_window.Focus(sort_window.FocusedControl);
    if result = mr_enter then
    begin
      if order_options.Index = 0 then
        sort_teachers(field_options.Index, or_descend)
      else
        sort_teachers(field_options.Index, or_ascend);
      preview_listbox.Count := getTeachersCount;
      preview_listbox.Index := 0;
      preview_listbox.Draw(sort_window.Position);
    end;
  until result = mr_escape;
  sort_window.Hide;
end;

procedure windows_sort_teachers_free_memory;
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
  num_col_width = 4;
  nam_col_width = 18;
  sur_col_width = 18;
  pat_col_width = 18;

var
  num_col, nam_col, sur_col, pat_col : TListColumn;

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

  preview_listbox.AddColumn(num_col);
  preview_listbox.AddColumn(sur_col);
  preview_listbox.AddColumn(nam_col);
  preview_listbox.AddColumn(pat_col);
end;

begin
  sort_window     := TWindow.Create(sort_window_bounds, 'Sort teachers');
  preview_listbox := TListBox.Create(preview_listbox_bounds);

  set_columns;

  label1 := TLabel.Create(label1_bounds, 'Sort by');
  label2 := TLabel.Create(label2_bounds, 'Order');

  field_options := TOptions.Create(field_options_bounds);
  field_options.AddItem('Surname');
  field_options.AddItem('Name');
  field_options.AddItem('Patronymic');
  order_options := TOptions.Create(order_options_bounds);
  order_options.AddItem('Descending');
  order_options.AddItem('Ascending');

  sort_window.AddControl(field_options);
  sort_window.AddControl(order_options);
  sort_window.AddControl(label1);
  sort_window.AddControl(label2);
end.

