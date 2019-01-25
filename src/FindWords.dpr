program FindWords;

uses
  Forms,
  unit1 in 'unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {frmsummary};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tfrmsummary, frmsummary);
  Application.Run;
end.
