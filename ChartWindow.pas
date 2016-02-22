unit ChartWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, Calculator, Parser,
  ParseTypes, ValueTypes;
type
  TCWindow = class(TForm)
    Chart1: TChart;
    default_srs: TPointSeries;
    procedure FormCreate(Sender: TObject);
    function Draw_Series : Integer;
  private
    { Private declarations }
  public
    calc : TCalculator;
    t0, t1, dt : Double;
    eqs : array [1..10] of TScript;
    eqs_count : Integer;
    add_p : Boolean;
    x_attempts : array [1..1024] of Double;
    y_attempts : array [1..1024] of Double;
    att_count : Integer;
  end;

var
  CWindow: TCWindow;

implementation

uses ValueUtils;

{$R *.dfm}

procedure TCWindow.FormCreate(Sender: TObject);
begin
    CWindow.calc := TCalculator.Create(Self);
end;

function TCWindow.Draw_Series : Integer;
var x, y, t: Double;
    tc : Int64;
    attempt : integer;
begin
    if not CWindow.add_p then
    begin
        CWindow.Chart1.Series[0].Clear;
        CWindow.Chart1.Series[0].Repaint;       // trying to fix strange bug with
        CWindow.Chart1.Series[0].RefreshSeries; // list index out of bounds

    end;
    tc := GetTickCount;
    case CWindow.eqs_count of
    1: for attempt := 1 to CWindow.att_count do
        begin
            t := CWindow.t0;
            x := CWindow.x_attempts[attempt];
            CWindow.calc.ItemValue['x'] := FloatToStr(x);
            while t < CWindow.t1 do
            begin
                x := x + CWindow.dt *
                    Convert(CWindow.calc.Parser.Execute(CWindow.eqs[2])^, vtDouble).Float64;
                CWindow.Chart1.Series[0].AddXY(CWindow.t0, x);
                CWindow.calc.ItemValue['x'] := FloatToStr(x);
                t := t + CWindow.dt;
            end;
        end;
    2: for attempt := 1 to CWindow.att_count do
        begin
            t := CWindow.t0;
            x := CWindow.x_attempts[attempt];
            y := CWindow.y_attempts[attempt];
            CWindow.calc.ItemValue['t'] := FloatToStr(t);
            CWindow.calc.ItemValue['x'] := FloatToStr(x);
            CWindow.calc.ItemValue['y'] := FloatToStr(y);
            CWindow.Chart1.Series[0].AddXY(x, y);
            while t < CWindow.t1 do
            begin
                t := t + CWindow.dt;
                CWindow.calc.ItemValue['t'] := FloatToStr(t);
                x := x + CWindow.dt *
                    Convert(CWindow.calc.Parser.Execute(CWindow.eqs[1])^, vtDouble).Float64;
                y := y + CWindow.dt *
                    Convert(CWindow.calc.Parser.Execute(CWindow.eqs[2])^, vtDouble).Float64;
                CWindow.Chart1.Series[0].AddXY(x, y);
                CWindow.calc.ItemValue['x'] := FloatToStr(x);
                CWindow.calc.ItemValue['y'] := FloatToStr(y);
            end;
        end;
    end;// -> case
    Draw_Series := GetTickCount - tc;
end;

end.
