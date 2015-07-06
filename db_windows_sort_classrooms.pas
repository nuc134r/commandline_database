{$INCLUDE settings}
unit db_windows_sort_classrooms;

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
  db_sorting_classrooms;

procedure show_windows_sort_classrooms;
procedure windows_sort_classrooms_free_memory;

implementation

var
  sort_window : TWindow;
  preview_listbox : TListBox;
  order_options, field_options : TOptions;
  label1, label2 : TLabel;

procedure show_windows_sort_classrooms;
var
  result : TModalResult;
begin
  sort_window.Draw;
  preview_listbox.Count := getClassroomsCount;
  preview_listbox.Index := 0;
  preview_listbox.Draw(sort_window.Position);

  repeat
    result := sort_window.Focus(sort_window.FocusedControl);
    if result = mr_enter then
    begin
      if order_options.Index = 0 then
        sort_classrooms(field_options.Index, or_descend)
      else
        sort_classrooms(field_options.Index, or_ascend);
      preview_listbox.Count := getClassroomsCount;
      preview_listbox.Index := 0;
      preview_listbox.Draw(sort_window.Position);
    end;
  until result = mr_escape;
  sort_window.Hide;
end;

procedure windows_sort_classrooms_free_memory;
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
  num_col_width    = 4;
  nam_col_width    = 20;
  wrkplc_col_width = 16;
  proj_col_width   = 16;

var
  num_col, nam_col, wrkplc_col, proj_col : TListColumn;

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

  preview_listbox.AddColumn(num_col);
  preview_listbox.AddColumn(nam_col);
  preview_listbox.AddColumn(wrkplc_col);
  preview_listbox.AddColumn(proj_col);
end;

begin
  sort_window     := TWindow.Create(sort_window_bounds, 'Sort classrooms');
  preview_listbox := TListBox.Create(preview_listbox_bounds);

  set_columns;

  label1 := TLabel.Create(label1_bounds, 'Sort by');
  label2 := TLabel.Create(label2_bounds, 'Order');

  field_options := TOptions.Create(field_options_bounds);
  field_options.AddItem('Number');
  field_options.AddItem('Workplaces');
  field_options.AddItem('Projector');
  order_options := TOptions.Create(order_options_bounds);
  order_options.AddItem('Descending');
  order_options.AddItem('Ascending');

  sort_window.AddControl(field_options);
  sort_window.AddControl(order_options);
  sort_window.AddControl(label1);
  sort_window.AddControl(label2);
end.

