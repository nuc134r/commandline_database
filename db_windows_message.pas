{$INCLUDE settings}
unit db_windows_message;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  db_windows,
  db_windows_controls,
  db_basicthings,
  db_windows_main;

procedure show_windows_message(line1 : string; line2 : string = ''; line3 : string = '');
procedure windows_message_free_memory;

implementation

var
  message_window : TWindow;
  message_label1, message_label2, message_label3 : TLabel;

procedure show_windows_message(line1 : string; line2 : string = ''; line3 : string = '');
begin
  message_label1.Text := line1;
  message_label2.Text := line2;
  message_label3.Text := line3;

  message_window.Draw;

  readkey_;

  message_window.Hide;
end;

procedure windows_message_free_memory;
begin
  message_window.Free;
  message_label1.Free;
  message_label2.Free;
  message_label3.Free;
end;

const
  message_window_bounds  : TBounds = (23, 19, 33, 6);
  message_label1_bounds  : TBounds = (1, 2, 31, 1);
  message_label2_bounds  : TBounds = (1, 3, 31, 1);
  message_label3_bounds  : TBounds = (1, 4, 31, 1);

begin
  message_window := TWindow.Create(message_window_bounds, 'Message');

  message_label1 := TLabel.Create(message_label1_bounds, '', al_center);
  message_label2 := TLabel.Create(message_label2_bounds, '', al_center);
  message_label3 := TLabel.Create(message_label3_bounds, '', al_center);

  message_window.AddControl(message_label1);
  message_window.AddControl(message_label2);
  message_window.AddControl(message_label3);
end.

