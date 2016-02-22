{ *********************************************************************** }
{                                                                         }
{ TextConsts                                                              }
{                                                                         }
{ Copyright (c) 2007 Pisarev Yuriy (mail@pisarev.net)                     }
{                                                                         }
{ *********************************************************************** }

unit TextConsts;

interface

const
  Ampersand = '&';
  Backslash = '\';
  Colon = ':';
  Comma = ',';
  CarriageReturn = #13;
  Dollar = '$';
  Dot = '.';
  DoubleQuote = '"';
  DoubleSlash = '//';
  Equal = '=';
  Exclamation = '!';
  Greater = '>';
  Inquiry = '?';
  LeftBrace = '{';
  LeftBracket = '[';
  LeftParenthesis = '(';
  Less = '<';
  LineFeed = #10;
  Minus = '-';
  Percent = '%';
  Pipe = '|';
  Plus = '+';
  Pound = '#';
  Quote = '''';
  RightBrace = '}';
  RightBracket = ']';
  RightParenthesis = ')';
  Semicolon = ';';
  Slash = '/';
  Space = ' ';
  Tilde = '~';

  Blanks = [Space, CarriageReturn, LineFeed];
  Breaks = [CarriageReturn, LineFeed];

implementation

end.
