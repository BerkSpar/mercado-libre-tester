unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, IdBaseComponent, ShellApi,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, System.JSON,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    edtClient: TEdit;
    lblClient: TLabel;
    edtSecret: TEdit;
    lblSecret: TLabel;
    edtCode: TEdit;
    lblCode: TLabel;
    edtRedirectUri: TEdit;
    lblRedirectUri: TLabel;
    edtGetToken: TButton;
    btnGetCode: TButton;
    edtToken: TEdit;
    lblToken: TLabel;
    edtRefreshToken: TEdit;
    lblRefreshToken: TLabel;
    btnRefresh: TButton;
    Bevel1: TBevel;
    memReqProduct: TMemo;
    btnPostProduct: TButton;
    memResProduct: TMemo;
    NetHTTPClient1: TNetHTTPClient;
    memResponse: TMemo;
    btnParseJSON: TButton;
    btnCategories: TButton;
    procedure edtGetTokenClick(Sender: TObject);
    procedure btnTestSSLClick(Sender: TObject);
    procedure btnPostProductClick(Sender: TObject);
    procedure btnParseJSONClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnGetCodeClick(Sender: TObject);
    procedure btnCategoriesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm1.btnCategoriesClick(Sender: TObject);
begin
  Form2.ShowModal();
end;

procedure TForm1.btnGetCodeClick(Sender: TObject);
var
  url: String;
begin
  url := 'http://auth.mercadolivre.com.br/authorization?response_type=code&client_id='+edtClient.Text+'&redirect_uri='+edtRedirectUri.Text;

  ShellExecute(Handle, 'open', PWideChar(url), '', '', 1);
end;

procedure TForm1.btnParseJSONClick(Sender: TObject);
var
  json: TJSONValue;
begin
  json := TJSONObject.ParseJSONValue(memResponse.Text);

  edtToken.Text := json.GetValue<string>('access_token');
  edtRefreshToken.Text  := json.GetValue<string>('refresh_token');
end;

procedure TForm1.btnPostProductClick(Sender: TObject);
var
  response: String;
  json: TStringStream;
  client: TNetHTTPClient;
begin
  client := TNetHTTPClient.Create(nil);

  client.SecureProtocols := [THTTPSecureProtocol.SSL2, THTTPSecureProtocol.SSL3, THTTPSecureProtocol.TLS1, THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];
  client.CustomHeaders['Authorization'] := 'Bearer ' + edtToken.Text;

  json := TStringStream.Create(UTF8Encode(memReqProduct.Text));

  response := client.Post('https://api.mercadolibre.com/items', json).ContentAsString(TEncoding.UTF8);

  memResProduct.Text := response;
end;

procedure TForm1.btnRefreshClick(Sender: TObject);
var
  client: TNetHTTPClient;
  response: IHTTPResponse;
  body: TStringStream;
  url: String;
begin
  url := 'https://api.mercadolibre.com/oauth/token?grant_type=refresh_token&client_id='+edtClient.Text+'&client_secret='+edtSecret.Text+'&refresh_token=' + edtRefreshToken.Text;

  client := TNetHTTPClient.Create(nil);

  client.SecureProtocols := [THTTPSecureProtocol.SSL2, THTTPSecureProtocol.SSL3, THTTPSecureProtocol.TLS1, THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];
  client.ContentType := 'application/x-www-form-urlencoded';

  body := TStringStream.Create(nil);

  response := client.Post(url, body);

  memResponse.Text := response.ContentAsString();

  if response.StatusCode = 200 then
    btnParseJSON.Click();
end;

procedure TForm1.btnTestSSLClick(Sender: TObject);
var
  response: string;
  lHTTP: TIdHTTP;
begin
  lHTTP := TIdHTTP.Create(nil);
  try
    lHTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(lHTTP);
    lHTTP.HandleRedirects := True;
    response := lHTTP.Get('https://esta.cbp.dhs.gov/esta/');
    ShowMessage(response);
  finally
    lHTTP.Free;
  end;
end;

procedure TForm1.edtGetTokenClick(Sender: TObject);
var
  requestBody: TStringList;
  client: TNetHTTPClient;
  response: IHTTPResponse;
begin
  client := TNetHTTPClient.Create(nil);

  client.SecureProtocols := [THTTPSecureProtocol.SSL2, THTTPSecureProtocol.SSL3, THTTPSecureProtocol.TLS1, THTTPSecureProtocol.TLS11, THTTPSecureProtocol.TLS12];
  client.ContentType := 'application/x-www-form-urlencoded';

  requestBody := TStringList.Create;

  requestBody.Add('grant_type=authorization_code');
  requestBody.Add('code=' + edtCode.Text);
  requestBody.Add('redirect_uri=' + edtRedirectUri.Text);
  requestBody.Add('client_id=' + edtClient.Text);
  requestBody.Add('client_secret=' + edtSecret.Text);

  response := client.Post('https://api.mercadolibre.com/oauth/token', requestBody);

  memResponse.Text := response.ContentAsString();

  if response.StatusCode = 200 then
    btnParseJSON.Click();
end;

end.
