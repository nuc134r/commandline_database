{$INCLUDE settings}
unit db_windows_controls;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  db_basicthings,
  db_constants;

type
  proc = procedure(a : integer);
  TControl = class
  private
    _position: TPosition;
    _size: TSize;
    _focused : boolean;
  public
    property Focused : Boolean read _focused;

    procedure Draw(parent : TPosition); virtual; abstract;
    function  Focus(parent : TPosition): TModalResult; virtual; abstract;
  end;
  TTextBox = class(TControl)
    private
      _max_length : integer;
      _text: string;
    public
      property Text     : string    read _text     write _text;
      property MaxLength : integer read _max_length write _max_length;

      procedure   Draw(parent : TPosition); override;
      function    Focus(parent : TPosition): TModalResult; override;
      constructor Create(Bounds : TBounds; Text_ : string = '');
  end;
  TLabel   = class(TControl)
    private
      _align : TAlign;
      _color : integer;
      _text: string;
    public
      property Text     : string    read _text     write _text;
      property Color : integer read _color write _color;

      procedure   Draw(parent : TPosition); override;
      function    Focus(parent : TPosition): TModalResult; override;
      constructor Create(Bounds : TBounds; Text_ : string = ''; align : TAlign = al_left);
  end;
  TMenu    = class(TControl)
    private
      _items : array of string;
      _index: integer;
    public
      property Index    : integer   read _index    write _index;

      procedure   AddMenuItem(itemText : string);
      procedure   Draw(parent : TPosition); override;
      function    Focus(parent : TPosition): TModalResult; override;
      constructor Create(Bounds : TBounds);
  end;
  TOptions = class(TControl)
    private
      _items : array of string;
      _index: integer;
      _on_change : Proc;
    public
      property Index    : integer   read _index    write _index;
      property OnChange : Proc read _on_change write _on_change;

      procedure   AddItem(itemText : string);
      procedure   ClearItems;
      procedure   Draw(parent : TPosition); override;
      function    Focus(parent : TPosition): TModalResult; override;
      constructor Create(Bounds : TBounds);
  end;
  TNumber  = class(TControl)
    private
      _max : integer;
      _min : integer;
      _numkey_change : integer;
      _index: integer;
    public
      property Index    : integer   read _index    write _index;

      procedure   Draw(parent : TPosition); override;
      function    Focus(parent : TPosition): TModalResult; override;
      constructor Create(Bounds : TBounds; min_, max_ : integer;  NumkeyChange : integer = 10);
  end;
  TDateBox = class(TControl)
    private
      _min_date : TDateTime;
      _max_date : TDateTime;
      _datetime: TDateTime;
    public
      property DateTime : TDateTime read _datetime write _datetime;

      procedure   Draw(parent : TPosition); override;
      function    Focus(parent : TPosition): TModalResult; override;
      constructor Create(Bounds : TBounds; min_date_, max_date_ : TDateTime);
  end;
  TTimeBox = class(TControl)
    private
      _datetime: TDateTime;
    public
      property DateTime : TDateTime read _datetime write _datetime;

      procedure   Draw(parent : TPosition); override;
      function    Focus(parent : TPosition): TModalResult; override;
      constructor Create(Bounds : TBounds);
  end;
  func = function(id : integer) : string;
  TListColumn = record
    legend : string;
    width : integer;
    getItemFunc : func;
  end;
  TListBox = class(TControl)
    private
      _index: integer;
      _columns    : array of TListColumn;
      _count      : integer;
      _cur_page   : integer;
      _pages      : integer;
      _on_change  : proc;
      _can_delete : boolean;
      procedure   setIndex(index : integer);
      function    getPage(index : integer) : integer;
    public
      property    CanDelete : Boolean read _can_delete write _can_delete;
      property    Index     : integer read _index      write setIndex;
      property    Count     : integer read _count      write _count;
      property    CurPage   : integer read _cur_page;
      property    Pages     : integer read _pages;
      property    OnChange  : proc    read _on_change  write _on_change;

      procedure   Draw(parent : TPosition); override;
      function    Focus(parent : TPosition): TModalResult; override;
      constructor Create(Bounds : TBounds);
      procedure   AddColumn(col : TListColumn);
  end;

implementation

uses
  Crt, sysutils, dateutils;

{ TTextBox }

constructor TTextBox.Create(Bounds : TBounds; Text_ : string = '');
begin
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
  _text := Text_;
  _max_length := 255;
end;
procedure   TTextBox.Draw(parent : TPosition);
begin
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y);
  TextBackground(Black);
  ClrScr;
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W, parent.Y + Y);
  TextColor(c_textcolor);
  if Length(_text) > _size.W then
    Write(copy(_text, length(_text) - _size.W + 1, _size.W))
  else
    Write(_text);
end;
function    TTextBox.Focus(parent : TPosition): TModalResult;
var
  c : TKey;
  len : integer;

  function GoodSymbol(c : char) : boolean;
  begin
    if c in [#32..#126, #128..#175, #224..#239] then // Typeable symbols
      Result := true
    else
      Result := false;
  end;
  procedure addSymbol;
  begin
    _text := _text + c.code0;
    len := Length(_text);
    if len > _size.W then
    begin
      gotoxy(1, 1);
      write(copy(_text, len - _size.W + 1, _size.W));
    end
    else
      write(_text[len]);
  end;
  procedure delSymbol;
  begin
    delete(_text, len, 1);
    len := Length(_text);
    if len < _size.W then
    begin
      write(k_backspace.code0);
      write(' ');
      write(k_backspace.code0);
    end
    else
    begin
      gotoxy(1, 1);
      write(copy(_text, len - _size.W + 1, _size.W));
    end;
  end;

begin
  _focused := true;
  Draw(parent);
  cursoron;
  len := Length(_text);
  c := readkey_;
  while (c <> k_escape) and (c <> k_enter) and (c <> k_tab) do
  begin
    if GoodSymbol(c.code0) and (len <> _max_length) then addSymbol;
    if (c = k_backspace) and (len > 0)      then delSymbol;
    c := readkey_;
  end;
  if c = k_enter  then Result := mr_enter;
  if c = k_escape then Result := mr_escape;
  if c = k_tab    then Result := mr_tab;
  cursoroff;
  _focused := false;
end;

{ TLabel }

constructor TLabel.Create(Bounds : TBounds; Text_ : string = ''; align : TAlign = al_left);
begin
  _color := c_textcolor;
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
  _text := Text_;
  _align := align;
end;
procedure   TLabel.Draw(parent : TPosition);
begin
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y);
  TextBackground(c_windowBase);
  ClrScr;
  if Length(_text) > _size.W then _text := copy(_text, length(_text) - _size.W + 1, _size.W);
  case _align of
    al_center : gotoxy((_size.W - Length(_text)) div 2 + 1, 1);
    al_left   : gotoxy(1, 1);
    al_right  : gotoxy(_size.W - Length(_text) + 1, 1);
  end;
  TextColor(_color);
  write(_text);
  TextColor(c_textcolor);
end;
function    TLabel.Focus(parent : TPosition): TModalResult;
begin
  Result := mr_tab;
  parent := parent; // don't ask why
end;

{ TMenu }

constructor TMenu.Create(Bounds : TBounds);
begin
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
  _size.H := Bounds[3];
  _index  := 0;
end;
procedure   TMenu.AddMenuItem(itemText : string);
begin
  SetLength(_items, Length(_items) + 1);
  _items[High(_items)] := itemText;
end;
procedure   TMenu.Draw(parent : TPosition);
var
  i : integer;
begin
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y + H - 1);
  for i := 0 to High(_items) do
  begin
    GotoXY(2, i + 1);
    WriteLn(trim_(_items[i], _size.W - 2));
  end;
end;
function    TMenu.Focus(parent : TPosition): TModalResult;
procedure Launch;
var
  c : TKey;
  new_selected: integer;

  procedure move_selection;
  begin
    if _index <> new_selected then
    begin
      TextBackground(c_windowHeader);
      GotoXY(1, new_selected + 1);
      WriteLn(' ' + trim_(_items[new_selected], _size.W - 1));

      TextBackground(c_windowBase);
      GotoXY(1, _index + 1);
      WriteLn(' ' + trim_(_items[_index], _size.W - 1));

      _index := new_selected;
    end;
  end;

begin
  new_selected := _index;
  repeat
    c := readkey_;
    if (c = k_down) and (_index <> High(_items)) then inc(new_selected);
    if (c = k_up)   and (_index <> 0)            then dec(new_selected);

    move_selection;
  until (c = k_escape) or (c = k_enter);
  if c = k_enter then Focus := mr_enter else Focus := mr_escape;
end;
begin
  _focused := true;
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y + H - 1);
  TextBackground(c_windowHeader);
  GotoXY(1, _index + 1);
  WriteLn(' ' + trim_(_items[_index], _size.W - 1));
  Launch;
  _focused := false;
end;

{ TOptions }

constructor TOptions.Create(Bounds : TBounds);
begin
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
  _index := 0;
end;
procedure   TOptions.AddItem(itemText : string);
begin
  SetLength(_items, Length(_items) + 1);
  _items[High(_items)] := ' ' + itemText;
end;
procedure   TOptions.ClearItems;
begin
  SetLength(_items, 0);
end;
procedure   TOptions.Draw(parent : TPosition);
var
  tmp : string;
begin
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y);
  TextBackground(Black);
  ClrScr;
  with _position, _size do Window(parent.X + X + 1, parent.Y + Y, parent.X + X + W - 2, parent.Y + Y);
  tmp := _items[_index];
  tmp := trim_(' ', ((_size.W - 2 - Length(tmp)) div 2)) + tmp;
  write(trim_(tmp, _size.W - 2, true));
end;
function    TOptions.Focus(parent : TPosition): TModalResult;
var
  tmp : string;
procedure showArrows;
begin
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y);
  TextBackground(c_windowHeader);
  GotoXY(1, 1);       write('<');
  GotoXY(_size.W, 1); write('>');
  TextBackground(Black);
end;
procedure writeItem;
begin
  ClrScr;
  tmp := _items[_index];
  tmp := trim_(' ', ((_size.W - 2 - Length(tmp)) div 2)) + tmp;
  write(tmp);
end;
var
  c : TKey;
begin
  _focused := true;
  showArrows;
  with _position, _size do Window(parent.X + X + 1, parent.Y + Y, parent.X + X + W - 2, parent.Y + Y);
  repeat
    c := readkey_;
    if c = k_right then
    begin
      inc(_index);
      if _index > High(_items) then _index := 0;
      writeItem;
      if _on_change <> nil then _on_change(_index);
    end;
    if c = k_left then
    begin
      dec(_index);
      if _index < 0 then _index := High(_items);
      writeItem;
      if _on_change <> nil then _on_change(_index);
    end;
  until (c = k_tab) or (c = k_enter) or (c = k_escape);
  Draw(parent);
  Result := KeyCodeToModalResult(c);
  _focused := false;
end;

{ TNumber }

procedure   TNumber.Draw(parent : TPosition);
begin
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y);
  TextBackground(Black);
  ClrScr;
  with _position, _size do Window(parent.X + X + 1, parent.Y + Y, parent.X + X + W - 2, parent.Y + Y);
  write(trim_(' ' + IntToStr(_index), _size.W - 2));
end;
function    TNumber.Focus(parent : TPosition): TModalResult;
  procedure showArrows;
  begin
    with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y);
    TextBackground(c_windowHeader);
    GotoXY(1, 1);
    write('<');
    GotoXY(_size.W, 1);
    write('>');
    TextBackground(Black);
  end;
var
  c : TKey;
begin
  _focused := true;
  showArrows;
  with _position, _size do Window(parent.X + X + 1, parent.Y + Y, parent.X + X + W - 2, parent.Y + Y);
  repeat
    c := readkey_;
    if ((c = k_right) or (c = k_up))   and (_index <> _max) then inc(_index);
    if ((c = k_left)  or (c = k_down)) and (_index <> _min) then dec(_index);
    if c.code0 in [#48..#57] then _index := _numkey_change * (ord(c.code0) - ord('0'));
    write(trim_(' ' + IntToStr(_index), _size.W - 2));
  until (c = k_tab) or (c = k_enter) or (c = k_escape);
  Draw(parent);
  Result := KeyCodeToModalResult(c);
  _focused := false;
end;
constructor TNumber.Create(Bounds : TBounds; min_, max_ : integer; NumkeyChange : integer = 10);
begin
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
  _index := 0;
  _min := min_;
  _max := max_;
  _numkey_change := NumkeyChange;
end;

{ TDateBox }

procedure   TDateBox.Draw(parent : TPosition);
begin
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y);
  TextBackground(Black);
  ClrScr;
  with _position, _size do Window(parent.X + X + 1, parent.Y + Y, parent.X + X + W - 2, parent.Y + Y);
  write(trim_(DateToStr(_datetime), _size.W - 2));
end;
function    TDateBox.Focus(parent : TPosition): TModalResult;
var
  mode : integer;
  c : TKey;
  tmp : string;
procedure highlight;
const
  offset : array[1..3] of integer = (1, 4, 7);
begin
  TextBackground(Black);
  TextColor(c_textcolor);
  GotoXY(1, 1);
  write(trim_(DateToStr(_datetime), _size.W - 2));
  TextColor(Black);
  TextBackground(White);
  case mode of
    1 : DateTimeToString(tmp, 'dd', _datetime);
    2 : DateTimeToString(tmp, 'mm', _datetime);
    3 : DateTimeToString(tmp, 'yyyy', _datetime);
  end;
  GotoXY(offset[mode], 1);
  Write(tmp);
end;

begin
  _focused := true;
  with _position, _size do Window(parent.X + X + 1, parent.Y + Y, parent.X + X + W - 2, parent.Y + Y);
  mode := 1;
  c.code0 := #0;
  c.code1 := #0;
  repeat
    if (mode = 1) and (c = k_up)   and (IncDay(_datetime, +1) <= _max_date) then _datetime := IncDay(_datetime, +1);
    if (mode = 1) and (c = k_down) and (IncDay(_datetime, -1) >= _min_date) then _datetime := IncDay(_datetime, -1);
    if (mode = 2) and (c = k_up)   and (IncMonth(_datetime, +1) <= _max_date) then _datetime := IncMonth(_datetime, +1);
    if (mode = 2) and (c = k_down) and (IncMonth(_datetime, -1) >= _min_date) then _datetime := IncMonth(_datetime, -1);
    if (mode = 3) and (c = k_up)   and (IncYear(_datetime, +1) <= _max_date) then _datetime := IncYear(_datetime, +1);
    if (mode = 3) and (c = k_down) and (IncYear(_datetime, -1) >= _min_date) then _datetime := IncYear(_datetime, -1);
    if (c = k_right) and (mode <> 3) then inc(mode);
    if (c = k_left)  and (mode <> 1) then dec(mode);
    highlight;
    c := readkey_;
  until (c = k_escape) or (c = k_tab) or (c = k_enter);

  TextBackground(Black);
  TextColor(c_textcolor);
  GotoXY(1, 1);
  write(trim_(DateToStr(_datetime), _size.W - 2));
  Result := KeyCodeToModalResult(c);
  _focused := false;
end;
constructor TDateBox.Create(Bounds : TBounds; min_date_, max_date_ : TDateTime);
begin
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
  _min_date := min_date_;
  _max_date := max_date_;
end;

{ TTimeBox }

procedure   TTimeBox.Draw(parent : TPosition);
var
  tmp : string;
begin
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y);
  TextBackground(Black);
  ClrScr;
  with _position, _size do Window(parent.X + X + 1, parent.Y + Y, parent.X + X + W - 2, parent.Y + Y);
  DateTimeToString(tmp, 'hh:nn', _datetime);
  write(trim_(tmp, _size.W - 2));
end;
function    TTimeBox.Focus(parent : TPosition): TModalResult;
var
  mode : integer;
  c : TKey;
  tmp : string;
procedure highlight;
const
  offset : array[1..2] of integer = (1, 4);
begin
  TextBackground(Black);
  TextColor(c_textcolor);
  GotoXY(1, 1);
  DateTimeToString(tmp, 'hh:nn', _datetime);
  write(trim_(tmp, _size.W - 2));
  TextColor(Black);
  TextBackground(White);
  case mode of
    1 : DateTimeToString(tmp, 'hh', _datetime);
    2 : DateTimeToString(tmp, 'nn', _datetime);
  end;
  GotoXY(offset[mode], 1);
  Write(tmp);
end;

begin
  _focused := true;
  with _position, _size do Window(parent.X + X + 1, parent.Y + Y, parent.X + X + W - 2, parent.Y + Y);
  mode := 1;
  c.code0 := #0;
  c.code1 := #0;
  repeat
    if (mode = 1) and (c = k_up)   then _datetime := IncHour(_datetime, +1);
    if (mode = 1) and (c = k_down) then _datetime := IncHour(_datetime, -1);
    if (mode = 2) and (c = k_up)   then _datetime := IncMinute(_datetime, +1);
    if (mode = 2) and (c = k_down) then _datetime := IncMinute(_datetime, -1);
    if (c = k_right) and (mode <> 2) then inc(mode);
    if (c = k_left)  and (mode <> 1) then dec(mode);
    highlight;
    c := readkey_;
  until (c = k_escape) or (c = k_tab) or (c = k_enter);

  TextBackground(Black);
  TextColor(c_textcolor);
  GotoXY(1, 1);
  DateTimeToString(tmp, 'hh:nn', _datetime);
  write(trim_(tmp, _size.W - 2));
  Result := KeyCodeToModalResult(c);
  _focused := false;
end;
constructor TTimeBox.Create(Bounds : TBounds);
begin
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
end;

{ TListBox }

function    TListBox.getPage(index : integer) : integer;
var
  per_page : integer;
begin
  per_page := _size.H - 2;
  Result := (index div per_page) + 1;
  //if (index mod per_page) = 0 then dec(Result);
end;
procedure   TListBox.setIndex(index : integer);
var
  per_page : integer;
begin
  per_page := _size.H - 2;

  _index := index;

  _pages := _count div per_page;
  if _count mod per_page <> 0 then inc(_pages);

  _cur_page := getPage(index);
end;
procedure   TListBox.Draw(parent : TPosition);
var
  per_page : integer;
  tmp : string;
  i, j : integer;
begin
  per_page := _size.H - 2;
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y + H - 1);
  tmp := ' ';
  for i := 0 to High(_columns) do tmp += trim_(_columns[i].legend, _columns[i].width);
  TextColor(c_textDimColor);
  TextBackground(c_windowBase);
  write(tmp);
  TextColor(c_textcolor);
  for i := (per_page * (_cur_page - 1)) to (per_page * _cur_page) - 1 do
    if (i >= 0) and (i < _count) then
    begin
      tmp := ' ';
      for j := 0 to High(_columns) do tmp += trim_(_columns[j].getItemFunc(i), _columns[j].width, true);
      GotoXY(1, (i mod per_page) + 2);
      write(tmp);
    end
    else
    begin
      GotoXY(1, (i mod per_page) + 2);
      write(trim_(' ', _size.W));
    end;
end;
function    TListBox.Focus(parent : TPosition): TModalResult;
var
  per_page : integer;
  tmp : string;
function launch : TKey;
var
  sel, page : integer;
  c : TKey;
procedure move_selection;
var
  i : integer;
begin
  if page <> _cur_page then
  begin
    if _on_change <> nil then _on_change(_cur_page);
    Draw(parent);
  end;
  if sel <> _index then
  begin
    if page = _cur_page then
    begin
      tmp := ' ';
      for i := 0 to High(_columns) do tmp += trim_(_columns[i].getItemFunc(sel), _columns[i].width, true);
      GotoXY(1, (sel mod per_page) + 2);
      TextBackground(c_windowBase);
      write(tmp);
    end;
    tmp := ' ';
    for i := 0 to High(_columns) do tmp += trim_(_columns[i].getItemFunc(_index), _columns[i].width, true);
    GotoXY(1, (_index mod per_page) + 2);
    TextBackground(c_windowHeader);
    write(tmp);
  end;
end;
begin
  repeat
    c := readkey_;
    sel  := _index;
    page := _cur_page;
    if (c = k_down)  and (_index <> (_count - 1)) then setIndex(_index + 1);
    if (c = k_up)    and (_index <> 0)            then setIndex(_index - 1);
    if (c = k_right) and (_cur_page <> _pages)    then
    begin
      if (_index + per_page) <= (_count - 1) then
        setIndex(_index + per_page)     //select the next page same pos
      else
        setIndex(per_page * _cur_page); //select first on the next page
    end;
    if (c = k_left)  and (_cur_page <> 1) then setIndex(_index - per_page);
    if (c = k_home) then setIndex(0);
    if (c = k_end)  then setIndex(_count - 1);

    move_selection;
  until (c = k_escape) or (c = k_tab) or (c = k_enter) or ((c = k_delete) and (_can_delete));
  Result := c;
end;
procedure highlight(ind : integer; active : boolean = true);
var
  i : integer;
begin
  tmp := ' ';
  for i := 0 to High(_columns) do tmp += trim_(_columns[i].getItemFunc(ind), _columns[i].width, true);
  GotoXY(1, (ind mod per_page) + 2);
  if active then
    TextBackground(c_windowHeader)
  else
    TextBackground(c_windowBase);
  write(tmp);
end;
begin
  _focused := true;
  per_page := _size.H - 2;
  with _position, _size do Window(parent.X + X, parent.Y + Y, parent.X + X + W - 1, parent.Y + Y + H - 1);
  if _count <> 0 then
  begin
    highlight(_index);
    Result := KeyCodeToModalResult(launch);
    highlight(_index, false);
  end
  else
  begin
    readkey_;
    Result := mr_escape;
  end;
  _focused := false;
end;
procedure   TListBox.AddColumn(col : TListColumn);
begin
  SetLength(_columns, Length(_columns) + 1);
  _columns[High(_columns)] := col;
end;
constructor TListBox.Create(Bounds : TBounds);
begin
  _position.X := Bounds[0];
  _position.Y := Bounds[1];
  _size.W := Bounds[2];
  _size.H := Bounds[3] + 1;
  _index := 0;
end;

end.
