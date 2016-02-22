unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ValueUtils, ComCtrls, CustomizeDlg, Menus,
  Settings, ChartWindow, ExtCtrls, Grids, ValEdit; // my includes


type TTask = packed record
    addParams_Count : Integer;
    savedToFile : Boolean;
    start_t     : string[7];
    final_t     : string[7];
    dt          : string[7];
    name        : ShortString;
    equation_dx : ShortString;
    equation_dy : ShortString;
    start_x     : ShortString;
    start_y     : ShortString;
    additionalParameters : array [0..250] of ShortString;
end;

type
  TMainWindow = class(TForm)
    params: TMemo;
    __info1: TLabel;
    draw_btn: TButton;
    Label2: TLabel;
    Label1: TLabel;
    edt_t: TEdit;
    Label4: TLabel;
    idbg: TMemo;
    pc: TPageControl;
    TabSheet1: TTabSheet;
    tasks: TListBox;
    add_plot: TCheckBox;
    eq1: TEdit;
    eq2: TEdit;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    edt_t1: TEdit;
    edt_dt: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    clear_btn: TButton;
    new_btn: TButton;
    save_btn: TButton;
    del_btn: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    settings_btn: TButton;
    probs: TValueListEditor;
    probtasks: TListBox;
    addOccasion_btn: TButton;
    delOccasion_btn: TButton;
    renOccasion_btn: TButton;
    setCustomDistr_btn: TButton;
    addProbTask_btn: TButton;
    saveProbTask_btn: TButton;
    Bevel1: TBevel;
    delProbTask_btn: TButton;
    procedure draw_btnClick(Sender: TObject);
    procedure clear_btnClick(Sender: TObject);
    procedure tasksClick(Sender: TObject);
    procedure new_btnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure save_btnClick(Sender: TObject);
    procedure del_btnClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure settings_btnClick(Sender: TObject);
    procedure probtasksClick(Sender: TObject);
  private
    { Private declarations }
  public
    att_separator : string;
    unsaved_tasks : array [0..63] of TTask;
    unsaved_count : Integer;
    gstorage : string;
  end;

const VERSION = '0.2';

const EXT_DE = '.detsk';
const EXT_DE_WP = 'detsk';
const EXT_P = '.prob';
const EXT_P_WP = 'prob';

var MainWindow: TMainWindow;

implementation

{$R *.dfm}

procedure sinf(s : string);
var sa : array [0..1] of string;
    i : Integer;
    save_strs : Integer;
begin
    save_strs := 2;
    if MainWindow.idbg.Lines.Count < 1000 then
    begin
        MainWindow.idbg.Lines.Add(s);
        Exit;
    end;
    for i := 0 to save_strs-1 do
        sa[i] := MainWindow.idbg.Lines.Strings[MainWindow.idbg.Lines.count - (save_strs - i)];
    MainWindow.idbg.Lines.Clear;
    for i := 0 to save_strs-1 do
        MainWindow.idbg.Lines.Add(sa[i]);
end;

function FoundUnsavedTask(taskname : string):Integer;
var i : Integer;
begin
    for i := 0 to MainWindow.unsaved_count do
    if MainWindow.unsaved_tasks[i].name = taskname then
    begin
        FoundUnsavedTask := i;
        Exit;
    end;
    FoundUnsavedTask := -1;
end;

function UnsavedNameToSaved(s : string): string;
begin
    UnsavedNameToSaved := copy(s, 2, length(s)-2);
end;

function LoadTask(taskname : string) : TTask;
var f : file of TTask;
    task : TTask;
begin
    if not FileExists(MainWindow.gstorage + '/' + taskname + EXT_DE) then
    begin
        LoadTask := task;
        Exit;
    end;
    Assign(f, MainWindow.gstorage + '/' + taskname + EXT_DE);
    Reset(f);
    Read(f, task);
    CloseFile(f);
    LoadTask := task;
end;

procedure LoadAll;
var t : TSearchRec;
begin
    if FindFirst(MainWindow.gstorage + '\*' + EXT_DE,
        faAnyFile - faDirectory, t) = 0 then
    repeat
        MainWindow.tasks.AddItem(copy(t.name, 1, pos(EXT_DE_WP, t.name)-2), nil);
    until FindNext(t) <> 0;
    FindClose(t);
end;

function MakeTask(taskname : string) : TTask;
var task : TTask;
    i : Integer;
begin
    with task do
    begin
        name := taskname;
        equation_dx := MainWindow.eq1.Text;
        equation_dy := MainWindow.eq2.Text;
        start_x := MainWindow.Edit1.Text;
        start_y := MainWindow.Edit2.Text;
        start_t := MainWindow.edt_t.Text;
        final_t := MainWindow.edt_t1.Text;
        dt := MainWindow.edt_dt.Text;
        savedToFile := False;
        addParams_Count := MainWindow.params.Lines.Count;
        for i := 0 to MainWindow.params.Lines.Count - 1 do
            additionalParameters[i] := MainWindow.params.Lines.Strings[i];
    end;
    MakeTask := task;
end;

procedure FillInterface(task : TTask);
var i : Integer;
begin
    MainWindow.eq1.Text := task.equation_dx;
    MainWindow.eq2.Text := task.equation_dy;
    MainWindow.Edit1.Text := task.start_x;
    MainWindow.Edit2.Text := task.start_y;
    MainWindow.edt_t.Text := task.start_t;
    MainWindow.edt_t1.Text := task.final_t;
    MainWindow.edt_dt.Text := task.dt;
    MainWindow.params.Clear;
    for i := 0 to task.addParams_Count-1 do
        MainWindow.params.Lines.Add(task.additionalParameters[i]);
end;

function CheckName(s : string) : Boolean;
var i : integer;
begin
    // unsaved:
    for i:=0 to MainWindow.unsaved_count do
        if MainWindow.unsaved_tasks[i].name = s then
        begin
            CheckName := False;
            Exit;
        end;
    // saved:
    if FileExists(MainWindow.gstorage + '/' + s + EXT_DE) then
    begin
        CheckName := False;
        Exit;
    end;
    CheckName := True;
end;

procedure InsertUnsavedTask(task : TTask);
var i : Integer;
begin
    for i := 0 to MainWindow.unsaved_count do
        if MainWindow.unsaved_tasks[i].name = '' then
        begin
            MainWindow.unsaved_tasks[i] := task;
            inc(MainWindow.unsaved_count);
            Exit;
        end;
end;

procedure DeleteUnsavedTask(taskname : string);
var i : Integer;
begin
    for i := 0 to MainWindow.unsaved_count-1 do
        if MainWindow.unsaved_tasks[i].name = taskname then
        begin
            MainWindow.unsaved_tasks[i].name := '';
            dec(MainWindow.unsaved_count);
            Exit;
        end;
end;

function isAlreadySaved(name : string):Boolean;
var t : TSearchRec;
begin
    if FindFirst(MainWindow.gstorage + '\' + name + EXT_DE,
        faAnyFile - faDirectory, t) = 0 then
    begin
        FindClose(t);
        isAlreadySaved := True;
        Exit;
    end;
    FindClose(t);
    isAlreadySaved := False;
end;

function GetTaskCount : Integer;
var i : Integer;
    fc : TSearchRec;
begin
    i := 0;
    if FindFirst(MainWindow.gstorage + '\*' + EXT_DE,
        faAnyFile - faDirectory, fc) = 0 then
    repeat
        inc(i);
    until FindNext(fc) <> 0;
    FindClose(fc);
    GetTaskCount := i;
end;

procedure SaveTask(task : TTask);
var f : file of TTask;
begin    
    Assign(f, MainWindow.gstorage + '\' + task.name + EXT_DE);
    Rewrite(f);
    Write(f, task);
    CloseFile(f);
end;

procedure DeleteTask(taskname : string);
begin
    if FileExists(MainWindow.gstorage + '\' + taskname + EXT_DE) then
        DeleteFile(MainWindow.gstorage + '\' + taskname + EXT_DE);
end;

procedure Nullify(task : TTask);
begin
    task.name := '';
    task.addParams_Count := 0;
    task.savedToFile := False;
    task.equation_dx := '';
    task.equation_dy := '';
    task.start_x := '';
    task.start_y := '';
    task.start_t := '';
    task.final_t := '';
    task.dt := '';
end;

procedure _getparams;
var i, j: integer;
    _vr, _vl : String;
    aeq : Boolean;
begin
    for i := 0 to MainWindow.params.Lines.Count-1 do
    begin
        _vr := '';
        _vl := '';
        aeq := True;
        for j := 1 to length(MainWindow.params.Lines.Strings[i]) do
        begin
            if MainWindow.params.Lines.Strings[i][j] = ' ' then
                Continue;
            if MainWindow.params.Lines.Strings[i][j] = '=' then
            begin
                aeq := False;
                Continue;
            end;
            if aeq then
                _vr := _vr + MainWindow.params.Lines.Strings[i][j]
            else
                _vl := _vl + MainWindow.params.Lines.Strings[i][j];
        end;
        if (_vr <> 'x') and (_vr <> 'y') and (_vr <> 't') and (_vr <> 'dt') then
        try
            CWindow.calc.ItemValue[_vr] := _vl;
        except
            sinf('Error setting value for parameter #' + IntToStr(i) +
                ': ' + _vr + '=' + _vl);
            continue;
        end
        else sinf('Reserved parameter name: ' + _vr);
    end;
end;

procedure TMainWindow.draw_btnClick(Sender: TObject);
var i, j, _ax, _ay: integer;
    edt : TEdit;
    value : string;
begin
    MainWindow.att_separator := ';';
    if MainWindow.edt_t.Text <> '' then CWindow.t0 := StrToFloat(edt_t.Text);  //
    if MainWindow.edt_t1.Text <> '' then CWindow.t1 := StrToFloat(edt_t1.Text); // time range
    if MainWindow.edt_dt.Text <> '' then CWindow.dt := StrToFloat(edt_dt.Text); //
    // GatherSettings;
    value := ''; _ax := 0;
    if Edit1.Text <> '' then  // loop for initial conditions for x
    begin
        for i := 1 to length(Edit1.text) do
            if Edit1.Text[i] = MainWindow.att_separator then
            begin
                inc(_ax);
                CWindow.x_attempts[_ax] := StrToFloat(value);
                value := '';
            end
            else value := value + Edit1.Text[i];
        if value <> '' then
        begin
            inc(_ax);
            CWindow.x_attempts[_ax] := StrToFloat(value);
        end;
    end;
    value := ''; _ay := 0;
    if Edit2.Text <> '' then // for initial conditions for y
    begin
        for j := 1 to length(Edit2.text) do
            if Edit2.Text[j] = MainWindow.att_separator then
            begin
                inc(_ay);
                CWindow.y_attempts[_ay] := StrToFloat(value);
                value := '';
            end
            else value := value + Edit2.Text[j];
        if value <> '' then
        begin
            inc(_ay);
            CWindow.y_attempts[_ay] := StrToFloat(value);
        end;
    end;
    value := '';
    if (eq1.Text = '') and (eq2.Text = '') then Exit;
    if _ax <> _ay then
    begin
        sinf('### Error! Count of initial condition is different for x and y');
        Exit;
    end;
    CWindow.att_count := _ax;
    CWindow.calc.ItemValue['x'] := FloatToStr(CWindow.x_attempts[1]);
    CWindow.calc.ItemValue['y'] := FloatToStr(CWindow.y_attempts[1]);
    CWindow.calc.ItemValue['t'] := FloatToStr(CWindow.t0);
    _getparams;
    CWindow.eqs_count := 0;
    for i := 0 to GroupBox1.ControlCount-1 do
    begin
        edt := (GroupBox1.Controls[i] as TEdit);
        if edt.Text <> '' then
        with CWindow.calc.Parser do
        begin
            inc(CWindow.eqs_count);
            StringToScript(edt.Text, CWindow.eqs[i+1]); // first, compile expression into bytecode
            //Optimize(CWindow.eqs[i+1]); // can cause problems
            Execute(CWindow.eqs[i+1]); // thats how we find potential errors :)
        end;
    end;
    CWindow.add_p := MainWindow.add_plot.Checked;
    if MainWindow.tasks.ItemIndex >= 0 then
        sinf('Task: ' + '"' + MainWindow.tasks.Items[MainWindow.tasks.ItemIndex] + '"');
    sinf('Time passed (ms): ' + IntToStr(CWindow.Draw_Series));
    sinf('Points on plot: ' + FloatToStr(CWindow.Chart1.Series[0].Count));
    CWindow.Visible := True;
end;

procedure TMainWindow.clear_btnClick(Sender: TObject);
var i : integer;
begin
    for i := 0 to CWindow.Chart1.SeriesCount-1 do
    begin
        CWindow.Chart1.Series[i].Clear;
        CWindow.Chart1.Series[i].RefreshSeries;
    end;
end;


procedure TMainWindow.tasksClick(Sender: TObject);
var num, a: Integer;
    task : TTask;
begin
    num := MainWindow.tasks.ItemIndex;
    if num >= 0 then
    begin
        a := FoundUnsavedTask(UnsavedNameToSaved(MainWindow.tasks.Items[num]));
        if a >= 0 then
            task := MainWindow.unsaved_tasks[a]
        else
            if num < GetTaskCount then
                task := LoadTask(MainWindow.tasks.Items[num])
            else
            begin
                MainWindow.tasks.Items.Delete(num);
                Exit;
            end;
        FillInterface(task);
    end;
end;

procedure TMainWindow.new_btnClick(Sender: TObject);
var name : string;
    task : TTask;
begin
    name := InputBox('Enter task name:', '', '');
    if name <> '' then
    begin
        MainWindow.tasks.AddItem('*' + name + '*', nil);
        MainWindow.tasks.Selected[MainWindow.tasks.Count-1] := True;
        //Nullify(task);
        task.name := name;
        InsertUnsavedTask(task);
    end;
end;

procedure TMainWindow.save_btnClick(Sender: TObject);
var name : String[127];
    task : TTask;
begin
    if MainWindow.tasks.ItemIndex = -1 then
        begin
            MainWindow.tasks.AddItem(name, nil);
            MainWindow.tasks.Selected[MainWindow.tasks.Count-1] := True;
            task := MakeTask(name);
            task.savedToFile := True;
            SaveTask(task);
        end
        else
        begin
            if not isAlreadySaved(MainWindow.tasks.Items[MainWindow.tasks.ItemIndex]) then
                MainWindow.tasks.Items[MainWindow.tasks.ItemIndex] :=
                    UnsavedNameToSaved(MainWindow.tasks.Items[MainWindow.tasks.ItemIndex]);
            task := MakeTask(MainWindow.tasks.Items[MainWindow.tasks.ItemIndex]);
            task.savedToFile := True;
            SaveTask(task);
            DeleteUnsavedTask(name);
        end
end;

procedure TMainWindow.del_btnClick(Sender: TObject);
var a, num, result: Integer;
begin
    num := MainWindow.tasks.ItemIndex;
    if num >= 0 then
    begin
        result := MessageDlg('Are you sure you want to remove task?',
            mtConfirmation, [mbYes, mbCancel], 0);
        if result = mrYes then
        begin
            a := FoundUnsavedTask(UnsavedNameToSaved(MainWindow.tasks.Items[num]));
            if a >= 0 then
                MainWindow.unsaved_tasks[a].name := ''
            else
                DeleteTask(MainWindow.tasks.Items[num]);
            MainWindow.tasks.DeleteSelected;
            if MainWindow.tasks.Count-1 >= 0 then
                MainWindow.tasks.Selected[MainWindow.tasks.Count-1] := True;
        end;
    end;
end;


procedure TMainWindow.FormCreate(Sender: TObject);
begin
    ///////////////////////////////////////////////////////
    MainWindow.gstorage := '.\data';
    if not DirectoryExists(MainWindow.gstorage) then
        MkDir(MainWindow.gstorage);
    LoadAll;
    ///////////////////////////////////////////////////////
end;

procedure TMainWindow.N2Click(Sender: TObject);
begin
    ShowMessage('Program version: ' + VERSION + #13#10'Mathparser can be found here: http://www.mathparser.net');
end;

procedure TMainWindow.N1Click(Sender: TObject);
begin
    // SettingsWindow.Show;
end;

procedure TMainWindow.settings_btnClick(Sender: TObject);
begin
    // SettingsWindow.Show;
end;

procedure TMainWindow.probtasksClick(Sender: TObject);
var num : integer;
    a : integer;
    task : TTask;
begin
    num := MainWindow.probtasks.ItemIndex;
    if num >= 0 then
    begin
        a := FoundUnsavedTask(UnsavedNameToSaved(MainWindow.tasks.Items[num]));
        if a >= 0 then
            task := MainWindow.unsaved_tasks[a]
        else
            if num < GetTaskCount then
                task := LoadTask(MainWindow.tasks.Items[num])
            else
            begin
                MainWindow.tasks.Items.Delete(num);
                Exit;
            end;
        FillInterface(task);
    end;
end;

end.

