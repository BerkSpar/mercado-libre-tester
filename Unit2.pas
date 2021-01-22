unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, System.Net.URLClient, System.Net.HttpClient, System.JSON,
  System.Net.HttpClientComponent;

type
  TForm2 = class(TForm)
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    NetHTTPClient1: TNetHTTPClient;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
var
  response: String;
  url: String;
  client: TNetHTTPClient;
  json: TJSONValue;
  i: integer;
begin
  client := TNetHTTPClient.Create(nil);
  client.SecureProtocols := [THTTPSecureProtocol.SSL2, THTTPSecureProtocol.SSL3, THTTPSecureProtocol.TLS1, THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];

  url := 'https://api.mercadolibre.com/sites/MLB/categories';

  response := client.Get(url).ContentAsString();

  json := TJSONObject.ParseJSONValue(response);

  i := 0;
  while i < 31 do
  begin
    ComboBox1.AddItem(json.GetValue<string>('['+i.ToString+'].name'), TObject(json.GetValue<string>('['+i.ToString+'].id')));

    i := i + 1;
  end;

end;

end.
