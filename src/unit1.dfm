object Form1: TForm1
  Left = 211
  Top = 191
  Width = 1058
  Height = 760
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseMove = grid1MouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 554
    Top = 624
    Width = 32
    Height = 14
    Caption = 'Label1'
    OnMouseMove = grid1MouseMove
  end
  object Label2: TLabel
    Left = 554
    Top = 648
    Width = 32
    Height = 14
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 549
    Top = 531
    Width = 35
    Height = 14
    Caption = 'ERROR'
    Color = clRed
    ParentColor = False
    Visible = False
  end
  object Label4: TLabel
    Left = 548
    Top = 551
    Width = 40
    Height = 14
    Caption = 'Warning'
    Color = clYellow
    ParentColor = False
    Visible = False
  end
  object Label5: TLabel
    Left = 554
    Top = 663
    Width = 32
    Height = 14
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 20
    Top = 684
    Width = 32
    Height = 14
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 552
    Top = 570
    Width = 43
    Height = 14
    Caption = 'Grid size'
  end
  object Label8: TLabel
    Left = 192
    Top = 561
    Width = 82
    Height = 14
    Caption = 'Word Length limit'
  end
  object grid1: TStringGrid
    Left = -1
    Top = 0
    Width = 542
    Height = 542
    Cursor = crCross
    ColCount = 31
    DefaultColWidth = 16
    DefaultRowHeight = 16
    RowCount = 31
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = grid1DrawCell
    OnKeyDown = grid1KeyDown
    OnKeyPress = grid1KeyPress
    OnMouseDown = grid1MouseDown
    OnMouseMove = grid1MouseMove
  end
  object RG: TRadioGroup
    Left = 613
    Top = 482
    Width = 47
    Height = 189
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemIndex = 2
    Items.Strings = (
      'N'
      'S'
      'E'
      'W'
      'NE'
      'NW'
      'SE'
      'SW')
    ParentFont = False
    TabOrder = 1
    OnClick = RGClick
  end
  object Edit1: TEdit
    Left = 544
    Top = 2
    Width = 110
    Height = 22
    Anchors = [akLeft]
    CharCase = ecLowerCase
    Color = clYellow
    MaxLength = 25
    TabOrder = 2
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
  object Memo1: TMemo
    Left = 543
    Top = 23
    Width = 124
    Height = 458
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      'absorbent'
      'acid'
      'adaptation'
      'adrenalglands'
      'alkali'
      'animal'
      'aquatic'
      'astronomy'
      'atmosphere'
      'base'
      'bicep'
      'biceps'
      'biome'
      'bladder'
      'boilingpoint'
      'brittle'
      'carnivore'
      'caterpillar'
      'cellmembrance'
      'cellsap'
      'characteristic'
      'chemicalchange'
      'chlorophyll'
      'chloroplast'
      'chromatography'
      'circuit'
      'classification'
      'community'
      'components'
      'compound'
      'compressed'
      'condensation'
      'conduction'
      'conductor'
      'consumer'
      'contactforce'
      'continiousdata'
      'contraction'
      'convection'
      'cornia'
      'cytoplasm'
      'decanting'
      'decomposer'
      'development'
      'diffusion'
      'digestive'
      'dissolving'
      'distillate'
      'distillation'
      'ductile'
      'ears'
      'eclipse'
      'ecosystem'
      'effect'
      'elastic'
      'electrical'
      'electriccurrent'
      'electromagnetic'
      'emulsion'
      'energy'
      'environment'
      'escaping'
      'estimate'
      'evaporation'
      'excretion'
      'excretion'
      'expansion'
      'experiment'
      'eyes'
      'fact'
      'features'
      'filter'
      'filtrate'
      'flexible'
      'force'
      'formic'
      'fuel'
      'function'
      'gases'
      'genus'
      'goblet'
      'growth'
      'guardcell'
      'habitat'
      'heart'
      'herbivore'
      'human'
      'hydrochloric'
      'immiscible'
      'indicator'
      'inherited'
      'insoluble'
      'insulator'
      'invertebrates'
      'jupiter'
      'keys'
      'kidney'
      'kingdoms'
      'lense'
      'lifecycle'
      'limewater'
      'liquid'
      'lizard'
      'lungs'
      'magnify'
      'malleable'
      'mars'
      'matter'
      'maturity'
      'measuring'
      'mercury'
      'microscope'
      'miscible'
      'mixture'
      'model'
      'mosquito'
      'mouth'
      'movement'
      'neptune'
      'neutral'
      'neutralization'
      'nonrenewable'
      'nucleus'
      'nutrition'
      'observation'
      'offsprings'
      'omnivore'
      'opaque'
      'opinion'
      'orbit'
      'organ'
      'organism'
      'ovaries'
      'palisade'
      'particlemodel'
      'phloem'
      'photosynthesis'
      'pluto'
      'population'
      'powder'
      'pressure'
      'producer'
      'properties'
      'pure'
      'radiation'
      'renewable'
      'repellent'
      'reproduction'
      'residue'
      'resistance'
      'respiration'
      'saturated'
      'saturn'
      'science'
      'sensitivity'
      'shampoo'
      'sieve'
      'skin'
      'soap'
      'soda'
      'soil'
      'solareclipse'
      'solid'
      'sulphuric'
      'soluble'
      'solution'
      'solvent'
      'specialised'
      'species'
      'spinal'
      'stiff'
      'stomach'
      'sublimation'
      'survey'
      'suspension'
      'synthetic'
      'terrestrial'
      'thighbone'
      'tissue'
      'transfer'
      'translucent'
      'transparent'
      'unique'
      'universe'
      'uranus'
      'uterus'
      'vacule'
      'variations'
      'veins'
      'venus'
      'vertebrate'
      'vibrate'
      'vinegar'
      'water'
      'waterproof'
      'windpipe'
      'work'
      'xylem'
      'Adrenals'
      'Appendix'
      'Bladder'
      'Brain'
      'Esophagus'
      'Gallbladder'
      'Heart'
      'Intestines'
      'Kidney'
      'Liver'
      'Lung'
      'Ovaries'
      'Pancreas'
      'thyroids'
      'Pituitary'
      'Prostate'
      'Spleen'
      'Stomach'
      'Thymus'
      'Thyroid'
      'Uterus'
      'Veins'
      'Head'
      'Forehead'
      'Jaws'
      'Cheek'
      'Chin'
      'Teeth'
      'tooth'
      'Tongue'
      'Throat'
      'Neck'
      'Adam'#39'sapple'
      'Shoulder'
      'Arms'
      'Elbow'
      'Wrist'
      'Hand'
      'Finger'
      'Thumb'
      'Spine'
      'Chest'
      'Thorax'
      'Breast'
      'Abdomen'
      'Groin'
      'Hips'
      'Navel'
      'Scrotum'
      'Legs'
      'Thigh'
      'Knee'
      'Calf'
      'Heel'
      'Ankle'
      'Foot'
      'feet'
      'Toes'
      'molecule'
      'atom'
      'moss'
      'fern'
      'conifer'
      'leaf'
      'snail'
      'mammal'
      'reptile'
      'homosapien'
      'cactus'
      'worm'
      'lugworm'
      'camel'
      'lion'
      'whale'
      'shark'
      'crocodile'
      'whale'
      'epiphyte'
      'tundra'
      'conifer'
      'ammonia'
      'oxygen'
      'hydrogen'
      'ceramics'
      'aluminum'
      'textile'
      'battery'
      'copper'
      'gold'
      'iron'
      'zinc'
      'lead'
      'nickel'
      'silver'
      'tins'
      'zinc'
      'mayonnaise'
      'wring'
      'fossil'
      'coal'
      'diesel'
      'ribs'
      'rain'
      'snow'
      'embryo'
      'melting'
      'density'
      'satellite'
      'placenta')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
    OnMouseMove = grid1MouseMove
  end
  object CheckBox1: TCheckBox
    Left = 545
    Top = 489
    Width = 60
    Height = 17
    Caption = 'No click'
    TabOrder = 4
    OnMouseMove = grid1MouseMove
  end
  object CheckBox2: TCheckBox
    Left = 545
    Top = 509
    Width = 45
    Height = 17
    Caption = 'Lines'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = CheckBox2Click
  end
  object Edit2: TEdit
    Left = 552
    Top = 585
    Width = 41
    Height = 22
    AutoSelect = False
    MaxLength = 2
    TabOrder = 6
    Text = '30'
    OnKeyPress = Edit2KeyPress
  end
  object grid2: TStringGrid
    Left = 672
    Top = 0
    Width = 378
    Height = 714
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    DefaultColWidth = 58
    DefaultRowHeight = 16
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goThumbTracking]
    PopupMenu = PopupMenu1
    TabOrder = 7
    OnClick = grid2Click
    ColWidths = (
      76
      66
      67
      64
      58)
  end
  object btnfind: TButton
    Left = 12
    Top = 556
    Width = 35
    Height = 20
    Caption = 'Find'
    TabOrder = 8
    OnClick = btnfindClick
  end
  object Edit3: TEdit
    Left = 52
    Top = 556
    Width = 93
    Height = 22
    CharCase = ecLowerCase
    MaxLength = 20
    TabOrder = 9
    OnKeyPress = Edit3KeyPress
  end
  object Edit4: TEdit
    Left = 156
    Top = 556
    Width = 33
    Height = 22
    MaxLength = 2
    TabOrder = 10
    Text = '0'
    OnKeyPress = Edit4KeyPress
  end
  object MainMenu1: TMainMenu
    Left = 164
    Top = 156
    object File1: TMenuItem
      Caption = 'File'
      object mnuClear: TMenuItem
        Caption = 'Clear'
        OnClick = mnuClearClick
      end
      object Open2: TMenuItem
        Caption = 'Open'
        OnClick = Open2Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
    end
    object mnuImage1: TMenuItem
      Caption = 'ClipBoard'
      object saveasBMP1: TMenuItem
        Caption = 'Save as BMP'
        OnClick = saveasBMP1Click
      end
      object SaveasEMF1: TMenuItem
        Caption = 'Save as EMF'
        OnClick = SaveasEMF1Click
      end
      object SaveCWP1: TMenuItem
        Caption = 'Save CWP'
        OnClick = SaveCWP1Click
      end
    end
    object mnufillrandom: TMenuItem
      Caption = 'Fill'
      object FillChar1: TMenuItem
        Caption = 'Random letters'
        OnClick = FillChar1Click
      end
    end
    object mnuUNDO1: TMenuItem
      Caption = 'UNDO'
      OnClick = mnuUNDO1Click
    end
    object mnuReport: TMenuItem
      Caption = 'Summary'
      OnClick = mnuReportClick
    end
    object Columns1: TMenuItem
      Caption = 'Columns'
      object Five1: TMenuItem
        Caption = 'Five'
        OnClick = Five1Click
      end
      object mnuSixcol: TMenuItem
        Caption = 'Six'
        OnClick = mnuSixcolClick
      end
      object mnuSeven: TMenuItem
        Caption = 'Seven'
        OnClick = mnuSevenClick
      end
    end
    object mnuRandomword: TMenuItem
      Caption = 'Random'
      OnClick = mnuRandomwordClick
    end
    object Words1: TMenuItem
      Caption = 'Words'
      object mnuCopytoclipboard1: TMenuItem
        Caption = 'Copy to clipboard'
        OnClick = mnuCopytoclipboard1Click
      end
    end
    object WordsGrid1: TMenuItem
      Caption = 'WordsGrid'
      object Sort2: TMenuItem
        Caption = 'Sort'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mnuAlpha: TMenuItem
        Caption = 'Alpha'
        OnClick = mnusortAlphaClick
      end
      object mnuLength: TMenuItem
        Caption = 'Length'
        OnClick = mnusortLengthClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnuCleargridwords: TMenuItem
        Caption = 'Clear'
        OnClick = mnuClearwordsClick
      end
      object mnuRestoregrid: TMenuItem
        Caption = 'Restore'
        OnClick = mnuRestoreClick
      end
      object mnuLoadfromfile: TMenuItem
        Caption = 'Load from file'
        OnClick = Loadwordsfromfile1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      OnClick = Help1Click
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'fnd'
    Filter = 'Text files|*.fnd'
    InitialDir = 'd:\esl-lessons'
    Left = 280
    Top = 152
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'FND'
    Filter = 'Text files|*.FND'
    InitialDir = 'd:\esl-lessons'
    Left = 288
    Top = 68
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 156
    Top = 80
  end
  object PopupMenu1: TPopupMenu
    Left = 700
    Top = 188
    object Sort1: TMenuItem
      Caption = 'Sort'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnusortAlpha: TMenuItem
      Caption = 'Alpha'
      OnClick = mnusortAlphaClick
    end
    object mnusortLength: TMenuItem
      Caption = 'Length'
      OnClick = mnusortLengthClick
    end
    object Font1: TMenuItem
      Caption = '-'
    end
    object mnuClearwords: TMenuItem
      Caption = 'Clear'
      OnClick = mnuClearwordsClick
    end
    object mnuRestore: TMenuItem
      Caption = 'Restore'
      OnClick = mnuRestoreClick
    end
    object Loadwordsfromfile1: TMenuItem
      Caption = 'Load words from file'
      OnClick = Loadwordsfromfile1Click
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'TXT'
    Filter = 'Ascii text files|*.TXT'
    Left = 212
    Top = 64
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer2Timer
    Left = 136
    Top = 268
  end
end
