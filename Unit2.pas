unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, System.Net.URLClient, System.Net.HttpClient, System.JSON,
  System.Net.HttpClientComponent, CategoriaMercadoLivre, System.Generics.Collections,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Datasnap.DBClient, MidasLib;

type
  TForm2 = class(TForm)
    edtCategoryId: TEdit;
    btnGetAttributes: TButton;
    lblCategoryId: TLabel;
    StringGrid1: TStringGrid;
    procedure btnGetAttributesClick(Sender: TObject);
  private
    { Private declarations }
  public
    function getClient(): TNetHTTPClient;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnGetAttributesClick(Sender: TObject);
var
  client: TNetHTTPClient;
  url: String;
  response: String;
  json: TJSONValue;
  jsonArray: TJSONArray;
  jsonComponents: TJSONArray;
  categoryList: TObjectList<TCategoriaMercadoLivre>;
  temp: TCategoriaMercadoLivre;
  element, component: TJSONValue;
  I: Integer;
  dataSource: TDataSource;
  tags: string;
begin
  client := getClient();

  url := 'https://api.mercadolibre.com/categories/'+edtCategoryId.Text+'/technical_specs/input';

  response := client.Get(url).ContentAsString();

  json := TJSONObject.ParseJSONValue(response);
  jsonArray := json.GetValue<TJSONArray>('groups');

  categoryList := TObjectList<TCategoriaMercadoLivre>.Create();
  for element in jsonArray do
  begin
    jsonComponents := element.GetValue<TJSONArray>('components');

    for component in jsonComponents do
    begin
      temp := TCategoriaMercadoLivre.Create();

      temp.id        := component.GetValue<string>('attributes[0].id');
      temp.nome      := component.GetValue<string>('attributes[0].name');
      temp.tipo      := component.GetValue<string>('attributes[0].value_type');




      tags := component.GetValue<TJSONArray>('attributes[0].tags').ToString;
      if ((tags.IndexOf('required') <> -1) or (tags.IndexOf('catalog_required') <> -1)) then
        temp.requerido := true;

      categoryList.Add(temp);
    end;
  end;

  StringGrid1.Cells[0, 0] := 'ID';
  StringGrid1.Cells[1, 0] := 'NOME';
  StringGrid1.Cells[2, 0] := 'TIPO';
  StringGrid1.Cells[3, 0] := 'REQUERIDO';

  StringGrid1.RowCount := 0;
  for I := 0 to categoryList.Count - 1 do
  begin
    StringGrid1.RowCount := StringGrid1.RowCount + 1;

    StringGrid1.Cells[0, i + 1] := categoryList.Items[i].id;
    StringGrid1.Cells[1, i + 1] := categoryList.Items[i].nome;
    StringGrid1.Cells[2, i + 1] := categoryList.Items[i].tipo;

    if categoryList.Items[i].requerido then
      StringGrid1.Cells[3, i + 1] := 'SIM'
    else
      StringGrid1.Cells[3, i + 1] := 'NÃO';
  end;
end;

function TForm2.getClient: TNetHTTPClient;
var
  client: TNetHTTPClient;
begin
  client := TNetHTTPClient.Create(nil);
  client.SecureProtocols := [THTTPSecureProtocol.SSL2, THTTPSecureProtocol.SSL3, THTTPSecureProtocol.TLS1, THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];

  result := client;
end;

end.
