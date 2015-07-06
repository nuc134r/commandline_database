{$INCLUDE settings}
unit db_windows_add_classroom;

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
  db_windows_main;

procedure show_windows_add_classroom(editID : integer = -1);
procedure windows_add_classroom_free_memory;

implementation

var
  add_window             : TWindow;
  name_textbox           : TTextBox;
  projector_options      : TOptions;
  label1, label2, label3 : TLabel;
  workplaces_number      : TNumber;

procedure show_windows_add_classroom(editID : integer = -1);
  procedure set_header_and_values;
  begin
    if editID = -1 then
    begin
      add_window.Header := 'Add classroom';
      name_textbox.Text := '';
      projector_options.Index := 0;
      workplaces_number.Index := 0;
    end
    else
    begin
      add_window.Header := 'Edit classroom';
      name_textbox.Text := get_classroom(editID).number;
      projector_options.Index := ord(get_classroom(editID).has_projector);
      workplaces_number.Index := get_classroom(editID).workplaces;
    end;
  end;

var
  result : TModalResult;
begin
  set_header_and_values;

  add_window.Draw;

  repeat
    result := add_window.Focus;
  until
    ((result = mr_enter) and (name_textbox.Text <> ''))
      or
    (result = mr_escape);

  if result = mr_enter then
  begin
    set_classroom(name_textbox.Text, workplaces_number.Index, projector_options.Index = 1, editID);
    counters_refresh;
  end;

  add_window.Hide;
end;

procedure windows_add_classroom_free_memory;
begin
  add_window.Free;
  name_textbox.Free;
  projector_options.Free;
  label1.Free;
  label2.Free;
  label3.Free;
  workplaces_number.Free;
end;

const
  add_window_bounds        : TBounds = (32, 2, 32, 11);

  label1_bounds            : TBounds = (1, 2, 30, 0);
  name_textbox_bounds      : TBounds = (1, 3, 30, 0);

  label2_bounds            : TBounds = (1, 5, 30, 0);
  projector_options_bounds : TBounds = (1, 6, 7, 0);

  label3_bounds            : TBounds = (1, 8, 30, 0);
  workplaces_number_bounds : TBounds = (1, 9, 7, 0);

  wrkplces_min = 0;  wrkplces_max = 100;

begin
  add_window := TWindow.Create(add_window_bounds);

  label1 := TLabel.Create(label1_bounds, 'Classroom name (number):');
  label2 := TLabel.Create(label2_bounds, 'Projector:');
  label3 := TLabel.Create(label3_bounds, 'Workplaces:');

  name_textbox := TTextBox.Create(name_textbox_bounds);

  projector_options := TOptions.Create(projector_options_bounds);
  projector_options.AddItem('No');
  projector_options.AddItem('Yes');

  workplaces_number := TNumber.Create(workplaces_number_bounds, wrkplces_min, wrkplces_max);

  with add_window do
  begin
    AddControl(name_textbox);
    AddControl(projector_options);
    AddControl(workplaces_number);
    AddControl(label1);
    AddControl(label2);
    AddControl(label3);
  end;
end.

