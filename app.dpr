program app;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Json,
  Horse,
  Horse.Jhonson,
  UnitDatabase in 'Database\UnitDatabase.pas',
  UnitUsers.Controller in 'Controllers\UnitUsers.Controller.pas',
  UnitVersion.Controller in 'Controllers\UnitVersion.Controller.pas';

begin
  THorse.Use(Jhonson);

  //register controllers
  TUsersController.Registrar;
  TVersionController.Registrar;

  THorse.Listen(3333,
  procedure(App: THorse)
  begin
    Writeln('Server is running on port '+App.Port.ToString);
  end);
end.
