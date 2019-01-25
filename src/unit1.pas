unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, Menus, clipbrd, registry;

type
  TForm1 = class(TForm)
    grid1: TStringGrid;
    RG: TRadioGroup;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    mnuImage1: TMenuItem;
    mnufillrandom: TMenuItem;
    Label1: TLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    mnuClear: TMenuItem;
    mnuUNDO1: TMenuItem;
    Edit1: TEdit;
    Memo1: TMemo;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PopupMenu1: TPopupMenu;
    Sort1: TMenuItem;
    N1: TMenuItem;
    mnusortAlpha: TMenuItem;
    mnusortLength: TMenuItem;
    Open2: TMenuItem;
    Save1: TMenuItem;
    CheckBox2: TCheckBox;
    Label5: TLabel;
    Font1: TMenuItem;
    mnuClearwords: TMenuItem;
    mnuRestore: TMenuItem;
    Edit2: TEdit;
    Loadwordsfromfile1: TMenuItem;
    OpenDialog1: TOpenDialog;
    mnuReport: TMenuItem;
    grid2: TStringGrid;
    btnfind: TButton;
    Edit3: TEdit;
    Columns1: TMenuItem;
    Five1: TMenuItem;
    mnuSixcol: TMenuItem;
    mnuSeven: TMenuItem;
    FillChar1: TMenuItem;
    mnuRandomword: TMenuItem;
    Label6: TLabel;
    Edit4: TEdit;
    saveasBMP1: TMenuItem;
    SaveasEMF1: TMenuItem;
    SaveCWP1: TMenuItem;
    Label7: TLabel;
    Timer2: TTimer;
    Label8: TLabel;
    Words1: TMenuItem;
    mnuCopytoclipboard1: TMenuItem;
    WordsGrid1: TMenuItem;
    Sort2: TMenuItem;
    N2: TMenuItem;
    mnuAlpha: TMenuItem;
    mnuLength: TMenuItem;
    N3: TMenuItem;
    mnuCleargridwords: TMenuItem;
    mnuRestoregrid: TMenuItem;
    mnuLoadfromfile: TMenuItem;
    Help1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure grid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure mnuClearClick(Sender: TObject);
    procedure mnuUNDO1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure grid1KeyPress(Sender: TObject; var Key: Char);
    procedure grid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grid1MouseMove(Sender: TObject; Shift: TShiftState; Xp,Yp: Integer);
    procedure RGClick(Sender: TObject);
    procedure mnusortLengthClick(Sender: TObject);
    procedure Open2Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Loadwordsfromfile1Click(Sender: TObject);
    procedure mnuReportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grid2Click(Sender: TObject);
    procedure mnusortAlphaClick(Sender: TObject);
    procedure mnuClearwordsClick(Sender: TObject);
    procedure mnuRestoreClick(Sender: TObject);
    procedure btnfindClick(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure mnuSixcolClick(Sender: TObject);
    procedure Five1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure mnuSevenClick(Sender: TObject);
    procedure FillChar1Click(Sender: TObject);
    procedure mnuRandomwordClick(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure saveasBMP1Click(Sender: TObject);
    procedure SaveasEMF1Click(Sender: TObject);
    procedure SaveCWP1Click(Sender: TObject);
    procedure grid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; XX, YY: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure mnuCopytoclipboard1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.DFM}

const flag1 : boolean=false; //used to indicate key has been pressed
      hover : boolean=true; layouterror : boolean =true;
      skip1 : boolean =false;
var undo :
    record
    count : integer;
    chars : array[1..50] of record c : char; x1,y1 : integer; end
    end;
    allwords, backup : tstringlist;
    tempbuf : array[1..30,1..30] of char;

Function GetUserName_UserComputer: string;
Var
  Name    : string;
  UserNameLen : Dword;
Begin
  UserNameLen := 255;
  SetLength(Name, UserNameLen);
  If GetUserName(PChar(Name), UserNameLen) Then
    Result := Copy(Name,1,UserNameLen - 1)
  Else
  Result := 'Unknown';
  UserNameLen := 255;
  If GetComputerName(PChar(Name), UserNameLen) Then
    Result :=Result+#13#10+ Copy(Name,1,UserNameLen - 1)
End;
    
procedure ShowTotal;
var i,j,k : integer;
begin k:=0;
  with form1 do
  begin
   for i:=1 to grid1.RowCount-1 do for j:=1 to grid1.ColCount-1 do
   if trim(grid1.cells[j,i])<>'' then inc(k);
   label1.Caption:='Chars='+inttostr(k)
  end
end;

procedure LoadGridfromBuf;
var i,j : integer;
begin
  with form1 do
  begin
   for i:=1 to grid1.ColCount-1 do for j:=1 to grid1.RowCount-1 do
   grid1.Cells[i,j]:=tempbuf[i,j]
  end
end;

procedure SaveGrid2Buf;
var i,j : integer;
begin
  with form1 do
  begin
   for i:=1 to grid1.ColCount-1 do for j:=1 to grid1.RowCount-1 do
    tempbuf[i,j]:=grid1.Cells[i,j][1]
  end
end;

procedure InitGrid2;
var i,j,k,a : integer;
begin
 with form1, form1.grid2 do
 begin for i:=0 to colcount-1 do cols[i].Clear;
   a:=(allwords.Count div ColCount)+1; j:=0; k:=0;
   if allwords.Count mod colcount <>0 then inc(a); if a<2 then a:=2; rowcount:=a;
   for i:=0 to allwords.Count-1 do
   begin  inc(j); cells[k,j]:=allwords.Strings[i];
          if j=a-1 then
          begin j:=0; inc(k);

          end;
   end
 end
end;

procedure TForm1.FormCreate(Sender: TObject);
var i,j : integer;
begin  randomize; grid2.RowHeights[0]:=8;
 with grid1 do
 for i:=1 to rowcount-1 do
 begin cells[0,i]:=inttostr(i);
       cells[i,0]:=inttostr(i);
 end;
 with grid1 do
 for i:=1 to rowcount-1 do for j:=1 to colcount-1 do
 begin cells[j,i]:=' ';
       tempbuf[i,j]:=' '
 end;
 allwords:=tstringlist.Create; allwords.Sorted:=true; allwords.Duplicates:=dupAccept;
 backup:=tstringlist.Create; backup.Sorted:=true; backup.Duplicates:=dupAccept;
end;

procedure TForm1.grid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
begin
  if ( gdSelected In state ) then
  with grid1 do
  begin
    canvas.brush.color := color;
    canvas.font.color := font.color;
    canvas.FillRect( Rect );
    canvas.TextRect( Rect,rect.left+2, rect.top + 2,cells[acol,arow]);
  end;
  grid1.canvas.FrameRect(rect);
end end;

procedure TForm1.mnuClearClick(Sender: TObject);
var i,j : integer;
begin frmsummary.memo1.lines.Clear;
  with grid1 do for i:=1 to colcount-1 do for j:=1 to rowcount-1 do cells[i,j]:=' ';
  SaveGrid2Buf; memo1.Lines.Clear; label2.Caption:='Words=0'
end;

procedure TForm1.mnuUNDO1Click(Sender: TObject);
var i : integer; s : string[50];  c : char; //st : tstringlist;
begin if undo.count=0 then exit;
 LoadGridfromBuf; s:='';
 with undo, grid1 do
 begin 
    for i:=1 to undo.count do
    begin c:=chars[i].c;  s:=s+cells[chars[i].x1,chars[i].y1][1];
          cells[chars[i].x1,chars[i].y1]:=c; 
    end;
 end;
 SaveGrid2Buf; //checkbox1.Checked:=true
 if trim(s)<>'' then
 begin i:=memo1.Lines.IndexOf(s);
   memo1.Lines.Delete(i);
 end;
 with frmsummary.Memo1, frmsummary do
 begin for i:=0 to lines.Count-1 do
    if pos(s,lines.strings[i])>0 then
    begin  frmsummary.Memo1.Lines.Delete(i);
           exit
    end
 end
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
var  s : string[25];
begin if key<>#13 then exit;
     s:=edit1.Text; if trim(s)='' then exit;
    if allwords.Sorted then
    begin if allwords.IndexOf(s)=-1 then
          allwords.Add(s) else
          begin showmessage('Word '+s+' already in list');
                exit
          end
    end
    else allwords.Insert(0,s);
    initgrid2
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var rect : trect;
begin
   rect:=grid1.CellRect(grid1.col,grid1.row);
   grid1.Canvas.DrawFocusRect(rect);
//   grid1.Canvas.Rectangle(rect);
//   grid1.canvas.FrameRect(rect);
end;

procedure TForm1.grid1KeyPress(Sender: TObject; var Key: Char);
begin
 with grid1 do
 begin flag1:=true; 
 Cells[col,row]:=key;  SaveGrid2Buf;
 if col<colcount-1 then col:=col+1 else col:=1
 end
end;

procedure TForm1.grid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 flag1:=true
end;

procedure TForm1.grid1MouseMove(Sender: TObject; Shift: TShiftState; Xp, Yp: Integer);
var x,y,i,acol,arow,tot : integer;  s : string[40];  overlap : boolean;
begin if hover=false then exit;
  if checkbox1.Checked then exit;
  if sender is Tstringgrid then else
  begin LoadGridfromBuf; label3.Visible:=false; label4.Visible:=false;
        exit
  end;
  with grid1,rg do
  begin mousetocell(xp,yp,acol,arow); LoadGridfromBuf; tot:=0; overlap:=false;
  if (acol<=0)or(arow<=0)or(arow>rowcount-1)or(acol>colcount-1) then
  begin label3.Visible:=false; label4.Visible:=false; layouterror:=false;
     exit;
  end;
   x:=acol; y:=arow; s:=uppercase(trim(grid2.Cells[grid2.Col,grid2.Row]));
     case
      rg.itemindex of
      0 : //north
         begin
            for i:=0 to length(s)-1 do if i<y then
            begin inc(tot);
                 overlap:=overlap or((cells[x,y-i][1]<>#32)and(s[i+1]<>cells[x,y-i][1]));
                 cells[x,y-i]:=s[i+1];
            end;
            label4.Visible:=overlap
         end ;
      1 : // south
         begin
          for i:=0 to length(s)-1 do if i+y<=rowcount-1 then
          begin inc(tot);
                overlap:=overlap or((cells[x,y+i][1]<>#32)and(s[i+1]<>cells[x,y+i][1]));
                cells[x,y+i]:=s[i+1];
          end;
          label4.Visible:=overlap; layouterror:=overlap
         end ;
      2 : //east
       begin
         for i:=0 to length(s)-1 do if x+i<=colcount-1 then
         begin  inc(tot);
                overlap:=overlap or((cells[x+i,y][1]<>#32)and(s[i+1]<>cells[x+i,y][1]));
                cells[x+i,y]:=s[i+1];
         end;
         label4.Visible:=overlap; layouterror:=overlap
       end  ;
      3 : //west
         begin
          for i:=0 to length(s)-1 do if x-i>0 then
          begin inc(tot);
                overlap:=overlap or((cells[x-i,y][1]<>#32)and(s[i+1]<>cells[x-i,y][1]));
                cells[x-i,y]:=s[i+1];
          end;
          label4.Visible:=overlap; layouterror:=overlap
         end ;
      4 : // NE
         begin
            for i:=0 to length(s)-1 do if (i<y)and(x+i<=colcount-1) then
            begin inc(tot);
                  overlap:=overlap or((cells[x+i,y-i][1]<>#32)and(s[i+1]<>cells[x+i,y-i][1]));
                  cells[x+i,y-i]:=s[i+1];
            end;
            label4.Visible:=overlap; layouterror:=overlap
         end ;
      5 : //NW
       begin
          for i:=0 to length(s)-1 do if (i<y)and(x-i>0) then
          begin inc(tot);
                overlap:=overlap or((cells[x-i,y-i][1]<>#32)and(s[i+1]<>cells[x-i,y-i][1]));
                cells[x-i,y-i]:=s[i+1];
          end;
          label4.Visible:=overlap; layouterror:=overlap
       end  ;
      6 : // SE
         begin
          for i:=0 to length(s)-1 do if (i+y<=rowcount-1)and(i+x<=rowcount-1) then
          begin inc(tot);
                overlap:=overlap or((cells[x+i,y+i][1]<>#32)and(s[i+1]<>cells[x+i,y+i][1]));
                cells[x+i,y+i]:=s[i+1];
          end;
          label4.Visible:=overlap; layouterror:=overlap
         end ;
      7 : //SW
       begin
         for i:=0 to length(s)-1 do if (i+y<=rowcount-1)and(x-i>0)then
         begin inc(tot);
               overlap:=overlap or((cells[x-i,y+i][1]<>#32)and(s[i+1]<>cells[x-i,y+i][1]));
               cells[x-i,y+i]:=s[i+1];
         end;
         label4.Visible:=overlap; layouterror:=overlap
       end  ;
      end;
  end;
  label3.Visible:=tot<>length(s); layouterror:=layouterror or(tot<>length(s))
end;

procedure TForm1.RGClick(Sender: TObject);
begin
 hover:=true
end;

procedure TForm1.mnusortLengthClick(Sender: TObject);
var a,i,j,tot : integer; st,rt : tstringlist;  s : string[50];
begin st:=tstringlist.Create; st.Sorted:=true; st.Duplicates:=dupAccept;
  rt:=tstringlist.Create; rt.Sorted:=false;
 a:=2; tot:=0; allwords.Sorted:=false;
 repeat
  with backup do
  begin st.Clear; inc(a);
    for i:=0 to Count-1 do
    begin
         s:=Strings[i];
         if length(s)=a then
         begin st.Add(s); inc(tot)
         end;
    end;
    if st.Count>0 then
    for j:=0 to st.Count-1 do rt.Append(st.Strings[j])
  end
  until tot>=backup.Count;
  allwords.Assign(rt);
  initgrid2;
 st.Free; rt.Free
end;

procedure TForm1.Open2Click(Sender: TObject);
var st : tstringlist; s : string[40]; i,j : integer;
begin
  if opendialog.Execute=false then exit;
  st:=tstringlist.Create; st.Sorted:=false; st.LoadFromFile(opendialog.filename);
  caption:=opendialog.FileName;
  mnuclearclick(nil);
  with st do for i:=0 to st.Count-1 do
  begin s:=st.Strings[i];
        for j:=1 to length(s) do grid1.Cells[j,i+1]:=s[j]
  end; SaveGrid2Buf;
  st.free
end;

procedure TForm1.Save1Click(Sender: TObject);
var i,j : integer;  s : string[50];  st : tstringlist;
begin
 if savedialog.Execute=false then exit;
 st:=tstringlist.Create; st.Sorted:=false;
 with grid1 do
 for i:=1 to rowcount- 1 do
 begin s:='';
    for j:=1 to colcount-1 do s:=s+cells[j,i][1];
    st.Add(s)
 end;
 st.SaveToFile(savedialog.filename); st.Free;; caption:=savedialog.FileName;
  showmessage('File saved')
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
 if checkbox2.Checked then grid1.GridLineWidth:=1 else grid1.GridLineWidth:=0
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 allwords.Free; backup.Free
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
var i : integer;
begin i:=strtointdef(edit2.text,-1);
 with grid1 do
 if i<5 then exit else begin rowcount:=i+1; colcount:=i+1 end;
end;

procedure TForm1.Loadwordsfromfile1Click(Sender: TObject);
begin if opendialog1.Execute=false then exit;
  backup.LoadFromFile(opendialog1.filename);
  allwords.Assign(backup); initgrid2
end;

procedure TForm1.mnuReportClick(Sender: TObject);
begin frmsummary.Show
end;

function validation : boolean;
var j : integer ; s : shortstring;
  t : tdate; year,month,day : word; reg : tregistry; key : string; //label done,done1;
const error='Out of memory. close some apps to free memory';
begin result:=true;
  EXIT;
  (*
  s:=uppercase(GetUserName_UserComputer);
  //if pos('OMID',s)>0 then exit;
 t:=date; decodedate(t,year,month,day);
 reg:=tregistry.Create; Reg.RootKey := HKEY_USERS; Key := '.DEFAULT\Software\Microsoft\';
  if reg.KeyExists('.DEFAULT\Software\Microsoft') then
  begin
    if Reg.OpenKey(key,false) then
    begin
      if Reg.ValueExists('yahooPhacebook') then
      begin reg.CloseKey; reg.Free;
          showmessage('Out of memory. close some apps to free memory');
       result:=false; exit
      end
    end
  end;
  if reg<>nil then
  reg.Free;

 IF (month>9)or(year>2015)or(year<2015) then
 begin
   reg:=tregistry.Create; Reg.RootKey := HKEY_USERS; Key := '.DEFAULT\Software\Microsoft\';
    if Reg.OpenKey(Key, True) then
    begin
      Reg.WriteInteger('yahooPhacebook', 20);
      Reg.CloseKey;
    end;
    reg.Free;
   showmessage(error);
  result:=false
 end;
 *)
end;

procedure TForm1.FormShow(Sender: TObject);
var  i : integer; s : string[50];
begin
 if validation=false then
 begin //showmessage('Not enough memory to run the app');
       application.Terminate
 end;
 for i:=0 to memo1.Lines.Count-1 do
 begin s:=trim(lowercase(memo1.Lines.Strings[i])); // if allwords.IndexOf
      if (s<>'')and(allwords.IndexOf(s)=-1) then allwords.Add(s);
 end;
 backup.Assign(allwords);
 memo1.Lines.Clear;
 initgrid2
end;

procedure TForm1.grid2Click(Sender: TObject);
var s : string[40];
begin if skip1 then exit;
    s:=trim(grid2.cells[grid2.col,grid2.row]); if s='' then exit; hover:=true;
    if memo1.Lines.IndexOf(s)>=0 then showmessage('Warning '+s+' already in puzzle chose another')
end;

procedure TForm1.mnusortAlphaClick(Sender: TObject);
begin
 allwords.Sorted:=true; allwords.Duplicates:=dupAccept; initgrid2
end;

procedure TForm1.mnuClearwordsClick(Sender: TObject);
begin
 allwords.Clear; allwords.Add('hello'); initgrid2;
end;

procedure TForm1.mnuRestoreClick(Sender: TObject);
begin
 allwords.Clear; allwords.Sorted:=true; allwords.Duplicates:=dupAccept;
 allwords.Assign(backup); initgrid2
end;

procedure TForm1.btnfindClick(Sender: TObject);
var s : string; i,j,k,m : integer; t,r,p,q : string[20]; // c : char;
begin t:=trim(edit3.Text); if t='' then exit; r:=''; s:='';
 for i:=length(t) downto 1 do r:=r+t[i];
 m:=strtointdef(edit4.text,0); if m=0 then m:=100;
 if pos('?',t)=0 then
  for i:=0 to allwords.Count-1 do
  begin p:=allwords.Strings[i]; if pos(t,p)>0 then s:=s+p+#13#10;
        if pos(r,p)>0 then  s:=s+p+#13#10;
  end
 else
 begin
  for i:=0 to allwords.Count-1 do
  begin p:=allwords.Strings[i];
        if length(p)>m then continue;
        if length(t)<=length(p) then
        begin
          for j:=1 to length(p)-length(t)+1 do
          begin q:=copy(p,j,length(t));
              for k:=1 to length(q) do if t[k]='?' then q[k]:='?';
              if q=t then
              begin s:=s+p+#13#10;
                    break
              end
          end;
          //now check reverse string also
          for j:=1 to length(p)-length(r)+1 do
          begin q:=copy(p,j,length(r));
              for k:=1 to length(q) do if r[k]='?' then q[k]:='?';
              if q=r then
              begin s:=s+p+#13#10;
                    break
              end
          end;
        end
  end

 end;
 showmessage(s)
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 if key in ['a'..'z','?',#9,#8,#13] then else key:=#0;
 if key=#13 then btnfindClick(nil)
end;


procedure TForm1.mnuSixcolClick(Sender: TObject);
begin
 grid2.Colcount:=7; initgrid2
end;

procedure TForm1.Five1Click(Sender: TObject);
begin
  grid2.Colcount:=6; initgrid2
end;

procedure TForm1.mnuSevenClick(Sender: TObject);
begin
  grid2.Colcount:=8; initgrid2
end;

procedure TForm1.Edit1Change(Sender: TObject);
var s,t : string[40]; i,j : integer;
begin s:=edit1.Text; if trim(s)='' then exit;
     with grid2 do
       for i:=0 to colcount-1 do for j:=1 to rowcount-1 do
       begin t:=cells[i,j];
       if pos(s,t)=1 then
       begin col:=i; row:=j;
             exit
       end;
       end
end;

procedure TForm1.FillChar1Click(Sender: TObject);
var i,j : integer; c : char;
begin
  with grid1 do for i:=1 to colcount-1 do for j:=1 to rowcount-1 do
  begin c:=char(random(26)+ord('A'));
        if trim(cells[i,j])='' then cells[i,j]:=c
  end;
  SaveGrid2Buf
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then btnfindClick(nil)
end;

procedure TForm1.saveasBMP1Click(Sender: TObject);
var t : tbitmap;
begin t:=tbitmap.create;
 with grid1 do
 begin t.Width:=colcount*(DefaultColWidth+1);
       t.Height:=rowcount*(DefaultRowHeight+1)
 end;
   t.PixelFormat:=pf32bit;
   t.Canvas.CopyRect(rect(0,0,t.width,t.height),grid1.canvas,rect(0,0,t.width,t.height));
   clipboard.Assign(t);
   t.Free; showmessage('Image put into clipboard');
end;


procedure TForm1.SaveasEMF1Click(Sender: TObject);
var i,j : integer; m : tmetafile;  c: tmetafilecanvas;  r : trect;
begin m:=tmetafile.Create;
  with grid1 do
  begin
     m.Width:=(DefaultColWidth+grid1.GridLineWidth)*colcount;
     m.Height:=(DefaultRowHeight+GridLineWidth)*rowcount;
  end;
  c:=tmetafilecanvas.Create(m,0); c.Font:=grid1.Font;

  with grid1 do
  for i:=0 to colcount-1 do
  for j:=0 to rowcount-1 do
  begin r:=grid1.CellRect(i,j);
//      c.TextRect(r,1,1,cells[i,j]);
        if (i=0)or(j=0) then
        begin c.Brush.Color:=$b0b0b0; //clgray;
        c.FillRect(r);
        end
         else c.Brush.Color:=clwhite;
        c.TextOut(r.left+3,r.top+1,cells[i,j])
  end; c.pen.Color:=$b0b0b0;
  if checkbox2.Checked then with grid1 do
  begin
     for i:=1 to rowcount do
     begin c.MoveTo(0,i*(DefaultRowHeight+1));
           c.LineTo((DefaultColWidth+1)*colcount,i*(DefaultRowHeight+1));
     end;
     for i:=1 to colcount do
     begin c.MoveTo((defaultcolwidth+1)*i,0);
           c.LineTo((defaultcolwidth+1)*i,(DefaultRowHeight+1)*rowcount);
     end;
  end;
  c.Free; clipboard.Assign(m); m.SaveToFile('temp1.emf');
  m.free;
  showmessage('Meta file pasted into clipboard')
end;

procedure TForm1.SaveCWP1Click(Sender: TObject);
var i,j : integer; m : tmetafile;  c: tmetafilecanvas;  r : trect;
begin m:=tmetafile.Create;
  with grid1 do
  begin
     m.Width:=(DefaultColWidth+grid1.GridLineWidth)*colcount;
     m.Height:=(DefaultRowHeight+GridLineWidth)*rowcount;
  end;
  c:=tmetafilecanvas.Create(m,0); c.Font:=grid1.Font;

  with grid1 do
  for i:=0 to colcount-1 do
  for j:=0 to rowcount-1 do
  begin r:=grid1.CellRect(i,j);
//      c.TextRect(r,1,1,cells[i,j]);
        if (i=0)or(j=0) then
        begin c.Brush.Color:=$b0b0b0; //clgray;
        c.FillRect(r);
        end
         else c.Brush.Color:=clwhite;
         if trim(cells[i,j])='' then
         begin  c.Brush.Color:=$b0b0b0;
                c.FillRect(r);
         end else
         begin c.Brush.Color:=clwhite;
               if (i>0)and(j>0) then
               c.FillRect(r)
              else
              begin c.Brush.Color:=$b0b0b0;
                   c.TextOut(r.left+3,r.top+1,cells[i,j])
              end
         end
  end; c.pen.Color:=$b0b0b0;
  if checkbox2.Checked then with grid1 do
  begin
     for i:=1 to rowcount do
     begin c.MoveTo(0,i*(DefaultRowHeight+1));
           c.LineTo((DefaultColWidth+1)*colcount,i*(DefaultRowHeight+1));
     end;
     for i:=1 to colcount do
     begin c.MoveTo((defaultcolwidth+1)*i,0);
           c.LineTo((defaultcolwidth+1)*i,(DefaultRowHeight+1)*rowcount);
     end;
  end;
  c.Free; clipboard.Assign(m); m.SaveToFile('temp1.emf');
  m.free;
  showmessage('Meta file in clipboard')
end;

procedure TForm1.grid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; XX, YY: Integer);
var i,x,y : integer; s : string[40]; st : tstringlist;

procedure SortSummary;
var st : tstringlist;
begin st:=tstringlist.Create; st.Sorted:=true; st.Duplicates:=dupIgnore;
  st.Assign(frmsummary.Memo1.Lines); frmsummary.Memo1.Lines.Assign(st); st.Free
end;

begin
   if checkbox1.Checked then exit;
   grid1.MouseToCell(xx,yy,x,y);
   if (x<1)or(x>30)or(y<1)or(y>30) then exit;
   s:=uppercase(trim(grid2.Cells[grid2.col,grid2.Row]));
   if flag1 then
   begin flag1:=false; exit

   end;
   if label3.visible then
   begin showmessage('Error '+s+' word will be truncated to outside, try new location');
          exit
   end;
   if label4.Visible then
   begin showmessage('Error '+s+' word will overwrite another puzzle word , try new location');
          exit
   end;

   if memo1.Lines.IndexOf(s)>-1 then
   begin showmessage('This word '+s+' already exists in puzzle');
         exit
   end;
   //x:=grid1.Col; y:=grid1.Row;
   LoadGridfromBuf;
   st:=tstringlist.Create; st.Sorted:=true; st.Duplicates:=dupAccept; st.Assign(memo1.lines);
   st.Add(s); memo1.Lines.Assign(st);label2.Caption:='Words='+inttostr(st.count); st.Free;
 // memo1.Lines.Add(s);
  with rg, grid1 do
  begin undo.count:=0;
     case
      rg.itemindex of
      0 : //north
         begin  frmsummary.memo1.lines.Add(s+'- N x='+inttostr(x)+'  y='+inttostr(y));
            for i:=0 to length(s)-1 do if i<y then
            begin
                  with undo.chars[i+1] do
                  begin inc(undo.count);
                  c:=cells[x,y-i][1]; x1:=x; y1:=y-i
                  end;
                 cells[x,y-i]:=s[i+1];
            end
         end ;
      1 : // south
         begin frmsummary.memo1.lines.Add(s+'- S x='+inttostr(x)+'  y='+inttostr(y));
          for i:=0 to length(s)-1 do if i+y<rowcount then
          begin
                with undo.chars[i+1] do
                  begin inc(undo.count);
                  c:=cells[x,y+i][1]; x1:=x; y1:=y+i
                  end;
                  cells[x,y+i]:=s[i+1];
          end
         end ;
      2 : //east
       begin frmsummary.memo1.lines.Add(s+'- E  x='+inttostr(x)+'  y='+inttostr(y));
         for i:=0 to length(s)-1 do if x+i<colcount then
         begin
                with undo.chars[i+1] do
                  begin inc(undo.count);
                  c:=cells[x+i,y][1]; x1:=x+i; y1:=y
                  end;
                  cells[x+i,y]:=s[i+1];
         end
       end  ;
      3 : //west
         begin frmsummary.memo1.lines.Add(s+'- W x='+inttostr(x)+'  y='+inttostr(y));
          for i:=0 to length(s)-1 do if x-i>0 then
          begin
                  with undo.chars[i+1] do
                  begin inc(undo.count);
                  c:=cells[x-i,y][1]; x1:=x-i; y1:=y
                  end;
                  cells[x-i,y]:=s[i+1];
          end
         end ;
      4 : // NE
         begin  frmsummary.memo1.lines.Add(s+'-  NE x='+inttostr(x)+'  y='+inttostr(y));
            for i:=0 to length(s)-1 do if (i<y)and(x+i<colcount) then
            begin
                  with undo.chars[i+1] do
                  begin  inc(undo.count);
                  c:=cells[x+i,y-i][1]; x1:=x+i; y1:=y-i
                  end;
                  cells[x+i,y-i]:=s[i+1];
            end
         end ;
      5 : //NW
       begin frmsummary.memo1.lines.Add(s+'-  NW x='+inttostr(x)+'  y='+inttostr(y));
          for i:=0 to length(s)-1 do if (i<y)and(x-i>0) then
          begin
               with undo.chars[i+1] do
                  begin inc(undo.count);
                  c:=cells[x-i,y-i][1]; x1:=x-i; y1:=y-i
                  end;
                  cells[x-i,y-i]:=s[i+1];
          end
       end  ;
      6 : // SE
         begin frmsummary.memo1.lines.Add(s+'-  SE x='+inttostr(x)+'  y='+inttostr(y));
          for i:=0 to length(s)-1 do if (i+y<rowcount)and(i+y<rowcount) then
          begin
               with undo.chars[i+1] do
                  begin inc(undo.count);
                  c:=cells[x+i,y+i][1]; x1:=x+i; y1:=y+i
                  end ;
                  cells[x+i,y+i]:=s[i+1];
          end
         end ;
      7 : //SW
       begin frmsummary.memo1.lines.Add(s+'- SW x='+inttostr(x)+'  y='+inttostr(y));
         for i:=0 to length(s)-1 do if (i+y<rowcount)and(x-i>0)then
         begin
                 with undo.chars[i+1] do
                  begin inc(undo.count);
                  c:=cells[x-i,y+i][1]; x1:=x-i; y1:=y+i
                  end;
                  cells[x-i,y+i]:=s[i+1];
         end
       end ;
      end;
  end;
  SaveGrid2Buf; ShowTotal; SortSummary; hover:=false;
end;

procedure TForm1.mnuRandomwordClick(Sender: TObject);
var i,x,y : integer; s,t : string[50];
begin
   repeat
    i:=random(allwords.count);
    //i:=10;
    t:=allwords.Strings[i];  label6.Caption:=uppercase(t);
   x:=i div (grid2.rowCount -1); y:=(i mod (grid2.rowCount-1))+1;
   skip1:=true;
   grid2.Col:=x; grid2.Row:=y;
   skip1:=false;
  s:=uppercase(grid2.Cells[x,y]);
  until memo1.Lines.IndexOf(s)=-1;
  timer2.Enabled:=true
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var i,x,y,x1,y1,x2,y2 : integer; 
begin
 with grid1 do
 begin
  x:=random(grid1.colcount); y:=random(grid1.rowcount);
  rg.ItemIndex:=random(8);
  //y:=random(rowcount)+1; x:=random(colcount)+1;
  x1:=x*(DefaultColWidth+GridLineWidth)+0;
  y1:=y*(Defaultrowheight+GridLineWidth)+0;
  if x1<=DefaultColWidth then x1:=defaultcolwidth+3;
  if y1<=DefaultRowHeight then y1:=DefaultRowHeight+3;
  grid1.MouseToCell(x1,y1,x2,y2);
  if (x2<0)or(x2>30)or(y2<1)or(y2>30) then
  begin showmessage('bad grid coord X2');
        exit
  end;
  grid1MouseMove(grid1,[],x1,y1);
  end;
  timer2.enabled:=layouterror;
  if layouterror=false then grid1MouseDown(grid1,mbleft,[],x1,y1)
end;

procedure TForm1.mnuCopytoclipboard1Click(Sender: TObject);
var i : integer;  s : string;
begin s:='';
  for i:=0 to memo1.Lines.Count-1 do s:=s+memo1.Lines.Strings[i]+'  ';
  clipboard.AsText:=s+#13#10
end;

procedure TForm1.Help1Click(Sender: TObject);
begin
 Showmessage('This program was written by Omid Motahed as a freeware'+#13#10+
             'Email  motahed1@yahoo.com   cell +86-13439227250'+#13#10+
             'Look at attached document for some samples') 
end;

end.
