{$INCLUDE settings}
unit db_windows_add_teacher;

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

procedure show_windows_add_teacher(editID : integer = -1);
procedure windows_add_teacher_free_memory;

implementation

var
  add_window : TWindow;
  name_textbox, surname_textbox, patronymic_textbox : TTextBox;
  label1, label2, label3 : TLabel;

procedure show_windows_add_teacher(editID : integer = -1);
  procedure set_header_and_values;
  begin
    if editID = -1 then
    begin
      add_window.Header       := 'Add teacher';
      name_textbox.Text       := '';
      surname_textbox.Text    := '';
      patronymic_textbox.Text := '';
    end
    else
      with get_teacher(editID) do
      begin
        add_window.Header       := 'Edit teacher';
        name_textbox.Text       := name;
        surname_textbox.Text    := surname;
        patronymic_textbox.Text := patronymic;
      end;
  end;
var
  result : TModalResult;
  focused_control : integer;
begin
  focused_control := 0;

  set_header_and_values;

  add_window.Draw;

  repeat
    if surname_textbox.Text    = '' then focused_control := 2;
    if patronymic_textbox.Text = '' then focused_control := 1;
    if name_textbox.Text       = '' then focused_control := 0;
    result := add_window.Focus(focused_control);
  until
    ((result = mr_enter)
      and (name_textbox.Text <> '')
        and (surname_textbox.Text <> '')
          and (patronymic_textbox.Text <> ''))
      or
    (result = mr_escape);

  if result = mr_enter then
  begin
    set_teacher(name_textbox.Text, surname_textbox.Text, patronymic_textbox.Text, editID);
    counters_refresh;
  end;

  add_window.Hide;
end;

procedure windows_add_teacher_free_memory;
begin
  add_window.Free;
  name_textbox.Free;
  surname_textbox.Free;
  patronymic_textbox.Free;
  label1.Free;
  label2.Free;
  label3.Free;
end;

const
  add_window_bounds         : TBounds = (32, 2, 32, 11);

  label1_bounds             : TBounds = (1, 2, 30, 0);
  name_textbox_bounds       : TBounds = (1, 3, 30, 0);

  label2_bounds             : TBounds = (1, 5, 30, 0);
  patronymic_textbox_bounds : TBounds = (1, 6, 30, 0);

  label3_bounds             : TBounds = (1, 8, 30, 0);
  surname_textbox_bounds    : TBounds = (1, 9, 30, 0);

begin
  add_window := TWindow.Create(add_window_bounds);

  label1 := TLabel.Create(label1_bounds, 'Name:');
  label2 := TLabel.Create(label2_bounds, 'Patronymic:');
  label3 := TLabel.Create(label3_bounds, 'Surname:');

  name_textbox       := TTextBox.Create(name_textbox_bounds);
  surname_textbox    := TTextBox.Create(surname_textbox_bounds);
  patronymic_textbox := TTextBox.Create(patronymic_textbox_bounds);

  with add_window do
  begin
    AddControl(name_textbox);
    AddControl(patronymic_textbox);
    AddControl(surname_textbox);
    AddControl(label1);
    AddControl(label2);
    AddControl(label3);
  end;
end.
