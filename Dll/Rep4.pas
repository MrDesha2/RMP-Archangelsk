unit Rep4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel, ExtCtrls;

type
  TReport4Form = class(TForm)
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    Label6: TLabel;
    WrkrCombo: TComboEdit;
    Label10: TLabel;
    WrkrQuery: TQuery;
    Button1: TButton;
    Button2: TButton;
    MainQuery: TQuery;
    ButtonSelPer: TButton;
    Label1: TLabel;
    BrigadeCombo: TComboEdit;
    Label4: TLabel;
    PdrCombo: TComboEdit;
    BrigadeQuery: TQuery;
    PdrQuery: TQuery;
    Label5: TLabel;
    CstCombo: TComboEdit;
    CstQuery: TQuery;
    Label7: TLabel;
    VopCombo: TComboEdit;
    VopQuery: TQuery;
    RadioGroup1: TRadioGroup;
    RadioButtonPlan: TRadioButton;
    RadioButtonFact: TRadioButton;
    Label8: TLabel;
    FeatComboBox: TComboBox;
    GroupBox1: TGroupBox;
    RadioButtonSmall: TRadioButton;
    RadioButtonBig: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure WrkrComboButtonClick(Sender: TObject);
    procedure WrkrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure BrigadeComboButtonClick(Sender: TObject);
    procedure BrigadeComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VopComboButtonClick(Sender: TObject);
    procedure VopComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report4Form: TReport4Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport4Form.Button2Click(Sender: TObject);
begin
        Close;
end;

procedure TReport4Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport4Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport4Form.WrkrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, WrkrCombo, 'select id, code, name from spr_wrkr',
                        'Справочник: Работники (Выбор)', 0);
end;

procedure TReport4Form.WrkrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, WrkrCombo, key, Shift, 1) = false then
    WrkrComboButtonClick(Sender);
end;

procedure TReport4Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i, j, m : Integer;
       Name_parent : String;
       All_Num : Real; //общее количество сделанной номенклатуры
       All_One : Real; //общее количество трудоемкости на еденицу
       All_All : Real; //общее количество общей трудоемкости
       All_Parent : Real; //общее количество общей трудоемкости на производство
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       If ((BegDateEdit.Text ='  .  .  ') or (EndDateEdit.Text = '  .  .  ')) Then
       begin
          MessageDlg('Даты не заполнены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       Name_parent := '';
       All_Num := 0;
       All_One := 0;
       All_All := 0;
       All_Parent := 0;

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select NUM_RQST, NUM_ORDER, NAME_CHRT, NAME_VOP, NUMBER_F, ONE_TIME, ALL_TIME, NAME_CST, NAME_PARENTID ');
       MainQuery.SQL.Add('From REPORT_4_PROCEDURE(:DATE_BEG, :DATE_END, :ID_WRKR, :ID_BRIGADE, :ID_PDR, :ID_CST, :ID_VOP, :FEAT, :VID)');
       MainQuery.SQL.Add('Order by 9, 8, 3, 1, 2');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (WrkrCombo.Text = '') or (WrkrCombo.Text = '<Объект не найден>') or (not WrkrQuery.active) Then
            MainQuery.ParamByName('ID_Wrkr').AsInteger := 0
        else
               MainQuery.ParamByName('ID_Wrkr').AsInteger := WrkrQuery.Fields[0].AsInteger;

       If (BrigadeCombo.Text = '') or (BrigadeCombo.Text = '<Объект не найден>') or (not BrigadeQuery.active) Then
            MainQuery.ParamByName('ID_BRIGADE').AsInteger := 0
        else
               MainQuery.ParamByName('ID_BRIGADE').AsInteger := BrigadeQuery.Fields[0].AsInteger;

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('ID_Pdr').AsInteger := 0
        else
               MainQuery.ParamByName('ID_Pdr').AsInteger := PdrQuery.Fields[0].AsInteger;

       If (CstCombo.Text = '') or (CstCombo.Text = '<Объект не найден>') or (not CstQuery.active) Then
            MainQuery.ParamByName('ID_Cst').AsInteger := -1 //0
        else
               MainQuery.ParamByName('ID_Cst').AsInteger := CstQuery.Fields[0].AsInteger;

       If (VopCombo.Text = '') or (VopCombo.Text = '<Объект не найден>') or (not VopQuery.active) Then
            MainQuery.ParamByName('ID_Vop').AsInteger := -1 //0
        else
               MainQuery.ParamByName('ID_Vop').AsInteger := VopQuery.Fields[0].AsInteger;

//               Showmessage('FeatComboBox.itemindex = '+inttostr(FeatComboBox.itemindex));
       If ((FeatComboBox.itemindex = 0) or (FeatComboBox.itemindex = -1)) Then
            MainQuery.ParamByName('Feat').AsInteger := -1;  //Без признака
       If FeatComboBox.itemindex = 1 Then
            MainQuery.ParamByName('Feat').AsInteger := 0;   //Плановые
       If FeatComboBox.itemindex = 2 Then
            MainQuery.ParamByName('Feat').AsInteger := 1;   //Годовые
       If FeatComboBox.itemindex = 3 Then
            MainQuery.ParamByName('Feat').AsInteger := 2;   //Внеплановые

//            ShowMessage('MainQuery = '+MainQuery.ParamByName('Feat').Asstring);

       If RadioButtonPlan.Checked = true Then MainQuery.ParamByName('VID').AsInteger := 0
        else MainQuery.ParamByName('VID').AsInteger := 1;

       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

//       ShowMessage('1');

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;
          j := 1;
          If (RadioButtonSmall.Checked = True) Then
            m := 72
           else  m:=162;

          add('');
          If (WrkrQuery.active) and  (WrkrCombo.Text <> '') and (WrkrCombo.Text <> '<Объект не найден>') Then
              add(CentrLine('Выработка '+WrkrCombo.Text+' таб. №'+WrkrQuery.Fields[2].AsString, m))
           else
            If (BrigadeQuery.active) and  (BrigadeCombo.Text <> '') and (BrigadeCombo.Text <> '<Объект не найден>')Then
                add(CentrLine('Выработка бригады '+BrigadeCombo.Text+' таб. №'+BrigadeQuery.Fields[2].AsString, m))
             else
              If (PdrQuery.active) and  (PdrCombo.Text <> '') and (PdrCombo.Text <> '<Объект не найден>')Then
                  add(CentrLine('Выработка '+PdrCombo.Text+' (код подразделения '+PdrQuery.Fields[2].AsString+')', m));

          If FeatComboBox.itemindex >= 1 Then //если выбран признак
              add(CentrLine('За период с '+BegDateEdit.Text+' по '+EndDateEdit.Text + ' ('+FeatComboBox.Text+')', m))
           else
               add(CentrLine('За период с '+BegDateEdit.Text+' по '+EndDateEdit.Text, m));
               
          If (RadioButtonSmall.Checked = True) Then
          begin
              add(RepeatLine('-', m));
              add(' № п/п |                     Заказчик                     |   Общая    |');
              add('       |                                                  |трудоемкость|');
              add(RepeatLine('-', m));
          end
           else
           begin
              add(RepeatLine('-', m));
              add(' № п/п | №Заявка/№Заказ |          Заказчик          |           Наименование заказа           |    Наименование операции    |Количество|Трудоемкость|   Общая    |');
              add('       |                |                            |                                         |                             |          | на еденицу |трудоемкость|');
              add(RepeatLine('-', m));
           end;

          Name_parent := MainQuery.FieldByName('NAME_PARENTID').AsString;

          If (RadioButtonBig.Checked = True) Then
             add(LeftLine(MainQuery.FieldByName('NAME_PARENTID').AsString+':', m)+'|');

          While (not MainQuery.Eof) do
          begin

             PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

             If (Name_parent <> MainQuery.FieldByName('NAME_PARENTID').AsString) Then
             begin
                 If (RadioButtonSmall.Checked = True) Then
                 begin
                    add(RightLine(IntToStr(j), 7)+'|'+
                        LeftLine(Name_parent, 50)+'|'+
                        RightLine(FormatFloat('0.00',All_Parent), 12)+'|');
                    j:=j+1;
                    All_Parent := 0;
                    Name_parent := MainQuery.FieldByName('NAME_PARENTID').AsString;
                 end
                 else
                 begin
                    add(RepeatLine('-', m));
                    add(RepeatLine(' ', m-13)+' '+
                        RightLine(FormatFloat('0.00', All_Parent), 12));
                    add(RepeatLine('-', m));    
                    add(LeftLine(MainQuery.FieldByName('NAME_PARENTID').AsString+':', m)+'|');
                    Name_parent := MainQuery.FieldByName('NAME_PARENTID').AsString;
                    All_Parent := 0;
                 end
             end;

             If (RadioButtonBig.Checked = True) Then
             begin
                add(RightLine(IntToStr(i), 7)+'|'+
                    RightLine(MainQuery.FieldByName('NUM_RQST').AsString+'/'+
                              MainQuery.FieldByName('NUM_ORDER').AsString, 16)+'|'+
                    LeftLine(MainQuery.FieldByName('NAME_CST').AsString, 28)+'|'+
                    LeftLine(MainQuery.FieldByName('NAME_CHRT').AsString, 41)+'|'+
                    LeftLine(MainQuery.FieldByName('NAME_VOP').AsString, 29)+'|'+
                    RightLine(MainQuery.FieldByName('NUMBER_F').AsString, 10)+'|'+
                    RightLine(MainQuery.FieldByName('ONE_TIME').AsString, 12)+'|'+
                    RightLine(MainQuery.FieldByName('ALL_TIME').AsString, 12)+'|');
             end;

             All_Num := All_Num + MainQuery.FieldByName('NUMBER_F').AsFloat;
             All_One := All_One + MainQuery.FieldByName('ONE_TIME').AsFloat;
             All_All := All_All + MainQuery.FieldByName('ALL_TIME').AsFloat;
             All_Parent := All_Parent + MainQuery.FieldByName('ALL_TIME').AsFloat;

             i:=i+1;
             MainQuery.Next;
          end;

          If (RadioButtonSmall.Checked = True) Then
          begin
            add(RightLine(IntToStr(j), 7)+'|'+
                LeftLine(Name_parent, 50)+'|'+
                RightLine(FormatFloat('0.00',All_Parent), 12)+'|');
            add(RepeatLine('-', m));
            add(RepeatLine(' ', m-13)+' '+
                RightLine(FormatFloat('0.00', All_All), 12))
          end
           else
           begin
             add(RepeatLine('-', m));
             add(RepeatLine(' ', m-13)+' '+
                 RightLine(FormatFloat('0.00', All_Parent), 12));
             add(RepeatLine('-', m));
             add(RepeatLine(' ', m));

             add(RepeatLine(' ', m-37)+' '+
                 RightLine(FormatFloat('0.000', All_Num), 10)+' '+
                 RightLine(FormatFloat('0.00', All_One), 12)+' '+
                 RightLine(FormatFloat('0.00', All_All), 12));
           end;

          add('');
          add('');
          add('');
//          add('          Мастер__________________________');
          add('    Ведущий экономист__________________________');
//          add('');
//          add('');
//          add('');
//          add('     Нормировщик__________________________');
       end;
       PrForm.Destroy;

       Form.Caption := 'Выработка по бригаде';
       Form.Editor.show;
       Form.show;


end;

procedure TReport4Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport4Form.BrigadeComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, BrigadeQuery, BrigadeCombo, 'select id, code, name from spr_brigade',
                        'Справочник: Бригады (Выбор)', 0);

end;

procedure TReport4Form.BrigadeComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(BrigadeQuery, BrigadeCombo, key, Shift, 1) = false then
    BrigadeComboButtonClick(Sender);

end;

procedure TReport4Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);

end;

procedure TReport4Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport4Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CstQuery, CstCombo, 'select id, code, name from spr_cst',
                        'Справочник: Заказчики (Выбор)', 0);
end;

procedure TReport4Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CstQuery, CstCombo, key, Shift, 1) = false then
    CstComboButtonClick(Sender);
end;

procedure TReport4Form.VopComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, VopQuery, VopCombo, 'select id, code, name from spr_vop',
                        'Справочник: Операции (Выбор)', 0);
end;

procedure TReport4Form.VopComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(VopQuery, VopCombo, key, Shift, 1) = false then
    CstComboButtonClick(Sender);
end;

end.
