unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus;

type
  Tfrmsummary = class(TForm)
    Memo1: TMemo;
    SaveDialog: TSaveDialog;
    MainMenu1: TMainMenu;
    Save1: TMenuItem;
    procedure Save1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsummary: Tfrmsummary;

implementation

uses unit1;

{$R *.DFM}

procedure Tfrmsummary.Save1Click(Sender: TObject);
begin
 if savedialog.Execute=false then exit;
 memo1.Lines.SaveToFile(savedialog.filename);
 showmessage('File saved')
end;

end.
