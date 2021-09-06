unit UnitUsers.Controller;

interface

uses
  Horse,
  Classes,
  SysUtils,
  System.Json,
  DB,
  DataSet.Serialize,
  UnitConnection.Model.Interfaces;

type
  TUsersController = class
    class procedure Registrar;
    class procedure GetAllUsers(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure PostUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

uses
  UnitDatabase;

{ TUsersController }

class procedure TUsersController.GetAllUsers(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: iQuery;
begin
  Query := TDatabase.Query;
  Query.Open('SELECT USU_CODIGO codigo, USU_LOGIN login FROM USUARIOS');
  Res.Send<TJSONArray>(Query.DataSet.ToJSONArray);
end;

class procedure TUsersController.PostUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  Query: iQuery;
  oJsonUsers: TJSONObject;
begin
  oJsonUsers := Req.Body<TJSONObject>;
  Query      := TDatabase.Query;
  Query.Add('INSERT INTO USUARIOS(USU_CODIGO, USU_LOGIN) VALUES (:CODIGO, :LOGIN)');
  Query.AddParam('CODIGO', oJsonUsers.GetValue<integer>('codigo'));
  Query.AddParam('LOGIN', oJsonUsers.GetValue<string>('login'));
  Query.ExecSQL;
  Res.Send<TJSONObject>(oJsonUsers);
end;

class procedure TUsersController.Registrar;
begin
  THorse.Get('/users', GetAllUsers).Post('/users', PostUser);
end;

end.
