{$INCLUDE settings}
unit db_windows;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db_windows_controls, db_constants, db_basicthings;

type
  TWindow = class
    private
      _header    : String;
      _size      : TSize;
      _position  : TPosition;
      _controls  : array of TControl;
      _focused_ctrl : integer;
    public
      property Header : string read _header write _header;
      property Size : TSize read _size write _size;
      property Position : TPosition read _position write _position;
      property FocusedControl : integer read _focused_ctrl;

      constructor Create(Bounds : TBounds; Header_ : string = '');
      procedure   AddControl(ctrl : TControl);
      procedure   Draw;
      procedure   Hide;
      function    Focus(control_id : integer = 0) : TModalResult;
  end;

implementation

uses
  Crt;

{ TWindow }

constructor TWindow.Create(Bounds : TBounds; Header_ : string = '');
begin
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
  _size.H := Bounds[3];
  _header := Header_;
end;
procedure   TWindow.AddControl(ctrl : TControl);
begin
  SetLength(_controls, Length(_controls) + 1);
  _controls[High(_controls)] := ctrl;
end;
procedure   TWindow.Draw;
var
  i : Integer;
begin
  with _position, _size do window(X, Y, X + W - 1, Y + H - 1);
  TextBackground(c_windowBase);
  ClrScr;
  if _header <> '' then
  begin
    with _position, _size do window(X, Y, X + W - 1, Y);
    TextBackground(c_windowHeader);
    ClrScr;
    TextColor(c_textcolor);
    gotoxy((_size.W - Length(_header)) div 2 + 1, 1); // centrifying header text
    write(_header);
  end;
  TextBackground(c_windowBase);
  for i := 0 to High(_controls) do _controls[i].Draw(_position);
  with _position, _size do window(X, Y, X + W - 1, Y + H - 1);
end;
procedure   TWindow.Hide;
begin
  with _position, _size do window(X, Y, X + W - 1, Y + H - 1);
  TextBackground(c_background);
  ClrScr;
end;
function    TWindow.Focus(control_id : integer = 0) : TModalResult;
var
  _result : TModalResult;
begin
  repeat
    _focused_ctrl := control_id;
    _result := _controls[control_id].Focus(_position);
    inc(control_id);
    if control_id > High(_controls) then control_id := 0;
  until (_result <> mr_tab);
  Result := _result;
end;

end.

