unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, REST.Authenticator.OAuth, Vcl.StdCtrls,
  IPPeerClient,REST.Types{,uRESTObjects delphi xe5}, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdIntercept, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.OleCtrls,
  SHDocVw,Json, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    LerGoogleDrive: TButton;
    Memo1: TMemo;
    OAuth2Authenticator2: TOAuth2Authenticator;
    RESTResponse2: TRESTResponse;
    edt_AuthClientSecret: TEdit;
    edt_AuthRequestToken: TEdit;
    edt_OAuth2AuthEndpoint: TEdit;
    edt_OAuth2ClientID: TEdit;
    edt_OAuth2RedirectEndpoint: TEdit;
    edt_OAuth2Scope: TEdit;
    edt_OAuth2tokenEndpoint: TEdit;
    edt_OAuth2AccessToken: TEdit;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    edt_refresh_token: TEdit;
    GETCodautorizacao: TButton;
    uploadfile: TButton;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    refreshToken: TButton;
    edt_expira: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtExpira: TLabel;
    Label10: TLabel;
    OpenDialog1: TOpenDialog;
    Memo2: TMemo;
    procedure LerGoogleDriveClick(Sender: TObject);
    procedure GETCodautorizacaoClick(Sender: TObject);
    procedure uploadfileClick(Sender: TObject);
    procedure refreshTokenClick(Sender: TObject);

  private
       FRESTParams: TRESTRequestParameterList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
 uses REST.Json{ delphi xe5 fica em DBX},Winapi.ShellAPI,REST.Utils{,uOSUtils  delphi xe5},IOUtils,IdMultipartFormData;
{$R *.dfm}

procedure TForm1.LerGoogleDriveClick(Sender: TObject);
var
jValue: string;

begin
if (edt_AuthRequestToken.Text='') then
  begin
  showmessage('pegar acesso google e colar em "edt_AuthRequestToken"');
  GETCodautorizacaoClick(self);
  exit;
  end;

  if edt_OAuth2AccessToken.Text='' then
     refreshTokenClick(self);

{USANDO COMPOMENTE
Delphi 10 "Seattle" JSON Components
by pawel.glowacki@embarcadero.com
"TJSONDocument" and "TJSONTreeView" components
More information at:
http://community.embarcadero.com/blogs/entry/learn-how-to-use-the-new-json-features-in-rad-studio-10-seattle-webinar-march-2nd-wednesday

LValue:=TFile.ReadAllText('d:\client_secret_???????????????????????.apps.googleusercontent.com.json');
JSONDocument1.JsonText:=LValue;
JSONTreeView1.LoadJson;
node:=JSONTreeView1.Items.GetFirstNode;
while node <> nil do
  begin
  if pos('name',node.Text)>0 then
    begin
    snode:=copy(node.Text,pos('"',node.Text)+1,length(node.text));
    memo1.Lines.Add(copy(snode,1,pos('"',snode)-1));
    end;
  node:=node.GetNext;
  end;
exit; }


if edt_AuthRequestToken.Text='' then
  begin
  showmessage('pegar acesso google e colar em "edt_AuthRequestToken"');
  GETCodautorizacaoClick(self);
  exit;
  end;

//lista conteúdo

RESTClient2.BaseURL:='https://www.googleapis.com/drive/v3/files';
RESTRequest2.Params.AddItem('Authorization','Bearer '+edt_OAuth2AccessToken.Text,TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
RESTRequest2.Method:=rmGET;
RESTRequest2.Execute;
memo1.Lines.Add('URI request='+RESTResponse2.FullRequestURI);
jValue:=RESTResponse2.JSONText;
 memo1.Lines.Add(jValue);
//if Assigned(Jvalue) then  delphi xe5
  begin
//      memo1.Lines.Add(TJson.Format(jValue));  delphi xe5

  end;

end;

procedure TForm1.refreshTokenClick(Sender: TObject);
var
  LClient: TRESTClient;
  LRequest: TRESTRequest;
  LValue:string;
begin
if edt_AuthRequestToken.Text='' then
  begin
  showmessage('pegar acesso google e colar em "edt_AuthRequestToken"');
  GETCodautorizacaoClick(self);
  exit;
  end;



//pega autorizacao token (edt_AuthRequestToken.text) e transforma em token de acesso
OAuth2Authenticator2.Scope:=edt_OAuth2Scope.Text;
OAuth2Authenticator2.ClientID:=edt_OAuth2ClientID.Text;
OAuth2Authenticator2.ClientSecret:=edt_AuthClientSecret.Text;
OAuth2Authenticator2.TokenType:=TOAuth2TokenType.ttNONE;
OAuth2Authenticator2.ResponseType:=TOAuth2ResponseType.rtTOKEN;


  LClient := TRESTClient.Create(self);
  LRequest := TRESTRequest.Create(self);
  LRequest.Client := LClient;
  LRequest.Method := TRESTRequestMethod.rmPOST;

  TRY
    LClient.BaseURL :=edt_OAuth2tokenEndpoint.Text;

    if edt_refresh_token.text ='' then
      LRequest.AddParameter('code', edt_AuthRequestToken.Text);

    LRequest.AddParameter('client_id', edt_OAuth2ClientID.Text);
    LRequest.AddParameter('client_secret', edt_AuthClientSecret.Text);

    if edt_refresh_token.text <>'' then
      begin
      LRequest.AddParameter('grant_type', 'refresh_token');
      LRequest.AddParameter('refresh_token', edt_refresh_token.Text);
      end
    else
      begin
      LRequest.AddParameter('grant_type', 'authorization_code');
      LRequest.AddParameter('redirect_uri', edt_OAuth2RedirectEndpoint.Text);
      end;

    LRequest.Execute;

    if (LRequest.Response.StatusCode = 200) then
    begin
      if LRequest.Response.GetSimpleValue('access_token', LValue) then
        edt_OAuth2AccessToken.Text := LValue;
      if LRequest.Response.GetSimpleValue('expires_in', LValue) then
        edt_expira.Text := LValue+' segundos';
      if LRequest.Response.GetSimpleValue('refresh_token', LValue) then
        edt_refresh_token.Text := LValue;
      if LRequest.Response.GetSimpleValue('fileid', LValue) then
        memo1.Lines.Add('ID='+LValue);
    end
    else
      memo1.Lines.Add('ERRO = '+Lrequest.Response.FullRequestURI);

  FINALLY
  OAuth2Authenticator2.AccessToken:=edt_OAuth2AccessToken.text;
  memo1.Lines.Add('EVENTO BUTTON='+Lrequest.Response.StatusText);
  memo1.Repaint;
  FreeAndNIL(LRequest);
  FreeAndNIL(LClient);
  END;
end;

procedure TForm1.GETCodautorizacaoClick(Sender: TObject);
var
LURL:string;
begin
// chama browser pega auth token
//Detalhes da conta de serviço = ID exclusivo = xxxxxxx-xxxxxxx-xxxxxxx  https://console.cloud.google.com/  CRIAR CONTA DE SERVICO
  LURL := edt_OAuth2AuthEndpoint.Text;
  LURL := LURL + '?client_id=' + edt_OAuth2ClientID.Text;
  LURL := LURL + '&response_type=' + 'code';
  LURL := LURL + '&redirect_uri=' + URIEncode(edt_OAuth2RedirectEndpoint.Text);
  LURL := LURL + '&scope=' + URIEncode(edt_OAuth2Scope.text);

//  LURL := LURL + '&login_hint=??????????@gmail.com';//OPÇÃO  e-mail
//  LURL := LURL + '&nonce=xxxxxxx-xxxxxxx-xxxxxxx';//OPÇÃO conta de serviço = ID exclusivo NO FORMATO "xxxxxxx-xxxxxxx-xxxxxxx"

  ShellExecute(HInstance, 'open',pchar(LURL), nil, nil, SW_NORMAL);

// chama browser pegar  auth token  e colar em  edt_AuthRequestToken.TEXT

end;

procedure TForm1.uploadfileClick(Sender: TObject);
var
s,id:string;
upload_stream:TFileStream;
begin

if edt_AuthRequestToken.Text='' then
  begin
  showmessage('pegar acesso google e colar em "edt_AuthRequestToken"');
  GETCodautorizacaoClick(self);
  exit;
  end;

  if edt_OAuth2AccessToken.Text='' then
     refreshTokenClick(self);

//limite de envio no google drive é de 5TG TERAbyte por arquivo !!!!!!
if OpenDialog1.Execute then
  S:=OpenDialog1.FileName
else
  begin
  showmessage('Selecione arquivo para UPLOAD GOOGLE DRIVE');
  exit;
  end;


//caso NÃO USE STREAM, SE NÃO DESABILITAR AS DUAS LINHAS abaixo, da ERRO na leitura  "restrequest2.AddFile"
//upload_stream:= TFileStream.Create(s,fmOpenRead);
//upload_stream.Position := 0;

refreshTokenClick(self);

Restclient2.BaseURL:='https://www.googleapis.com';
RESTClient2.Accept:= 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
RESTClient2.ContentType:= 'application/json';
Restclient2.AcceptCharset:='UTF-8';

RESTRequest2.Params.Clear;
RESTRequest2.ClearBody;

//Restclient2.ContentType:='application/json';
//Restclient2.AcceptCharset:='UTF-8';

RESTRequest2.Accept:= 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
RESTRequest2.Method := TRESTRequestMethod.rmPOST;
RESTRequest2.Resource:='/upload/drive/v3/files';

//restrequest2.AddBody(upload_stream,TRESTContentType.ctAPPLICATION_OCTET_STREAM); // FUNCIONA E NAO ADICIONA BOUNDARY AO CORPO
{OU}
restrequest2.AddFile('testeFile.txt',s,TRESTContentType.ctAPPLICATION_OCTET_STREAM); //FUNCIONA ADICIONA BOUNDARY AO CORPO

RESTRequest2.Params.AddItem('Content-Type', 'application/json; charset=UTF-8', TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
RESTRequest2.Params.AddItem('Accept', 'application/json', TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
RESTRequest2.Params.AddItem('Authorization','Bearer '+edt_OAuth2AccessToken.Text,TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
RESTRequest2.Execute;

RESTRequest2.Response.GetSimpleValue('id', id);

//renomear upload enviado acima
RESTRequest2.Params.Clear;
RESTClient2.BaseURL := 'https://www.googleapis.com/drive/v2/files/'+ id;
RESTRequest2.Resource := '';
RESTRequest2.Method:=TRESTRequestMethod.rmPUT;
RESTRequest2.AddBody('{"title": "'+ extractfilename(s) +'"}', TRESTContentType.ctAPPLICATION_JSON);
RESTRequest2.Execute;

memo1.Lines.Add('SUCESSO UPLOAD !') ;
memo1.Lines.Add('id do arquivo google drive '+id) ;
memo1.Lines.Add(inttostr(RESTRequest2.Response.StatusCode)) ;
memo1.Lines.Add(RESTRequest2.Response.StatusText) ;

{
//INFORMAÇÕES ADICIONAIS DA RESPOSTA CASO QUEIRA
memo1.Lines.Add('RESP FullRequestURI>'+RESTResponse2.FullRequestURI);
memo1.Lines.Add('RESP codigo>'+inttostr(RESTRequest2.Response.StatusCode));
memo1.Lines.Add('RESP status text>'+RESTRequest2.Response.StatusText);
memo1.Lines.Add('RESP cabecalho>'+ RESTRequest2.Response.Headers.Text);
memo1.Lines.Add('RESP content>'+RESTResponse2.Content);
                                                            }

if Assigned(upload_stream) then
  upload_stream.Free;

end;

end.
