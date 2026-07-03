{***************************************************************
 *
 * Модуль   : data
 * Описание :
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit base;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  Tdata = class(TDataModule)
    RMPBase: TDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  data: Tdata;

implementation

{$R *.DFM}

end.
