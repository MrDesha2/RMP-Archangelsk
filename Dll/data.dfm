object RMPdata: TRMPdata
  OldCreateOrder = False
  Left = 251
  Top = 180
  Height = 480
  Width = 696
  object RMPBase: TDatabase
    AliasName = 'RMP'
    Connected = True
    DatabaseName = 'RMP'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=sysdba'
      'PASSWORD=masterkey'
      'lc_ctype=WIN1251')
    SessionName = 'Default'
    Left = 48
    Top = 64
  end
end
