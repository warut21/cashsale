unit PickDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Calendar, StdCtrls, Buttons, ExtCtrls;

type
  TBrDateForm = class(TForm)
    Bevel1: TBevel;
    OkBtn: TButton;
    CancelBtn: TButton;
    PrevMonthBtn: TSpeedButton;
    TitleLabel: TLabel;
    NextMonthBtn: TSpeedButton;
    Calendar1: TCalendar;
    procedure PrevMonthBtnClick(Sender: TObject);
    procedure NextMonthBtnClick(Sender: TObject);
    procedure Calendar1Change(Sender: TObject);
  private
    procedure SetDate(Date: TDateTime);
    function GetDate: TDateTime;
    { Private declarations }
  public
    property Date: TDateTime read GetDate write SetDate;
    { Public declarations }
  end;

var
  BrDateForm: TBrDateForm;

implementation

{$R *.dfm}


procedure TBrDateForm.SetDate(Date: TDateTime);
begin
 Calendar1.CalendarDate := Date;
end;

function TBrDateForm.GetDate: TDateTime;
begin
  Result := Calendar1.CalendarDate;
end;

procedure TBrDateForm.PrevMonthBtnClick(Sender: TObject);
begin
  Calendar1.PrevMonth;
end;

procedure TBrDateForm.NextMonthBtnClick(Sender: TObject);
begin
  Calendar1.NextMonth;
end;

procedure TBrDateForm.Calendar1Change(Sender: TObject);
begin
  TitleLabel.Caption := FormatDateTime('MMMM, YYYY', Calendar1.CalendarDate);
end;

end.
