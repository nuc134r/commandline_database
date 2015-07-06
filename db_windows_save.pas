{$INCLUDE settings}
unit db_windows_save;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Crt,
  sysutils,
  db_windows,
  db_basicthings,
  db_windows_controls,
  db_filework,
  db_windows_main,
  db_windows_message;

procedure show_windows_save;
procedure windows_save_free_memory;

implementation

var
  save_window  : TWindow;
  file_textbox : TTextBox;
  hint_label, label1 : TLabel;
  file_options : TOptions;

procedure show_windows_save;
var
  result : TModalResult;
  file_result : integer;
begin
  save_window.Draw;

  repeat
    result := save_window.Focus;
    if (result = mr_enter) and (file_textbox.Text <> '') then
    begin
      if file_options.Index = 0 then
        file_result := save_typed(file_textbox.Text)
      else
        file_result := save_untyped(file_textbox.Text);
      if file_result = 0 then
        show_windows_message('Successfully saved to file!')
      else
        show_windows_message('Error writing file(' + IntToStr(file_result) + ').');
    end;
  until ((result = mr_enter) and (file_textbox.Text <> '') and (file_result = 0)) or (result = mr_escape);

  save_window.Hide;
end;

procedure windows_save_free_memory;
begin
  save_window.Free;
  file_textbox.Free;
  hint_label.Free;
  file_options.Free;
  label1.Free;
end;

const
  save_window_bounds  : TBounds = (23, 2, 55, 9);
  hint_label_bounds   : TBounds = (1, 2, 45, 0);
  file_textbox_bounds : TBounds = (1, 4, 53, 0);
  label1_bounds       : TBounds = (1, 6, 53, 0);
  file_options_bounds : TBounds = (1, 7, 13, 0);
  max_filename_len = 240;

begin
  save_window := TWindow.Create(save_window_bounds, 'Save file');

  hint_label  := TLabel.Create(hint_label_bounds, 'Enter file name to save to:');

  label1 := TLabel.Create(label1_bounds, 'File type:');

  file_options := TOptions.Create(file_options_bounds);
  file_options.AddItem('Typed');
  file_options.AddItem('Untyped');

  file_textbox := TTextBox.Create(file_textbox_bounds);
  file_textbox.MaxLength := max_filename_len;

  save_window.AddControl(hint_label);
  save_window.AddControl(file_textbox);
  save_window.AddControl(label1);
  save_window.AddControl(file_options);
end.

