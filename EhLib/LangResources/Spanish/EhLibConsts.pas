{*******************************************************}
{                                                       }
{                       EhLib v8.1                      }
{                     EhLib v8.1.07                     }
{                   Resource of strings                 }
{                                                       }
{      Copyright (c) 2001-2015 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

unit EhLibConsts;

interface

resourcestring
  SClearSelectedCellsEh = '¿Desea borrar las celdas seleccionadas?';
  SInvalidTextFormatEh = 'Formato de texto inválido';
  SInvalidVCLDBIFFormatEh = 'Formato VCLDBIF inválido';
  SErrorDuringInsertValueEh = 'Error durante la insercción del valor:';
  SIgnoreErrorEh = '¿Ignorar el error?';
  STabularInformationEh = 'Information tabular';
  SPageOfPagesEh = 'Página %d de %d';
  SPreviewEh =  'Vista previa';
  SFieldNameNotFoundEh = 'El nombre de campo ''%s'' no se encuentra';
  SFindDialogStringNotFoundMessageEh = 'String "%s" not found.';
  SVisibleColumnsEh = 'Visible columns';
  SCutEh = 'Cut';
  SCopyEh = 'Copy';
  SPasteEh = 'Paste';
  SDeleteEh = 'Delete';
  SSelectAllEh = 'Select All';

  SSTFilterListItem_Empties = '(Empty)';
  SSTFilterListItem_NotEmpties = '(Not empty)';
  SSTFilterListItem_All = '(All)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(Clear filter)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByAscend = '(Order by ascending)';
  SSTFilterListItem_SortingByDescend = '(Order by descending)';
  SSTFilterListItem_ApplyFilter = '(Apply filter)';
  SSTFilterListItem_CustomFilter = '(Custom...)';

  SSimpFilter_equals              = 'equals';
  SSimpFilter_does_not_equal      = 'does not equal';
  SSimpFilter_is_greate_than      = 'is greate than';
  SSimpFilter_is_greate_than_or_equall_to = 'is greate than or equall to';
  SSimpFilter_is_less_than        = 'is less than';
  SSimpFilter_is_less_than_or_equall_to = 'is less than or equall to';
  SSimpFilter_begins_with         = 'begins with';
  SSimpFilter_does_not_begin_with = 'does not begin with';
  SSimpFilter_ends_with           = 'ends with';
  SSimpFilter_does_not_end_with   = 'does not end with';
  SSimpFilter_contains            = 'contains';
  SSimpFilter_does_not_contain    = 'does not contain';
  SSimpFilter_like                = 'like';
  SSimpFilter_not_like            = 'not like';
  SSimpFilter_in_list             = 'in list';
  SSimpFilter_not_in_list         = 'not in list';
  SSimpFilter_is_blank            = 'is blank';
  SSimpFilter_is_not_blank        = 'is not blank';

  SGroupingPanelText = 'Drag a column header here to group by that column';

  SNoDataEh = '<No Records>'; //'No data';

    // Error message
  SQuoteIsAbsentEh = 'Quote is absent: ';
  SLeftBracketExpectedEh = '''('' expected: ';
  SRightBracketExpectedEh = ''')'' expected: ';
  SErrorInExpressionEh = 'Error in expression: ';
  SUnexpectedExpressionBeforeNullEh = 'Unexpected expression before Null: ';
  SUnexpectedExpressionAfterOperatorEh = 'Unexpected expression after operator: ';
  SIncorrectExpressionEh = 'Incorrect expression: ';
  SUnexpectedANDorOREh = 'Unexpected AND or OR: ';

  SGridSelectionInfo_Sum = 'Sum';
  SGridSelectionInfo_Cnt = 'Count';
  SGridSelectionInfo_Evg = 'Average';
  SGridSelectionInfo_Min = 'Min';
  SGridSelectionInfo_Max = 'Max';
  SCellCountEh = 'Cell Count';

  SFirstRecordEh = 'First record';
  SPriorRecordEh = 'Prior record';
  SNextRecordEh = 'Next record';
  SLastRecordEh = 'Last record';
  SInsertRecordEh = 'Insert record';
  SDeleteRecordEh = 'Delete record';
  SEditRecordEh = 'Edit record';
  SPostEditEh = 'Post edit';
  SCancelEditEh = 'Cancel edit';
  SConfirmCaptionEh = 'Confirm';
  SRefreshRecordEh = 'Refresh data';

  SDeleteMultipleRecordsQuestionEh = 'Delete %d selected records?';
  SDeleteAllRecordsQuestionEh = 'Delete All records?';

  SDuplicateVarNameEh = 'A Variable named ''%s'' already exists in the Collection';

  SSearchPanelEditorPromptText = 'Search...';
  SUnsupportedFieldTypeEh = 'Unsupported field type (%s) in field %s';

  SSearchPanelApplyFilterEh = 'Show records where the text is found';
  SSearchPanelCancelFilterEh = 'Cancel filter and clear the search text';
  SSearchPanelFindNextEh = 'Find next';
  SSearchPanelFindPrevEh = 'Find prev';
  SSearchPanelOptionsEh = 'Show find options';

  SSortingByThisColumnIsNotPossibleEh = 'Sorting by this column is not possible';
  SGroupingByThisColumnIsNotPossibleEh = 'Grouping by this column is not possible';

  SFindItemNameAllEh = '<All>';

  SElapsedTimeEh = 'Elapsed time';
  SPivotDataBuildingInProgressEh = 'Pivot data building is in progress...';
  SPressESCToCancelEh = 'Press ESC to cancel';

  SGrandTotalEh = 'Grand Total';
  STotalEh = 'Total';
  SPivotValueFieldDisplayNameEh = '(Value)';
  SPivotRowsEh = 'Rows';
  SPivotColumnsEh = 'Columns';
  SPivotValuesEh = 'Values';

  SPivotSliceNonDisplayNameEh = 'Non';
  SPivotSliceYearDisplayNameEh = 'Year';
  SPivotSliceQuarterDisplayNameEh = 'Quarter';
  SPivotSliceMonthDisplayNameEh = 'Month';
  SPivotSliceWeekDisplayNameEh = 'Week';
  SPivotSliceDayDisplayNameEh = 'Day';
  SPivotSliceHourDisplayNameEh = 'Hour';
  SPivotSliceMinDisplayNameEh = 'Min';
  SPivotSliceSecDisplayNameEh = 'Sec';
  SPivotSliceMSecDisplayNameEh = 'MSec';

  SPivotSumFunctionNonEh = 'Non';
  SPivotSumFunctionSumEh = 'Sum';
  SPivotSumFunctionCountEh = 'Count';
  SPivotSumFunctiontAvgEh = 'Avg';
  SPivotSumFunctionMaxEh = 'Max';
  SPivotSumFunctionMinEh = 'Min';
  SPivotSumFunctionCountDistinctEh = 'Count Distinct';
  SPivotSumFunctionCustomEh = 'Custom';

  SPlannerResourceUnassignedEh = 'Unassigned';
  SPlannerNextEventEh = 'Next event';
  SPlannerPriorEventEh = 'Prior event';
  SPlannerDeletePlanItemEh = 'Delete Event?';
  SPlannerPeriodFromEh = 'From';
  SPlannerPeriodToEh = 'To';
  SPlannerWeekTextEh = 'WEEK';
  SPlannerEndTimeBeforeStartTimeEh = 'The EndTime is before the StartTime';

  SOKButtonEh = 'OK';
  SCancelButtonEh = 'Cancel';

  SGridLoadingModeTextEh = 'Loading...';

  SSearchScopeEh = 'Search Scope';
  SCurrentColumnEh = 'Current Column';
  STheEntireGridEh = 'The entire Grid';
  SCaseSensitiveEh = 'Case sensitive';
  SWholeWordsEh = 'Whole words';
  SCloseInBracketsEh = '(Close)';

  SLabelColumnEh = 'Label Column';
  SDataColumnEh = 'Data Column';

implementation

end.

