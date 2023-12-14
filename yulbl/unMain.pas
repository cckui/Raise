unit unMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, yulabel, Buttons;
type
  TYuSoftSpeedButton=class(TSpeedButton)   // New Class here
   private                                 // use this example to create your descendant
     FOnMouseEnter:TNotifyEvent;
     FOnMouseLeave:TNotifyEvent;
   protected
     procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
     procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
   published
     property OnMouseEnter:TNotifyEvent read  FOnMouseEnter  write FOnMouseEnter;
     property OnMouseLeave:TNotifyEvent read   FOnMouseLeave write FOnMouseLeave;
   end;
type
  TfmMain = class(TForm)
    YuSoftLabel1: TYuSoftLabel;
    YuSoftLabel3: TYuSoftLabel;
    YuSoftLabel4: TYuSoftLabel;
    YuSoftLabel5: TYuSoftLabel;
    BitBtn1: TBitBtn;
    GroupBox: TGroupBox;
    YuSoftLabel2: TYuSoftLabel;
    YuSoftLabel6: TYuSoftLabel;
    YuSoftLabel7: TYuSoftLabel;
    Memo1: TMemo;
    procedure YuSoftLabel1MouseEnter(Sender: TObject);
    procedure YuSoftLabel1MouseLeave(Sender: TObject);
    procedure YuSoftLabel4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    yusbOne, yusbTwo, yusbThree:TYusoftSpeedButton;
    procedure OnMouseEnterLabel(Sender: TObject);
    procedure OnMouseLeaveLabel(Sender: TObject);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

procedure TYuSoftSpeedButton.CMMouseEnter(var Message: TMessage);
begin
     inherited;
     if Assigned (FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TYuSoftSpeedButton.CMMouseLeave(var Message: TMessage);
begin
     inherited;
     if Assigned (FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TfmMain.YuSoftLabel1MouseEnter(Sender: TObject);
begin
     YuSoftLabel5.Visible:=True;
end;

procedure TfmMain.YuSoftLabel1MouseLeave(Sender: TObject);
begin
     YuSoftLabel5.Visible:=False;
end;

procedure TfmMain.YuSoftLabel4Click(Sender: TObject);
begin
     MessageDlg('You have pressed a TYusoftLabel',
    mtCustom, [mbYes], 0);
end;

procedure TfmMain.BitBtn1Click(Sender: TObject);
begin
     Close;
end;


procedure TfmMain.FormCreate(Sender: TObject);
begin
     yusbOne:=TYusoftSpeedButton.Create(Self);
      with yusbOne do
      begin
           Parent:=GroupBox;
           Top:=30;
           Left:=20;
           OnMouseEnter:=OnMouseEnterLabel;
           OnMouseLeave:=OnMouseLeaveLabel;
           Tag:=1;
      end;
     yusbTwo:=TYusoftSpeedButton.Create(Self);
      with yusbTwo do
      begin
           Parent:=GroupBox;
           Top:=70;
           Left:=20;
           OnMouseEnter:=OnMouseEnterLabel;
           OnMouseLeave:=OnMouseLeaveLabel;
           Tag:=2;
      end;
    yusbThree:=TYusoftSpeedButton.Create(Self);
      with yusbThree do
      begin
           Parent:=GroupBox;
           Top:=110;
           Left:=20;
           OnMouseEnter:=OnMouseEnterLabel;
           OnMouseLeave:=OnMouseLeaveLabel;
           Tag:=3;
      end;
end;



procedure TfmMain.OnMouseEnterLabel(Sender: TObject);
var
Temp:TComponent;
i:Integer;
begin
    for i:=0 to ComponentCount-1 do
      begin
           Temp:=Components[i];
           if (Temp is TYusoftLabel) then
             begin
                    if (Temp as TYusoftLabel).Tag=(Sender as TYusoftSpeedButton).Tag then
                       (Temp as TYusoftLabel).DoEnter;
             end;
      end;

end;

procedure TfmMain.OnMouseLeaveLabel(Sender: TObject);
var
Temp:TComponent;
i:Integer;
begin
    for i:=0 to ComponentCount-1 do
      begin
           Temp:=Components[i];
           if (Temp is TYusoftLabel) then
             begin
                    if (Temp as TYusoftLabel).Tag=(Sender as TYusoftSpeedButton).Tag then
                       (Temp as TYusoftLabel).DoLeave;
             end;
      end;

end;
end.
