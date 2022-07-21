unit uprincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  index: integer;
  lista: TStringList;
begin

  // cria lista somente para teste de demonstração
  lista := TStringList.Create();

  with FDQuery1 do
  begin
    // inserindo registros em lotes
    close;
    sql.Clear;
    sql.Add('insert into tabela (campo1, campo2) values (:valor1, :valor2)');

  end;

  // setar tamanho do array
  FDQuery1.Params.ArraySize := lista.Count;

  // insere valore da lista nos parametros no colocando na posição destacada
  for index := 0 to Pred(lista.Count) do
  begin
    FDQuery1.ParamByName('valor1').AsStrings[index] := lista[index];
    FDQuery1.ParamByName('valor2').AsStrings[index] := lista[index];
  end;

  // executar sql
  FDQuery1.Execute(lista.Count, 0);
end;

end.
