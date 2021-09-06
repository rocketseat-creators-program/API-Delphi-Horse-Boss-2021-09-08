unit UnitVersion.Controller;

interface
uses
  Horse,
  Classes,
  SysUtils,
  System.Json,
  DB;


type
  TVersionController = class
    class procedure Registrar;
    class procedure GetVersion(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

{ TVersionController }

class procedure TVersionController.GetVersion(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  Res.Send<TJSONObject>(TJSONObject.Create.AddPair('version', ' 1.0.0'));
end;

class procedure TVersionController.Registrar;
begin
  THorse.Get('/', GetVersion);
end;

end.
