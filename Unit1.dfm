object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 402
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblClient: TLabel
    Left = 8
    Top = 4
    Width = 40
    Height = 13
    Caption = 'Client Id'
  end
  object lblSecret: TLabel
    Left = 8
    Top = 47
    Width = 44
    Height = 13
    Caption = 'Secret Id'
  end
  object lblCode: TLabel
    Left = 8
    Top = 90
    Width = 25
    Height = 13
    Caption = 'Code'
  end
  object lblRedirectUri: TLabel
    Left = 8
    Top = 133
    Width = 56
    Height = 13
    Caption = 'Redirect Uri'
  end
  object lblToken: TLabel
    Left = 317
    Top = 4
    Width = 29
    Height = 13
    Caption = 'Token'
  end
  object lblRefreshToken: TLabel
    Left = 317
    Top = 47
    Width = 70
    Height = 13
    Caption = 'Refresh Token'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 176
    Width = 526
    Height = 9
  end
  object edtClient: TEdit
    Left = 8
    Top = 20
    Width = 105
    Height = 21
    TabOrder = 0
    Text = '7690978064541216'
  end
  object edtSecret: TEdit
    Left = 8
    Top = 63
    Width = 217
    Height = 21
    TabOrder = 1
    Text = 'uZN0K0yBNQKKAYrXExbV97mou5zhX2kR'
  end
  object edtCode: TEdit
    Left = 8
    Top = 106
    Width = 217
    Height = 21
    TabOrder = 2
  end
  object edtRedirectUri: TEdit
    Left = 8
    Top = 149
    Width = 217
    Height = 21
    TabOrder = 3
    Text = 'https://www.google.com/'
  end
  object edtGetToken: TButton
    Left = 232
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Get Token'
    TabOrder = 4
    OnClick = edtGetTokenClick
  end
  object btnGetCode: TButton
    Left = 232
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Get Code'
    TabOrder = 5
    OnClick = btnGetCodeClick
  end
  object edtToken: TEdit
    Left = 317
    Top = 20
    Width = 217
    Height = 21
    TabOrder = 6
  end
  object edtRefreshToken: TEdit
    Left = 317
    Top = 63
    Width = 217
    Height = 21
    TabOrder = 7
  end
  object btnRefresh: TButton
    Left = 232
    Top = 101
    Width = 75
    Height = 25
    Caption = 'Refresh'
    TabOrder = 8
    OnClick = btnRefreshClick
  end
  object memReqProduct: TMemo
    Left = 8
    Top = 191
    Width = 217
    Height = 203
    TabOrder = 9
  end
  object btnPostProduct: TButton
    Left = 232
    Top = 191
    Width = 75
    Height = 25
    Caption = 'Post Product'
    TabOrder = 10
    OnClick = btnPostProductClick
  end
  object memResProduct: TMemo
    Left = 317
    Top = 193
    Width = 217
    Height = 201
    TabOrder = 11
  end
  object memResponse: TMemo
    Left = 317
    Top = 90
    Width = 215
    Height = 80
    TabOrder = 12
  end
  object btnParseJSON: TButton
    Left = 232
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Parse JSON'
    TabOrder = 13
    OnClick = btnParseJSONClick
  end
  object NetHTTPClient1: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    HandleRedirects = True
    AllowCookies = True
    ContentType = 'application/json'
    UserAgent = 'Embarcadero URI Client/1.0'
    SecureProtocols = [SSL2, SSL3, TLS1, TLS11, TLS12]
    Left = 256
    Top = 248
  end
end