{$INCLUDE settings}
unit db_windows_submenu;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  db_windows,
  db_windows_controls,
  db_basicthings,
  db_windows_main;

function show_windows_submenu(table_index : integer) : integer;
procedure windows_submenu_free_memory;

implementation

var
  submenu_window : TWindow;
  submenu : TMenu;

function show_windows_submenu(table_index : integer) : integer;
var
  optional_position : TPosition;
begin
  submenu.Index := 0;

  optional_position.X := submenu_window.Position.X;
  optional_position.Y := 1 + 1 + 1 + table_index;

  submenu_window.Position := optional_position;

  submenu_window.Draw;

  if submenu_window.Focus = mr_enter then
    Result := submenu.Index
  else
    Result := -1;

  submenu_window.Hide;
end;

procedure windows_submenu_free_memory;
begin
  submenu_window.Free;
  submenu.Free;
end;

const
  submenu_window_bounds : TBounds = (21, 4, 11, 6);
  submenu_bounds        : TBounds = (0, 1, 11, 6);
  menu_item_width = 9;

begin
  submenu_window := TWindow.Create(submenu_window_bounds);

  submenu := TMenu.Create(submenu_bounds);

  with submenu do
  begin
    AddMenuItem(trim_('Browse', menu_item_width - 1) + '>');
    AddMenuItem('Add');
    AddMenuItem('Search');
    AddMenuItem('Sort');
  end;

  submenu_window.AddControl(submenu);
end.

