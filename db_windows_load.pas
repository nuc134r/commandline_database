{$INCLUDE settings}
unit db_windows_load;

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

procedure show_windows_load;
procedure windows_load_free_memory;

implementation

var
  load_window  : TWindow;
  file_textbox : TTextBox;
  label1, hint_label : TLabel;
  file_options : TOptions;

procedure show_windows_load;
var
  result : TModalResult;
  file_result : integer;
begin
  load_window.Draw;

  repeat
    result := load_window.Focus;
    if (result = mr_enter) and (file_textbox.Text <> '') then
    begin
      if file_options.Index = 0 then
        file_result := load_typed(file_textbox.Text)
      else
        file_result := load_untyped(file_textbox.Text);
      counters_refresh;
      if file_result = 0 then
      begin
        load_window.Hide;
        show_windows_message('Successfully loaded from file!')
      end
      else
        show_windows_message('Error reading file(' + IntToStr(file_result) + ').');
    end;
  until ((result = mr_enter) and (file_textbox.Text <> '') and (file_result = 0)) or (result = mr_escape);

  load_window.Hide;
end;

procedure windows_load_free_memory;
begin
  load_window.Free;
  file_textbox.Free;
  hint_label.Free;
  label1.Free;
  file_options.Free;
end;

const
  load_window_bounds  : TBounds = (23, 2, 55, 9);
  hint_label_bounds   : TBounds = (1, 2, 45, 0);
  file_textbox_bounds : TBounds = (1, 4, 53, 0);
  label1_bounds       : TBounds = (1, 6, 53, 0);
  file_options_bounds : TBounds = (1, 7, 13, 0);
  max_filename_len = 240;

begin
  load_window := TWindow.Create(load_window_bounds, 'Load file');

  label1 := TLabel.Create(label1_bounds, 'File type:');

  file_options := TOptions.Create(file_options_bounds);
  file_options.AddItem('Typed');
  file_options.AddItem('Untyped');

  hint_label  := TLabel.Create(hint_label_bounds, 'Enter file name to load (samples\testvalues):');

  file_textbox := TTextBox.Create(file_textbox_bounds);
  file_textbox.MaxLength := max_filename_len;

  load_window.AddControl(hint_label);
  load_window.AddControl(file_textbox);
  load_window.AddControl(label1);
  load_window.AddControl(file_options);
end.

