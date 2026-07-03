{***************************************************************
 *
 * Модуль   : data
 * Описание :
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit data;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TRMPdata = class(TDataModule)
    RMPBase: TDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RMPdata: TRMPdata;

implementation

{$R *.DFM}

end.
