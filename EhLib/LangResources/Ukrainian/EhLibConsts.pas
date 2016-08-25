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
  SClearSelectedCellsEh = 'Очистити вміст виділених комірок?';
  SInvalidTextFormatEh = 'Неправильний формат тексту';
  SInvalidVCLDBIFFormatEh = 'Неправильний формат VCLDBIF';
  SErrorDuringInsertValueEh = 'Помилка при вставці значення:';
  SIgnoreErrorEh = 'Ігнорувати помилку?';
  STabularInformationEh = 'Таблична інформація';
  SPageOfPagesEh = 'Сторінка %d з %d';
  SPreviewEh =  'Попередній перегляд';
  SFieldNameNotFoundEh = 'Ім''я поля ''%s'' не знайдено';
  SFindDialogStringNotFoundMessageEh = 'Рядок "%s" не знайдено';
  SVisibleColumnsEh = 'Видимі стовпці';
  SCutEh = 'Вирізати';
  SCopyEh = 'Копіювати';
  SPasteEh = 'Вставити';
  SDeleteEh = 'Видалити';
  SSelectAllEh = 'Виділити все';

  SSTFilterListItem_Empties = '(Пусті)';
  SSTFilterListItem_NotEmpties = '(Не пусті)';
  SSTFilterListItem_All = '(Всі)';
  SSTFilterListItem_SelectAll = '(Select All)';
  SSTFilterListItem_ClearFilter = '(Очистити фільтр)';
  SSTFilterListItem_ClearFilterInColumn = '(Clear column filter)';
  SSTFilterListItem_SortingByAscend = '(Сортувати за зростанням)';
  SSTFilterListItem_SortingByDescend = '(Сортувати за спаданням)';
  SSTFilterListItem_ApplyFilter = '(Застосувати фільтр)';
  SSTFilterListItem_CustomFilter = '(Фільтр користувача...)';

  SSimpFilter_equals              = 'дорівнює';
  SSimpFilter_does_not_equal      = 'не дорівнює';
  SSimpFilter_is_greate_than      = 'більше';
  SSimpFilter_is_greate_than_or_equall_to = 'більше або дорівнює';
  SSimpFilter_is_less_than        = 'менше';
  SSimpFilter_is_less_than_or_equall_to = 'менше або дорівнює';
  SSimpFilter_begins_with         = 'починається з';
  SSimpFilter_does_not_begin_with = 'не починається з';
  SSimpFilter_ends_with           = 'закінчується на';
  SSimpFilter_does_not_end_with   = 'не закінчується на';
  SSimpFilter_contains            = 'містить';
  SSimpFilter_does_not_contain    = 'не містить';
  SSimpFilter_like                = 'подібно';
  SSimpFilter_not_like            = 'не подібно';
  SSimpFilter_in_list             = 'у списку';
  SSimpFilter_not_in_list         = 'не у списку';
  SSimpFilter_is_blank            = 'пусті';
  SSimpFilter_is_not_blank        = 'не пусті';

  SGroupingPanelText = 'Перетягніть сюди заголовок стовпця, щоб згрупувати дані за стовпцем';

  SNoDataEh = '<немає даних>'; //'No data';

    // Error message
  SQuoteIsAbsentEh = 'Відсутня лапка: ';
  SLeftBracketExpectedEh = '''('' пропущена: ';
  SRightBracketExpectedEh = ''')'' пропущена: ';
  SErrorInExpressionEh = 'Помилка у виразі: ';
  SUnexpectedExpressionBeforeNullEh = 'Пропущено вираз перед Null: ';
  SUnexpectedExpressionAfterOperatorEh = 'Пропущено вираз після оператора: ';
  SIncorrectExpressionEh = 'Невірний вираз: ';
  SUnexpectedANDorOREh = 'Пропущено AND або OR: ';

  SGridSelectionInfo_Sum = 'Sum';
  SGridSelectionInfo_Cnt = 'Count';
  SGridSelectionInfo_Evg = 'Average';
  SGridSelectionInfo_Min = 'Min';
  SGridSelectionInfo_Max = 'Max';
  SCellCountEh = 'Cell Count';

  SFirstRecordEh = 'Перший запис';
  SPriorRecordEh = 'Попередній запис';
  SNextRecordEh = 'Наступний запис';
  SLastRecordEh = 'Останній запис';
  SInsertRecordEh = 'Вставити запис';
  SDeleteRecordEh = 'Видалити запис';
  SEditRecordEh = 'Редагувати запис';
  SPostEditEh = 'Підтвердити редагування';
  SCancelEditEh = 'Відмінити редагування';
  SConfirmCaptionEh = 'Підтвердити';
  SRefreshRecordEh = 'Оновити дані';

  SDeleteMultipleRecordsQuestionEh = 'Видалити %d вибраних записів?';
  SDeleteAllRecordsQuestionEh = 'Видалити всі записи?';

  SDuplicateVarNameEh = 'Змінна з ім''ям ''%s'' уже є в Колекції';

  SSearchPanelEditorPromptText = 'Пошук...';
  SUnsupportedFieldTypeEh = 'Непідтримуваний тип (%s) для поля %s';

  SSearchPanelApplyFilterEh = 'Показати усі записи, які містять текст';
  SSearchPanelCancelFilterEh = 'Відмінити фільтр і очистити рядок пошуку';
  SSearchPanelFindNextEh = 'Шукати наступну відповідність';
  SSearchPanelFindPrevEh = 'Шукати попередню відповідність';
  SSearchPanelOptionsEh = 'Показати опції пошуку';

  SSortingByThisColumnIsNotPossibleEh = 'Сортування за цим стовпцем неможливе';
  SGroupingByThisColumnIsNotPossibleEh = 'Групування за цим стовпцем неможливе';

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

