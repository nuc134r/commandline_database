{$INCLUDE settings}
unit db_windows_srch_teachers;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  db_windows,
  db_basicthings,
  db_windows_controls,
  db_search,
  db_constants,
  db_windows_add_teacher;

procedure show_windows_srch_teachers;
procedure windows_srch_teachers_free_memory;

implementation

var
  srch_window     : TWindow;
  query_textbox   : TTextBox;
  count_label, page_label : TLabel;
  results_listbox : TListBox;

procedure update_page(num : integer);
begin
  page_label.Text := 'Page ' + IntToStr(num) + ' of ' + IntToStr(results_listbox.Pages);
  page_label.Draw(srch_window.Position);
end;

procedure show_windows_srch_teachers;
var
  result : TModalResult;
  count : integer;
begin
  results_listbox.Count := 0;
  count_label.Text := '';
  page_label.Text := 'Page 1 of 0';

  srch_window.Draw;

  result := srch_window.Focus;
  while result <> mr_escape do
  begin
    if (query_textbox.Text <> '') and (srch_window.FocusedControl = 0) and (result = mr_enter) then
    begin
      count := search_teachers(query_textbox.Text);
      count_label.Text := 'Found ' + IntToStr(count) + ' item(s) by the query ''' + query_textbox.Text + '''';
      count_label.Draw(srch_window.Position);
      results_listbox.Count := count;
      results_listbox.Index := 0;
      results_listbox.Draw(srch_window.Position);
      update_page(results_listbox.CurPage);
    end;
    if (results_listbox.Count <> 0) and (srch_window.FocusedControl = 2) and (result = mr_enter) then
    begin
      srch_window.Hide;
      show_windows_add_teacher(StrToInt(get_results_teacher_id(results_listbox.Index)) - 1);
      srch_window.Draw;
    end;
    result := srch_window.Focus(srch_window.FocusedControl);
  end;

  srch_window.Hide;
end;

procedure windows_srch_teachers_free_memory;
begin
  srch_window.Free;
  query_textbox.Free;
  count_label.Free;
  page_label.Free;
  results_listbox.Free;
end;

const
  srch_window_bounds     : TBounds = (21, 2, 59, 23);
  query_textbox_bounds   : TBounds = (1, 2, 57, 0);
  count_label_bounds     : TBounds = (1, 3, 57, 0);
  page_label_bounds      : TBounds = (37, 22, 22, 0);
  results_listbox_bounds : TBounds = (0, 5, 59, 17);
  num_col_width = 4;
  nam_col_width = 18;
  sur_col_width = 18;
  pat_col_width = 18;

var
  num_col, nam_col, sur_col, pat_col : TListColumn;

procedure set_columns;
begin
  num_col.legend      := '#';
  num_col.width       := num_col_width;
  num_col.getItemFunc := @get_results_teacher_id;

  nam_col.legend      := 'Name';
  nam_col.width       := nam_col_width;
  nam_col.getItemFunc := @get_results_teacher_name;

  sur_col.legend      := 'Surame';
  sur_col.width       := sur_col_width;
  sur_col.getItemFunc := @get_results_teacher_surname;

  pat_col.legend      := 'Patronymic';
  pat_col.width       := pat_col_width;
  pat_col.getItemFunc := @get_results_teacher_patronymic;

  results_listbox.AddColumn(num_col);
  results_listbox.AddColumn(sur_col);
  results_listbox.AddColumn(nam_col);
  results_listbox.AddColumn(pat_col);
end;

begin
  srch_window := TWindow.Create(srch_window_bounds, 'Search teachers');

  query_textbox := TTextBox.Create(query_textbox_bounds);

  count_label := TLabel.Create(count_label_bounds, '', al_left);

  results_listbox := TListBox.Create(results_listbox_bounds);
  results_listbox.Index := 0;
  results_listbox.OnChange := @update_page;

  set_columns;

  page_label := TLabel.Create(page_label_bounds, '', al_right);
  page_label.Color := c_textDimColor;

  srch_window.AddControl(query_textbox);
  srch_window.AddControl(count_label);
  srch_window.AddControl(results_listbox);
  srch_window.AddControl(page_label);
end.

