{$INCLUDE settings}
unit db_windows_main;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  Crt,
  sysutils,
  {$IfDef ARRAY_MODE}
  db_data_arrays,
  {$Else}
  db_data_lists,
  {$EndIf}
  db_basicthings,
  db_windows,
  db_windows_controls;

function  show_windows_main(draw : boolean = true) : integer;
procedure windows_main_free_memory;
procedure counters_refresh;

implementation

var
  menu_window : TWindow;
  info_window : TWindow;
  teachers_label, rooms_label, timetable_label : TLabel;
  menu        : TMenu;

function show_windows_main(draw : boolean = true) : integer;
begin
  if draw then
  begin
    menu_window.Draw;
    counters_refresh;
  end;
  case menu_window.Focus of
    mr_enter  : Result := menu.Index;
    mr_escape : Result := -1;
  end;
end;

procedure counters_refresh;
begin
  teachers_label.Text  := trim_('Teachers',  10) + ': ' + trim_(IntToStr(getTeachersCount),   3);
  rooms_label.Text     := trim_('Rooms',     10) + ': ' + trim_(IntToStr(getClassroomsCount), 3);
  timetable_label.Text := trim_('Timetable', 10) + ': ' + trim_(IntToStr(getEntriesCount),    3);
  info_window.Draw;
end;

procedure windows_main_free_memory;
begin
  menu_window.Free;
  info_window.Free;
  teachers_label.Free;
  rooms_label.Free;
  timetable_label.Free;
  menu.Free;
end;

const
  menu_window_bounds : TBounds = (3, 2, 17, 8);
  menu_bounds        : TBounds = (0, 2, 17, 7);

procedure menu_window_init;
begin
  menu_window := TWindow.Create(menu_window_bounds, 'Database');

  menu := TMenu.Create(menu_bounds);

  with menu do
  begin
    AddMenuItem('Load');
    AddMenuItem('Save');
    AddMenuItem('Teachers');
    AddMenuItem('Classrooms');
    AddMenuItem('Timetable');
  end;

  menu_window.AddControl(menu);
end;

const
  info_window_bounds     : TBounds = (3, 11, 17, 5);
  teachers_label_bounds  : TBounds = (1, 1, 15, 0);
  rooms_label_bounds     : TBounds = (1, 2, 15, 0);
  timetable_label_bounds : TBounds = (1, 3, 15, 0);

procedure info_window_init;
begin
  info_window := TWindow.Create(info_window_bounds);

  teachers_label  := TLabel.Create(teachers_label_bounds);
  rooms_label     := TLabel.Create(rooms_label_bounds);
  timetable_label := TLabel.Create(timetable_label_bounds);

  info_window.AddControl(teachers_label);
  info_window.AddControl(rooms_label);
  info_window.AddControl(timetable_label);
end;

begin
  menu_window_init;
  info_window_init;
end.

