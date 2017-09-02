Command line database application, a college practice task. Written in Lazarus.

![glu_db](https://user-images.githubusercontent.com/13202642/29994776-5de0785e-8fe0-11e7-9c55-215dab315ca1.gif)

Data is stored in either typed or untyped files.

This was the biggest application I ever wrote at the moment. It took me 3-4 months to accomplish. It was also my deepest dive into OOP. Althrough it is a mix of OOP and module programming I wouldn't be able to make it without OOP.

A half of the codebase is something like Windows Forms (or Delphi) for 80x25 character display.

```
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


```
