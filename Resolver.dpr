program Resolver;

uses
  Forms,
  Main in 'Main.pas' {MainWindow},
  ChartWindow in 'ChartWindow.pas' {CWindow},
  Settings in 'Settings.pas' {SettingsWindow},
  Calculator in 'MathParser\Calculator.pas',
  CalcUtils in 'MathParser\CalcUtils.pas',
  Cipher in 'MathParser\Cipher.pas',
  EventManager in 'MathParser\EventManager.pas',
  EventUtils in 'MathParser\EventUtils.pas',
  FileUtils in 'MathParser\FileUtils.pas',
  FlexibleList in 'MathParser\FlexibleList.pas',
  Graph in 'MathParser\Graph.pas',
  GraphicTypes in 'MathParser\GraphicTypes.pas',
  GraphicUtils in 'MathParser\GraphicUtils.pas',
  License in 'MathParser\License.pas',
  Log in 'MathParser\Log.pas',
  MemoryUtils in 'MathParser\MemoryUtils.pas',
  NotifyManager in 'MathParser\NotifyManager.pas',
  NumberConsts in 'MathParser\NumberConsts.pas',
  NumberUtils in 'MathParser\NumberUtils.pas',
  Numeration in 'MathParser\Numeration.pas',
  ParseCache in 'MathParser\ParseCache.pas',
  ParseCommon in 'MathParser\ParseCommon.pas',
  ParseConsts in 'MathParser\ParseConsts.pas',
  ParseErrors in 'MathParser\ParseErrors.pas',
  ParseField in 'MathParser\ParseField.pas',
  ParseManager in 'MathParser\ParseManager.pas',
  ParseMessages in 'MathParser\ParseMessages.pas',
  ParseMethod in 'MathParser\ParseMethod.pas',
  Parser in 'MathParser\Parser.pas',
  ParseTypes in 'MathParser\ParseTypes.pas',
  ParseUtils in 'MathParser\ParseUtils.pas',
  ParseValidator in 'MathParser\ParseValidator.pas',
  ParseValueList in 'MathParser\ParseValueList.pas',
  SearchUtils in 'MathParser\SearchUtils.pas',
  SyncThread in 'MathParser\SyncThread.pas',
  TextBuilder in 'MathParser\TextBuilder.pas',
  TextConsts in 'MathParser\TextConsts.pas',
  TextList in 'MathParser\TextList.pas',
  TextTypes in 'MathParser\TextTypes.pas',
  TextUtils in 'MathParser\TextUtils.pas',
  Thread in 'MathParser\Thread.pas',
  ThreadUtils in 'MathParser\ThreadUtils.pas',
  ValueConsts in 'MathParser\ValueConsts.pas',
  ValueErrors in 'MathParser\ValueErrors.pas',
  ValueTypes in 'MathParser\ValueTypes.pas',
  ValueUtils in 'MathParser\ValueUtils.pas',
  VariableUtils in 'MathParser\VariableUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainWindow, MainWindow);
  Application.CreateForm(TCWindow, CWindow);
  Application.CreateForm(TSettingsWindow, SettingsWindow);
  MainWindow.Caption := 'Resolver v' + VERSION; 
  Application.Run;
end.
