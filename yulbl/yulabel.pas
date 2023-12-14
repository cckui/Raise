unit yulabel;
{  TYuSoftLabel - my first written component
   TYuSoftLabel is based on Ray Konopka expirience with TLabel
   Use it, enjoy it and modify how you want :-)


   History
   June 3, 1998 - 1.00 public release
   June 5, 1998 - 1.1  Final release ;-). Bug with border draw was removed
                       New methods was added

}
interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls,
     Forms, Graphics, Stdctrls;
const

    TextAlignments:array [TAlignment] of Word=(dt_Left, dt_Right, dt_Center);
type
  TTextStyle=(tsNone, tsRaised, tsRecessed, taShadow);
  TYuSoftLabel = class(TLabel)
    private
        FMouse:Boolean;
        FTextStyle:TTextStyle;
        FTextStyleOnMouse:TTextStyle;
        FTextStyleBuffer:TTextStyle;
        FBorderColor: Tcolor;
        FBorderColorBuffer:Tcolor;
        FBorderColorOnMouse: Tcolor;
        FBorderWidth:Byte;
        FBorderWidthOnMouse:Byte;
        FBorderWidthBuffer:Byte;
        FShadowWidth : Byte;
        FShadowWidthOnMouse : Byte;
        FShadowWidthBuffer : Byte;
        FShadowColor : Tcolor;
        FShadowColorOnMouse : Tcolor;
        FShadowColorBuffer : Tcolor;
        FOnMouseEnter:TNotifyEvent;
        FOnMouseLeave:TNotifyEvent;
        procedure WMSize(var Message: TWMSize); message WM_SIZE;
        procedure Setshadowcolor(value:Tcolor);
        procedure SetshadowcolorOnMouse(value:Tcolor);
        Procedure SetTextStyleOnMouse(value:TTextStyle);
        Procedure SetTextStyle(value:TTextStyle);
        Procedure SetBorderColor(value:Tcolor);
        Procedure SetBorderColorOnMouse(value:Tcolor);
        Procedure SetShadowWidth(value: Byte);
        Procedure SetShadowWidthOnMouse(value: Byte);
        Procedure SetBorderWidth(value: Byte);
        Procedure SetBorderWidthOnMouse(value: Byte);
        procedure MyDraw(R:TRect; Flags:Word);
        procedure DrawOutlinedText(R:TRect; Flags:Word);
        procedure DrawBasicText(R:TRect; Flags:Word);
    protected
        procedure Paint; override;
        procedure CMLButtonDown(var Message: TMessage); message wM_LBUTTONDOWN;
        procedure CMLBUTTONUP(var Message: TMessage); message wM_LBUTTONUP;
        procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
        procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
        procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        procedure DoEnter;
        procedure DoLeave;
    published
        property OnClick;
        property OnDblClick;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        Property Font;
        Property Caption;
        Property BorderColor: Tcolor read FBorderColor write SetBorderColor default clYellow;
        Property OnMouseBorderColor: Tcolor read FBorderColorOnMouse write SetBorderColorOnMouse default clYellow;
        Property BorderWidth: Byte read FBorderWidth write SetBorderWidth default 0;
        Property OnMouseBorderWidth: Byte read FBorderWidthOnMouse write SetBorderWidthOnMouse default 1;
        Property TextStyle: TTextStyle read FTextStyle write SetTextStyle default tsNone;
        Property OnMouseTextStyle: TTextStyle read FTextStyleOnMouse write SetTextStyleOnMouse default tsNone;
        Property ShadowColor : Tcolor read Fshadowcolor write Setshadowcolor default clBtnFace;
        Property OnMouseShadowColor : Tcolor read FshadowcolorOnMouse write SetshadowcolorOnMouse default clBtnFace;
        property ShadowWidth : Byte read FShadowWidth write SetShadowWidth default 1;
        property OnMouseShadowWidth : Byte read FShadowWidthOnMouse write SetShadowWidthOnMouse default 1;
        property OnMouseEnter:TNotifyEvent read  FOnMouseEnter  write FOnMouseEnter;
        property OnMouseLeave:TNotifyEvent read   FOnMouseLeave write FOnMouseLeave;
  end;

procedure Register;

implementation

procedure Register;
begin
     RegisterComponents('YuSoft', [TYuSoftLabel]);
end;

procedure TYuSoftLabel.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;


procedure TYuSoftLabel.SetBorderColor(value:Tcolor);
Begin
  if FBorderColor <> value then
   Begin
    FBorderColor := value;
    Invalidate;
   end;
End;

procedure TYuSoftLabel.SetBorderColorOnMouse(value:Tcolor);
Begin
  if FBorderColorOnMouse <> value then
   Begin
    FBorderColorOnMouse := value;
    if not (csDesigning in ComponentState ) then Invalidate;
   end;
End;


procedure TYuSoftLabel.SetBorderWidth(value:Byte);
Begin
   if FBorderWidth <> value then
     Begin
          FBorderWidth := value;
          Invalidate;
     end;
End;

procedure TYuSoftLabel.SetBorderWidthOnMouse(value:Byte);
Begin
  if (value in [0..9]) then
    begin
         if FBorderWidthOnMouse <> value then
           Begin
                FBorderWidthOnMouse := value;
                if not (csDesigning in ComponentState) then Invalidate;
           end;
    end;
End;


procedure TYuSoftLabel.Setshadowcolor(value:Tcolor);
begin
     if FshadowColor <> value then
       begin
            FshadowColor := value;
            invalidate;
       end;
end;

procedure TYuSoftLabel.SetshadowcolorOnMouse(value:Tcolor);
begin
     if FshadowColorOnMouse <> value then
       begin
            FshadowColorOnMouse := value;
            if not (csDesigning in ComponentState) then invalidate;
       end;
end;


procedure TYuSoftLabel.SetShadowWidth(value: Byte);
Begin
     if (value in [0..9]) then
        if FShadowWidth <> value then
          begin
               FShadowWidth := value;
               invalidate;
          end;
end;

procedure TYuSoftLabel.SetShadowWidthOnMouse(value: Byte);
Begin
     if (value in [0..9]) then
       if FShadowWidthOnMouse <> value then
         begin
              FShadowWidthOnMouse := value;
              if not (csDesigning in ComponentState) then Invalidate;
         end;
end;

procedure TYuSoftLabel.SetTextStyle(value:TTextStyle);
begin
     If FTextStyle <> value then
       begin
            FTextStyle := value;
            Invalidate;
       end;
end;
procedure TYuSoftLabel.SetTextStyleOnMouse(value:TTextStyle);
begin
     If FTextStyleOnMouse <> value then
       begin
            FTextStyleOnMouse := value;
            if not (csDesigning in ComponentState) then Invalidate;
       end;
end;


constructor TYuSoftLabel.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
     FBorderWidth:=0;
     FBorderColor := ClYellow;
     FBorderWidthOnMouse:=1;
     FBorderColorOnMouse := ClYellow;
     FTextStyle:=tsNone;
     FShadowColor := clbtnshadow;
     FShadowWidth := 1;
     FTextStyleOnMouse:=tsNone;
     FShadowColorOnMouse := clbtnshadow;
     FShadowWidthOnMouse := 1;
     Cursor:=crHandPoint;
     Font.Name := 'Arial';
     Font.size := 20;
     Width := 180;
     Height := 30;
end;

destructor TYuSoftLabel.Destroy;
begin
     inherited Destroy;
end;


procedure TYuSoftLabel.WMSize(var Message: TWMSize);
var
     W, H: Integer;
begin
     inherited;
     W := Width;
     H := Height;
     if (W <> Width) or (H <> Height) then
        inherited SetBounds(Left, Top, W, H);
     Message.Result := 0;
end;

procedure TYuSoftLabel.CMMouseEnter(var Message: TMessage);
begin
     inherited;
     DoEnter;
     if Assigned (FOnMouseEnter) then FOnMouseEnter(Self);
end;
procedure TYuSoftLabel.DoEnter;
begin
     FMouse:=True;
     FBorderWidthBuffer:=FBorderWidth;
     FBorderColorBuffer:=FBorderColor;
     FTextStyleBuffer:=FTextStyle;
     FShadowColorBuffer:=FShadowColor;
     FShadowWidthBuffer:=FShadowWidth;
     FTextStyle:=FTextStyleOnMouse;
     FBorderWidth:=FBorderWidthOnMouse;
     FBorderColor:=FBorderColorOnMouse;
     FShadowWidth:=FShadowWidthOnMouse;
     FShadowColor:=FShadowColorOnMouse;
     invalidate;
end;

procedure TYuSoftLabel.CMMouseLeave(var Message: TMessage);
begin
     inherited;
     DoLeave;
     if Assigned (FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TYuSoftLabel.DoLeave;
begin
     FMouse:=False;
     FTextStyle:=FTextStyleBuffer;
     FBorderWidth:=FBorderWidthBuffer;
     FBorderColor:=FBorderColorBuffer;
     FShadowWidth:=FShadowWidthBuffer;
     FShadowColor:=FShadowColorBuffer;
     invalidate;
end;
procedure TYuSoftLabel.DrawOutlinedText(R:TRect; Flags:Word);
var
i:Byte;
TempRect:TRect;
begin
     with Canvas do
       begin
            Brush.Style := bsClear;
            Font.Color := FBorderColor;
            TempRect:=R;
            OffsetRect(TempRect,FBorderWidth,FBorderWidth);
            DrawText(Handle,PChar(Caption),-1, TempRect,Flags);
            TempRect:=R;
            OffsetRect(TempRect,FBorderWidth,-FBorderWidth);
            DrawText(Handle,PChar(Caption),-1, TempRect,Flags);
            TempRect:=R;
            OffsetRect(TempRect,-FBorderWidth,FBorderWidth);
            DrawText(Handle,PChar(Caption),-1, TempRect,Flags);
            TempRect:=R;
            OffsetRect(TempRect,-FBorderWidth,-FBorderWidth);
            DrawText(Handle,PChar(Caption),-1, TempRect,Flags);
       end;
end;



procedure TYuSoftLabel.MyDraw(R:TRect; Flags:Word);
var
ULColor, LRColor:TColor;
TempRect:TRect;
begin
     with Canvas do
      begin
           if WordWrap then
             Flags:=Flags or dt_WordBreak;
           if Not ShowAccelChar then
             Flags:=Flags or dt_NoPrefix;
           Font:=Self.Font;
           If FTextStyle in [tsRecessed, tsRaised] then
             begin
                  case FTextStyle of
                    tsRaised:
                      begin
                           UlColor:=clBtnHighLight;
                           LrColor:=clBtnShadow;
                      end;
                    tsRecessed:
                      begin
                           LrColor:=clBtnHighLight;
                           UlColor:=clBtnShadow;
                      end;
                  end;
                  TempRect:=R;
                  OffsetRect(TempRect,1,1);
                  Font.Color:=LRColor;
                  DrawText(Handle,PChar(Caption),-1, TempRect,Flags);
                  TempRect:=R;
                  OffsetRect(TempRect,-1,-1);
                  Font.Color:=ULColor;
                  DrawText(Handle,PChar(Caption),-1, TempRect,Flags);
             end
           else
             begin
                  if FTextStyle=taShadow then
                    begin
                         TempRect:=R;
                         Font.Color:=FShadowColor;
                         OffsetRect(TempRect,FShadowWidth, FShadowWidth);
                         DrawText(Handle,PChar(Caption),-1, TempRect,Flags);
                    end;
             end;
     end;
end;


procedure TYuSoftLabel.Paint;
begin
     with Canvas do
       begin
            if not Transparent then
              begin
                   Brush.Color:=Self.Color;
                   Brush.Style:=bsSolid;
                   FillRect(ClientRect);
              end;
            Brush.Style:=bsClear;
            MyDraw(ClientRect, dt_ExpandTabs or TextAlignments[Alignment]);
            if FBorderWidth>0 then
              DrawOutlinedText(ClientRect, dt_ExpandTabs or TextAlignments[Alignment]);
            DrawBasicText(ClientRect, dt_ExpandTabs or TextAlignments[Alignment]);
      end;
end;

procedure TYuSoftLabel.CMLButtonDown(var Message: TMessage);
begin
    inherited;
    if FTextStyle=taShadow then
       begin
           FShadowWidth:=0;
           invalidate;
       end;
end;

procedure TYuSoftLabel.CMLButtonUP(var Message: TMessage);
begin
    inherited;
    if FTextStyle=taShadow then
       begin
           FShadowWidth:=FShadowWidthOnMouse;
           invalidate;
       end;
end;

procedure TYuSoftLabel.DrawBasicText(R:TRect; Flags:Word);
begin
     with Canvas do
          begin
               Font.Color:=Self.Font.Color;
               if not Enabled then
               Font.Color:=clGrayText;
               DrawText(Handle,PChar(Caption),-1, R,Flags);
          end;
end;
end.
