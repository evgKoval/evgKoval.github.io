Attribute VB_Name = "NewMacros"
Sub HighlightTargets2()

    Dim range As range
    Dim i As Long
    Dim TargetList
    
    TargetList = Array("class ", "def ", "return ", "for ", "in ", "if ", "elif ", "else:", "while ")
    
    For i = 0 To UBound(TargetList)
    
    Set range = Selection.range
    
    With range.Find
    .Text = TargetList(i)
    .Format = True
    .MatchCase = True
    .MatchWholeWord = False
    .MatchWildcards = False
    .MatchSoundsLike = False
    .MatchAllWordForms = False
    
    Do While .Execute(Forward:=True) = True
    range.Font.ColorIndex = wdBlue
    
    Loop
    
    End With
    Next

End Sub
Sub colorRed()
    Dim r, f As Boolean, firstOccurence As Long
    Set r = Selection.range
    Do
        With r.Find
            .ClearFormatting
            .Text = "'*'"
            .Forward = True
            .Wrap = wdFindContinue
            .Format = False
            .MatchCase = False
            .MatchWholeWord = False
            .MatchAllWordForms = False
            .MatchSoundsLike = False
            .MatchWildcards = True
            If .Execute Then
                If f Then
                    If r.Start = firstOccurence Then
                        Exit Do
                    End If
                Else
                    firstOccurence = r.Start
                    f = True
                End If
                ActiveDocument.range(r.Start, r.End).Font.ColorIndex = wdDarkRed
                Set r = ActiveDocument.range(r.End, r.End)
            Else
                MsgBox "end", vbExclamation
                Exit Do
            End If
        End With
    Loop
End Sub
Sub Table()
Attribute Table.VB_ProcData.VB_Invoke_Func = "Normal.NewMacros.t"

    Selection.ConvertToTable Separator:=wdSeparateByParagraphs, NumColumns:=1, _
         NumRows:=RangeLinesCount(Selection.range), AutoFitBehavior:=wdAutoFitFixed
    With Selection.Tables(1)
        .Style = "Сетка таблицы"
        .ApplyStyleHeadingRows = True
        .ApplyStyleLastRow = False
        .ApplyStyleFirstColumn = True
        .ApplyStyleLastColumn = False
    End With
    
    Selection.InsertColumns
    Selection.Tables(1).Columns(1).Width = CentimetersToPoints(0.83)
    
    Dim j As Integer
    
    For j = 1 To RangeLinesCount(Selection.range)
        With Selection.Tables(1).Cell(Row:=j, Column:=1).range
        .InsertAfter Text:=j
        .Font.ColorIndex = wdBlack
    End With
    Next j
    
    With Selection.Tables(1)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth050pt
            .Color = -603930625
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth050pt
            .Color = -603930625
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth050pt
            .Color = -603930625
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth050pt
            .Color = -603930625
        End With
        With .Borders(wdBorderHorizontal)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth050pt
            .Color = -603930625
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth050pt
            .Color = -603930625
        End With
        .Borders(wdBorderDiagonalDown).LineStyle = wdLineStyleNone
        .Borders(wdBorderDiagonalUp).LineStyle = wdLineStyleNone
        .Borders.Shadow = False
    End With
    With Options
        .DefaultBorderLineStyle = wdLineStyleSingle
        .DefaultBorderLineWidth = wdLineWidth050pt
        .DefaultBorderColor = -603930625
    End With
    
End Sub

Function RangeLinesCount(MyRange As range)
    Dim Ra As range, FirstLine&, KolStrok&
    Set Ra = MyRange
    With Ra
        FirstLine = .Information(wdFirstCharacterLineNumber)
        If .End > .Start Then .Start = .End - 1
        KolStrok = .Information(wdFirstCharacterLineNumber) - FirstLine + 1
    End With
    RangeLinesCount = KolStrok
End Function
