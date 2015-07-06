{$INCLUDE settings}
unit db_windows_delete_dlg;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  Crt,
  db_windows,
  db_windows_controls,
  db_basicthings,
  db_constants;

function show_windows_delete_dlg(line1, line2, line3 : string) : boolean;
procedure windows_delete_dlg_free_memory;

implementation

var
  dlg_window : TWindow;
  label1, label2, label3 : TLabel;

const
  no_pos  : TPosition = (X: 26; Y : 7);
  yes_pos : TPosition = (X: 16; Y : 7);

function show_windows_delete_dlg(line1, line2, line3 : string) : boolean;
var
  mode : integer;
  c : TKey;
begin
  label1.Text := line1;
  label2.Text := line2;
  label3.Text := line3;

  mode := 1;
  dlg_window.Draw;
  repeat
    GotoXY(no_pos.X, no_pos.Y);
    if mode = 1 then TextBackground(c_windowHeader) else TextBackground(c_windowBase);
    Write('[No]');
    GotoXY(yes_pos.X, yes_pos.Y);
    if mode = 2 then TextBackground(c_windowHeader) else TextBackground(c_windowBase);
    Write('[Yes]');
    c := readkey_;
    if (mode = 2) and (c = k_right) then mode := 1;
    if (mode = 1) and (c = k_left)  then mode := 2;
  until (c = k_escape) or (c = k_enter);

  dlg_window.Hide;
  Result := (c = k_enter) and (mode = 2);
end;

procedure windows_delete_dlg_free_memory;
begin
  dlg_window.Free;
  label1.Free;
  label2.Free;
  label3.Free;
end;

const
  dlg_window_bounds : TBounds = (27, 6, 45, 8);
  label1_bounds     : TBounds = (1, 2, 43, 0);
  label2_bounds     : TBounds = (1, 3, 43, 0);
  label3_bounds     : TBounds = (1, 4, 43, 0);

begin
  dlg_window := TWindow.Create(dlg_window_bounds, ' ');

  label1 := TLabel.Create(label1_bounds, '', al_center);
  label2 := TLabel.Create(label2_bounds, '', al_center);
  label3 := TLabel.Create(label3_bounds, '', al_center);

  dlg_window.AddControl(label1);
  dlg_window.AddControl(label2);
  dlg_window.AddControl(label3);
end.

