{$INCLUDE settings}
unit db_windows_greet;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Crt,
  db_basicthings,
  db_windows,
  db_windows_controls;

procedure show_windows_greet;
procedure windows_greet_free_memory;

implementation

var
  greet_window  : TWindow;
  label1, label2, label3, label4 : TLabel;

procedure show_windows_greet;
begin
  greet_window.Draw;
  readkey_;
  greet_window.Hide;
end;

procedure windows_greet_free_memory;
begin
  greet_window.Free;
  label1.Free;
  label2.Free;
  label3.Free;
  label4.Free;
end;

const
  greet_window_bounds : TBounds = (15, 9, 50, 9);
  label1_bounds       : TBounds = (0, 1, 50, 0);
  label2_bounds       : TBounds = (0, 3, 50, 0);
  label3_bounds       : TBounds = (0, 5, 50, 0);
  label4_bounds       : TBounds = (0, 7, 50, 0);

begin
  greet_window := TWindow.Create(greet_window_bounds);

  label1 := TLabel.Create(label1_bounds, 'Classrooms load database.',                 al_center);
  label2 := TLabel.Create(label2_bounds, 'Teachers, classrooms lists and timetable.', al_center);
  label3 := TLabel.Create(label3_bounds, '* * *',                                     al_center);
  label4 := TLabel.Create(label4_bounds, 'Tikhonov Sergey',                           al_center);

  with greet_window do
  begin
    AddControl(label1);
    AddControl(label2);
    AddControl(label3);
    AddControl(label4);
  end;
end.

