�
 TFMMAIN 079  TPF0TfmMainfmMainLeftTop� BorderStylebsDialogCaption2TA Demo Replayer 3.9.2.some version number trololoClientHeightClientWidthColor	clBtnFaceFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
KeyPreview	OldCreateOrderPositionpoScreenCenter
OnActivateFormActivateOnClose	FormCloseOnCreate
FormCreate	OnKeyDownFormKeyDownPixelsPerInch`
TextHeight 	TNotebooknbMainLeft Top WidthHeight�AlignalClientFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 	PageIndex
ParentFontTabOrder OnPageChangednbMainPageChanged TPage Left Top CaptionProvider TLabelLabel1LeftTopWidth� HeightCaption,Choose a service provider in the list below:  TListBoxlbProvidersLeftTop,WidthMHeightaHintHSelect the service provider that you want to use when replaying the demo
ItemHeightTabOrder   TButtonButton1LeftTop� WidthKHeightHintProceeds to the battle roomCaption&OkDefault	TabOrderOnClickButton1Click  TButtonButton9Left� Top� WidthKHeightHint#Return to the file selection screenCaption&BackTabOrderOnClickButton9Click  	TCheckBoxtimemodeLeftTop� Width� HeightHint9Server sync speed after watcher instead of original speedCaptionUse new timer modeChecked	State	cbCheckedTabOrder  	TCheckBox	SkippauseLeftTop� WidthaHeightHint"Skip over pauses in new timer modeCaptionSkip pausesChecked	State	cbCheckedTabOrder  	TCheckBoxcb3DTALeftTop� Width� HeightHintSCheck this to avoid needing to type ".3dta" in the battleroom to watch a demo in 3DCaptionAuto enable 3DTATabOrder   TPage Left Top CaptionLobby TLabelLabel2LeftTopWidth7HeightCaptionBattle room  TListBox	lbPlayersLeftTop(Width=Height� Hint4Shows a list of players currently in the battle room
ItemHeightTabOrder   TEditedChatLeftTop�Width�HeightHint?Write your chat messages here to send them to the other playersTabOrder  TListBoxlbChatLeftTop� Width�HeightHintShows chat messages
ItemHeightTabOrder  TButtonButton2Left�Top� WidthKHeightHint<Starts playback with the players currently in the battleroomCaptionLaunchTabOrderVisibleOnClickButton2Click  TButtonbtnPrevious_brscreenLeft�Top�WidthKHeightHint'Return to the protocol selection screenCaptionPreviousTabOrderOnClickbtnPrevious_brscreenClick  TListBoxlbComLeftXTop(WidthUHeight� HintShows what TA is doing
ItemHeightTabOrder  TButtonButton4Left�Top�WidthKHeightHintSend the current messageCaptionSendTabOrderOnClickButton4Click  TButtonButton10Left�ToplWidthKHeight5Hint"Tries to launch Total AnnihilationCaptionStart TADefault	TabOrderOnClickButton10Click   TPage Left Top CaptionLoading TLabelLabel3LeftTop�WidthMHeightCaptionServer progress  TLabelLabel4LeftTopWidthVHeightCaptionWatcher progress  TProgressBar	pbLoadingLeftTop�Width�HeightTabOrder   TListBox	lbLoadingLeftTop,Width�Height]
ItemHeightTabOrder  TButtonButton5Left�Top�WidthKHeightCaptionQuitTabOrderOnClickButton5Click   TPage Left Top CaptionPlay TLabelLabel5LeftTop�WidthHHeightCaptionGame progress  TLabelLabel6Left�TopWidthHeightCaptionSpeed  TLabelLabel7LeftTopWidth!HeightCaptionEvents  	TTrackBartbSpeedLeft�Top Width-Height�Max�Orientation
trVertical	FrequencydPosition�TabOrder 	TickMarkstmBothOnChangetbSpeedChange  TProgressBarpbGame2Left<Top� WidthHeightTabOrderVisible  TListBoxlbEventsLeftTop Width�Height�
ItemHeightTabOrder  TButtonButton8Left�Top�Width;HeightCaptionQuitTabOrderOnClickButton8Click  	TTrackBarpbGameLeftTop�Width�Height%TabOrderOnChangepbGameChange   TPage Left Top CaptionLoadFile TLabelLabel8LeftTop� WidthxHeightCaptionSelect a demo file to play  TLabelLabel9Left�Top,Width� HeightCaptionInformation about the game  TLabelLabel28LeftTopWidth	Height!	AlignmenttaCenterAutoSizeCaption�The TA Demo Replayer - Created by the Swedish Yankspankers and updated by TA Universe.
Visit our site for the latest information and updates: http://www.tauniverse.comFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFontWordWrap	  TLabelLabel31Left�TopWidth� HeightCursorcrHandPointHint,Open our site in your current browser windowAutoSizeCaptionhttp://www.tauniverse.comFont.CharsetEASTEUROPE_CHARSET
Font.ColorclBlueFont.Height�	Font.NameTahoma
Font.StylefsBoldfsUnderline 
ParentFontWordWrap	OnClickLabel12Click  TSpeedButtonSpeedButton1Left�Top� WidthHeightFlat	
Glyph.Data
�  �  BM�      v   (   $            h                       �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� ffffffffffffffffff  ffffffffffo��fffff  f�DFffffff����foff  hFfdFfFffh�fh���ff  dfffddFffh�ffhh�ff  dffffDFffh�fff��ff  dfffdDFffh�ffh��ff  hFffDDFffh�ff���ff  fHffffffff�fffff�f  ffffffhFfffo��fh��  ffDDFffHfff���ff��  ffDDfffdfff��fffh�  ffDFfffdfff���ffh�  ffDdfffdfff�ho�fh�  ffFfDffHfff�f�o��f  fffffDD�ffffff���f  ffffffffffffffffff  ffffffffffffffffff  	NumGlyphsVisibleOnClickSpeedButton1Click  TLabelLabel33LeftTop,WidthGHeightCaptionSelect the mod  TLabellbSelectVersionLeft\Top,WidthmHeightCaptionSelect the mod versionVisible  TButtonbtnPlayLeft�Top�WidthKHeightHintLLoad the selected demo file and proceed to the DirectPlay protocol selectionCaption&PlayDefault	EnabledTabOrder OnClickbtnPlayClick  TFileListBoxFileListBox1LeftTop� Width�Height$Hint'Select the demo file you wish to replayFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ItemHeightMask*.tad
ParentFontParentShowHintShowHintTabOrderOnChangeFileListBox1ChangeOnClickFileListBox1Click
OnDblClickFileListBox1DblClick	OnMouseUpFileListBox1MouseUp  TDirectoryListBoxDirectoryListBox1Left,TopWidth� Height5HintCSelect the directory that contains the demo file you wish to replayFileListFileListBox1
ItemHeightTabOrder  TFilterComboBoxFilterComboBox1Left� TopPWidth� HeightHint5Change what kinds of files are shown in the file listFileListFileListBox1FilterAll demo files|*.tadTabOrder  TMemo
meGameInfoLeft�Top<WidthHeight�Hint3Shows information about the currently selected gameReadOnly	
ScrollBars
ssVerticalTabOrder  TButtonbtnCommentsLefttTop�WidthGHeightHintAdd comments to current fileCaption	&CommentsEnabledTabOrderOnClickbtnCommentsClick  TButtonbtUnitsLeft�Top�WidthYHeightHintFEnter the TA Demo Control Panel, where you can select your preferencesCaption&OptionsTabOrderOnClickbtUnitsClick  TListBoxlistSelectModLeftTop<WidthIHeightpStylelbOwnerDrawVariableFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ItemHeight
ParentFontTabOrderOnClicklistSelectModClick
OnDrawItemlistSelectModDrawItemOnMeasureItemlistSelectModMeasureItem  TListBox
lbVersionsLeft\Top<Width� Heightq
ItemHeightTabOrderVisibleOnClicklbVersionsClick   TPage Left Top CaptionComments TLabelLabel14LeftTopWidth~HeightCaptionYour commentsFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TLabelLabel15Left�TopWidth� HeightCaptionEarlier commentsFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TMemoCommentsLeftTop(WidthuHeight�Lines.StringsComments TabOrder   TButton
addcommentLefthTop�WidthKHeightCaption&AddTabOrderOnClickaddcommentClick  TButton	NocommentLeft�Top�WidthKHeightCaptionCancelTabOrderOnClickNocommentClick  TMemotidigareLeft�Top(WidthuHeight�Lines.Stringstidigare ReadOnly	TabOrder   TPage Left Top CaptionOptions TLabelLabel16LeftTop8Width/HeightCaption>Backward compatibility TA (default TotalA.exe for older demos)  TLabelLabel17LefthTop� Width� HeightCaptionSync speed (100 recommended)  TLabelLabel18LeftTop� Width� HeightCaption-Demos base directory (recorded files go here)  TLabelLabel19LeftdTop0Width� HeightM	AlignmenttaCenterAutoSizeCaption�Lower the sync speed if you receive "Current ack status xx of xx" when you try to play back a demo. Speed 10 should work for everyone.WordWrap	  TLabelLabel20Left TopWidthHeight	AlignmenttaCenterAutoSizeCaption'TA Demo Control Panel (global settings)Font.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TLabelLabel22LeftpTopWidthHeightCaption10  TLabelLabel23Left�TopWidthHeightCaption100  TLabelLabel24Left�TopWidthHeightCaption200  TBevelBevel1Left�Top� WidthHeight� Shape
bsLeftLine  TLabelLabel10LefthTopTWidth� HeightCaption!Uppdate interval for server in ms  TLabelLabel11LeftpTop� WidthHeightCaption10  TLabelLabel12Left�Top� WidthHeightCaption100  TLabelLabel13Left�Top� WidthHeightCaption200  TBevelBevel2Left Top(WidthHeight	Shape	bsTopLine  TLabelLabel25LefthTop� Width� HeightCaptionSmoothing factor in newtimemode  TLabelLabel26LeftpTop� WidthHeightCaption1  TLabel Left�Top� WidthHeightCaption10  TBevelBevel3LeftTop� Width�Height	Shape	bsTopLine  TBevelBevel4LeftTop Width�Height	Shape	bsTopLine  TLabelLabel27LeftTop� Width�Height	AlignmenttaCenterAutoSizeCaptionRecorder settingsFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TLabelLabel29Left8Top@WidthHeight  TLabelLabel30LeftTop\Width�Height	AlignmenttaCenterAutoSizeCaptionRecorder and server settingsFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TBevelBevel5LeftTop�Width�Height	Shape	bsTopLine  TBevelBevel8Left�Top)WidthHeight`Shape
bsLeftLine  TBevelBevel6Left�Top@WidthwHeight	Shape	bsTopLine  TLabelLabel21LeftXTop.Width� Height	AlignmenttaCenterAutoSizeCaptionReplayer server sync settingsFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TBevelBevel7Left�Top�WidthyHeight	Shape	bsTopLine  TBevelBevel9LeftTop�Width�HeightShape	bsTopLineVisible  TLabelLabel32Left�Top.Width� Height	AlignmenttaCenterAutoSizeCaptionPlayback settingsFont.CharsetEASTEUROPE_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.StylefsBold 
ParentFont  TBevelBevel10LeftTop�Width�Height	Shape	bsTopLineVisible  TBevelBevel11Left�Top�WidthHeight� Shape
bsLeftLineVisible  TBevelBevel12LeftTTop)WidthHeight`Shape
bsLeftLine  TButtonButton11LeftdTop�WidthKHeightCaptionOKDefault	TabOrder OnClickButton11Click  TButtonButton12Left�Top�WidthKHeightCaptionCancelTabOrderOnClickButton12Click  TEditedTADirLeftTopHWidth-HeightEnabledTabOrderTextedTADir  TRadioGrouprgUseDirLeftTop� Width-Height)CaptionDefault mod for listingColumns	ItemIndex Items.StringsRemember last selectedUse base dir TabOrder  TEdit	edDemoDirLeftTop� Width-HeightEnabledTabOrderText	edDemoDir  	TTrackBartbSyncLefthTop� Width� Height!MaxMin	FrequencyPosition
TabOrder  	TTrackBar
tbintervalLefthTopdWidth� HeightHint7A lower value give faster response but require more CPUMax� 	Frequency2PositiondTabOrder  	TTrackBartbSmoothLefthTop� Width� Height!HintoHigher number gives smoother playback but slower responses, dont use a high smooth factor with a large intervalMinPositionTabOrder  	TCheckBoxcbfixallLeftTopWidth� HeightCaption-Use .fixall as default (.fixfacexps + .fixdt)TabOrder  	TCheckBox	cbautorecLeftTop(Width1HeightCaption1Record automatically with an appropriate filenameTabOrder	  	TCheckBox
cbCompressLeftToplWidth� HeightHint7You can try and uncheck this if you experience crashes.CaptionUse compressionChecked	State	cbCheckedTabOrder
  	TCheckBoxcbPlayernamesLeftTop8Width%HeightCaption2Include player names in the auto-recorded filenameTabOrder  	TCheckBoxcbCreatetxtLeftTopHWidth%HeightCaption%Create txt file acompanying .tad fileTabOrder  	TCheckBoxcbShareMapPosLeftTopWidth� HeightCaptionShare map pos as defaultTabOrder  TButtonButton13LeftDTop� WidthIHeightCaption	Browse...TabOrderOnClickButton13Click  TButtonButton14LeftDTopFWidthIHeightCaption	Browse...TabOrderOnClickButton14Click  	TCheckBox	cbUseMod0LeftTopdWidth� HeightCaptionAlways use for older demosTabOrder  TButtonbtnModsEditorLeftdTop�Width� HeightCaptionMods list editorEnabledTabOrderOnClickbtnModsEditorClick  	TCheckBoxcbWindowedModeLeft�TopTWidth� HeightHintUse windowed mode for playbackCaptionUse windowed modeTabOrder  	TCheckBoxcbQuickJoinLeft�TophWidth� HeightHint:Bypass provider screen and go straight to  the battle roomCaptionQuick join (experimental)TabOrder   TPage Left Top Caption
ModsEditor   
TStatusBarsbMainLeft Top�WidthHeightPanels SizeGrip  TOpenDialogodSelectExeFilter%Total Annihilation (TotalA.exe)|*.exeLeftTop,  
TImageListilModsIconsHeight Width Left\TopX  TXPManifestXPManifest1Left�Top��     