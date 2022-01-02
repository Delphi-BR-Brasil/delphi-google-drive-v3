object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 545
  ClientWidth = 1336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 271
    Top = 150
    Width = 38
    Height = 13
    Caption = 'ClientID'
  end
  object Label2: TLabel
    Left = 271
    Top = 196
    Width = 58
    Height = 13
    Caption = 'ClientSecret'
  end
  object Label3: TLabel
    Left = 8
    Top = 150
    Width = 102
    Height = 13
    Caption = 'OAuth2AuthEndpoint'
  end
  object Label4: TLabel
    Left = 8
    Top = 196
    Width = 106
    Height = 13
    Caption = 'OAuth2tokenEndpoint'
  end
  object Label5: TLabel
    Left = 271
    Top = 242
    Width = 66
    Height = 13
    Caption = 'OAuth2Scope'
  end
  object Label6: TLabel
    Left = 8
    Top = 242
    Width = 82
    Height = 13
    Caption = 'RedirectEndpoint'
  end
  object Label7: TLabel
    Left = 8
    Top = 286
    Width = 389
    Height = 13
    Caption = 
      'AuthRequestToken (Copie esse c'#243'digo, acesse seu aplicativo e col' +
      'e o c'#243'digo l'#225': )'
  end
  object Label8: TLabel
    Left = 8
    Top = 338
    Width = 99
    Height = 13
    Caption = 'OAuth2AccessToken'
  end
  object edtExpira: TLabel
    Left = 431
    Top = 338
    Width = 30
    Height = 13
    Caption = 'expira'
  end
  object Label10: TLabel
    Left = 8
    Top = 386
    Width = 68
    Height = 13
    Caption = 'refresh_token'
  end
  object LerGoogleDrive: TButton
    Left = 8
    Top = 78
    Width = 201
    Height = 25
    Caption = 'Ler Google Drive'
    TabOrder = 0
    OnClick = LerGoogleDriveClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 432
    Width = 1320
    Height = 105
    TabOrder = 1
  end
  object edt_AuthClientSecret: TEdit
    Left = 271
    Top = 214
    Width = 435
    Height = 21
    TabOrder = 2
  end
  object edt_AuthRequestToken: TEdit
    Left = 8
    Top = 303
    Width = 417
    Height = 21
    TabOrder = 3
  end
  object edt_OAuth2AuthEndpoint: TEdit
    Left = 8
    Top = 169
    Width = 257
    Height = 21
    TabOrder = 4
    Text = 'https://accounts.google.com/o/oauth2/auth'
  end
  object edt_OAuth2ClientID: TEdit
    Left = 271
    Top = 169
    Width = 435
    Height = 21
    TabOrder = 5
  end
  object edt_OAuth2RedirectEndpoint: TEdit
    Left = 8
    Top = 259
    Width = 169
    Height = 21
    TabOrder = 6
    Text = 'urn:ietf:wg:oauth:2.0:oob'
  end
  object edt_OAuth2Scope: TEdit
    Left = 271
    Top = 259
    Width = 435
    Height = 21
    TabOrder = 7
    Text = 'https://www.googleapis.com/auth/drive'
  end
  object edt_OAuth2tokenEndpoint: TEdit
    Left = 8
    Top = 215
    Width = 257
    Height = 21
    TabOrder = 8
    Text = 'https://accounts.google.com/o/oauth2/token'
  end
  object edt_OAuth2AccessToken: TEdit
    Left = 8
    Top = 357
    Width = 417
    Height = 21
    TabOrder = 9
  end
  object edt_expira: TEdit
    Left = 431
    Top = 357
    Width = 169
    Height = 21
    TabOrder = 10
  end
  object edt_refresh_token: TEdit
    Left = 8
    Top = 405
    Width = 698
    Height = 21
    TabOrder = 11
  end
  object GETCodautorizacao: TButton
    Left = 8
    Top = 8
    Width = 201
    Height = 25
    Caption = 'Obter C'#243'digo Autoriza'#231#227'o'
    TabOrder = 13
    OnClick = GETCodautorizacaoClick
  end
  object uploadfile: TButton
    Left = 8
    Top = 109
    Width = 201
    Height = 25
    Caption = 'Upload google drive'
    TabOrder = 12
    OnClick = uploadfileClick
  end
  object refreshToken: TButton
    Left = 8
    Top = 39
    Width = 201
    Height = 25
    Caption = 'refreshToken C'#243'digo de Autioriza'#231#227'o'
    TabOrder = 14
    OnClick = refreshTokenClick
  end
  object Memo2: TMemo
    Left = 375
    Top = -6
    Width = 674
    Height = 169
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      
        'ativar suas APIS: https://console.cloud.google.com/apis/dashboar' +
        'd'
      
        'ajuda e demonstracao apis google: https://developers.google.com/' +
        'drive/api/v3/reference/files/list#try-it'
      ''
      
        'Quando obter authRequestToken voc'#234' deve obter o authAccessToken ' +
        'e refresh_token'
      ''
      'N'#195'O USE O authrequestToken, pois ele EXPIRA sem aviso'
      ''
      'USE o auth2Acesstokentoken para v'#225'rios acesso em at'#233' 60 segudos'
      'Se EXPIRAR fa'#231'a novo refreshToken'
      ''
      
        'auth2Acesstokentoken  ser'#225' INVALIDO se solicitar novo AUTHREQUES' +
        'TTOKEN'
      'Ai tera que fazer REFRESHTOKEN do novo AUTHREQUESTTOKEN')
    ParentFont = False
    TabOrder = 15
  end
  object OAuth2Authenticator2: TOAuth2Authenticator
    AccessTokenEndpoint = 'https://accounts.google.com/o/oauth2/token'
    AuthorizationEndpoint = 'https://accounts.google.com/o/oauth2/auth'
    RedirectionEndpoint = 'urn:ietf:wg:oauth:2.0:oob'
    Left = 720
    Top = 188
  end
  object RESTResponse2: TRESTResponse
    Left = 728
    Top = 380
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 864
    Top = 184
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 864
    Top = 248
  end
  object RESTClient2: TRESTClient
    Authenticator = OAuth2Authenticator2
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Params = <>
    Left = 720
    Top = 248
  end
  object RESTRequest2: TRESTRequest
    Client = RESTClient2
    Params = <>
    Response = RESTResponse2
    Left = 720
    Top = 320
  end
  object OpenDialog1: TOpenDialog
    Left = 864
    Top = 328
  end
end
