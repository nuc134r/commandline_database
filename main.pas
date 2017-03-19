{$INCLUDE settings}

uses
  Crt,

  { types, contants, helping functions }
  db_constants,
  db_basicthings,

  { forms-like interface classes }
  db_windows,
  db_windows_controls,

  { database logic }
  db_filework,
  {$IfDef ARRAY_MODE}
  db_data_arrays,
  {$Else}
  db_data_lists,
  {$EndIf}
  db_search,
  db_sorting_teachers,
  db_sorting_classrooms,
  db_sorting_entries,

  { app windows }
  db_windows_greet,
  db_windows_message,
  db_windows_load,
  db_windows_save,
  db_windows_main,
  db_windows_submenu,
  db_windows_add_classroom,
  db_windows_add_teacher,
  db_windows_add_entry,
  db_windows_brws_teachers,
  db_windows_brws_classrooms,
  db_windows_brws_entries,
  db_windows_delete_dlg,
  db_windows_srch_teachers,
  db_windows_srch_classrooms,
  db_windows_srch_entries,
  db_windows_sort_teachers,
  db_windows_sort_classrooms,
  db_windows_sort_entries;

procedure do_nothing;
begin
  { Isn't it strange how broken glass tastes like blood? }
end;

procedure launch_window_chain;
const
  { menu/mode indexes }
  menu_load  = 0;
  menu_save  = 1;
  menu_tchrs = 2;
  menu_rooms = 3;
  menu_ttabl = 4;

  submenu_brws = 0;
  submenu_add  = 1;
  submenu_srch = 2;
  submenu_sort = 3;

  exit = -1;
var
  mode : integer;
procedure launch_teachers_submenu;
begin
  case show_windows_submenu(mode) of
    submenu_brws :
      if getTeachersCount <> 0 then
        show_windows_brws_teachers
      else
        show_windows_message('', 'No teachers');
    submenu_add  : show_windows_add_teacher;
    submenu_srch : show_windows_srch_teachers;
    submenu_sort : show_windows_sort_teachers;
  end;
end;
procedure launch_classrooms_submenu;
begin
  case show_windows_submenu(mode) of
    submenu_brws :
      if getClassroomsCount <> 0 then
        show_windows_brws_classrooms
      else
        show_windows_message('', 'No classrooms');
    submenu_add  : show_windows_add_classroom;
    submenu_srch : show_windows_srch_classrooms;
    submenu_sort : show_windows_sort_classrooms;
  end;
end;
procedure launch_timetable_submenu;
begin
  case show_windows_submenu(mode) of
    submenu_brws :
      if getEntriesCount <> 0 then
        show_windows_brws_entries
      else
        show_windows_message('', 'No timetable entries');
    submenu_add  :
      if (getTeachersCount = 0) or (getClassroomsCount = 0) then
        show_windows_message('You need at least one teacher', 'and one classroom to create', 'an entry.')
      else
        show_windows_add_entry;
    submenu_srch : show_windows_srch_entries;
    submenu_sort : show_windows_sort_entries;
  end;
end;
begin
  mode := show_windows_main;

  while mode <> exit do
  begin
    case mode of
      menu_load  : show_windows_load;
      menu_save  : show_windows_save;
      menu_tchrs : launch_teachers_submenu;
      menu_rooms : launch_classrooms_submenu;
      menu_ttabl : launch_timetable_submenu;
    end;
    mode := show_windows_main(false);
  end;
end;

procedure free_memory;
begin
  clean_teachers;
  clean_classrooms;
  clean_entries;

  windows_add_classroom_free_memory;
  windows_add_entry_free_memory;
  windows_add_teacher_free_memory;

  windows_brws_teachers_free_memory;
  windows_brws_classrooms_free_memory;
  windows_brws_entries_free_memory;

  windows_srch_teachers_free_memory;
  windows_srch_classrooms_free_memory;
  windows_srch_entries_free_memory;

  windows_sort_teachers_free_memory;
  windows_sort_classrooms_free_memory;
  windows_sort_entries_free_memory;

  windows_greet_free_memory;
  windows_load_free_memory;
  windows_main_free_memory;
  windows_message_free_memory;
  windows_save_free_memory;
  windows_submenu_free_memory;
  windows_delete_dlg_free_memory
end;

begin
  cursoroff;
  TextBackground(c_background);
  ClrScr;

  show_windows_greet;

  launch_window_chain;

  free_memory;
  do_nothing;
end.

