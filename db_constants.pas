{$INCLUDE settings}
unit db_constants;

{$mode objfpc}{$H+}

interface

uses crt;

type
  {****s* db_constants/TKey
   *  DESCRIPTION
   *    Structure for storing two-byte key codes.
   *  SOURCE
   *}
  TKey = record
    code0, code1 : char;
  end;
  {******}

const
  { ---=== CODE PERFECTNESS ===--- }
  active   = true;
  inactive = false;

  yes      = true;
  no       = false;

  { ---=== SCREEN ===--- }
  scr_w = 80;
  scr_h = 25;

  { ---=== COLORS ===--- }
  c_background   = Cyan;
  c_windowBase   = LightGray;
  c_windowHeader = Green;
  c_textcolor    = White;
  c_textDimColor = DarkGray;

  { ---=== KEYS ===--- }
  {****d* db_constants/k_*
   *  DESCRIPTION
   *    Constants for few keyboard keys.
   *  SOURCE
   *}
  k_backspace : TKey = (code0 : #8;  code1 : #0 );
  k_escape    : TKey = (code0 : #27; code1 : #0 );
  k_tab       : TKey = (code0 : #9;  code1 : #0 );
  k_delete    : TKey = (code0 : #0;  code1 : #83);
  k_home      : TKey = (code0 : #0;  code1 : #71);
  k_end       : TKey = (code0 : #0;  code1 : #79);

  k_up        : TKey = (code0 : #0;  code1 : #72);
  k_down      : TKey = (code0 : #0;  code1 : #80);
  k_right     : TKey = (code0 : #0;  code1 : #77);
  k_left      : TKey = (code0 : #0;  code1 : #75);

  k_space     : TKey = (code0 : #32; code1 : #0 );
  k_enter     : TKey = (code0 : #13; code1 : #0 );
  {******}
  { ---=== SOME CONTROLS OUTPUT ===--- }
  out_escape = -1;
  out_tab    =  0;
  out_enter  =  1;

operator = (a, b : TKey) c : boolean;

implementation

operator = (a, b : TKey) c : boolean;
begin
  c := (a.code0 = b.code0) and (a.code1 = b.code1);
end;

end.

