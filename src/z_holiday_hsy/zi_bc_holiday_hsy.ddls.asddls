@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forHoliday'
define view entity ZI_BC_HOLIDAY_HSY
  as select from ZHSY_FCAL_HOLI
  association to parent ZI_BC_Holiday_S_HSY as _Holiday_S on $projection.SingletonID = _Holiday_S.SingletonID
  composition [0..*] of ZI_BC_HolidayText_HSY as _HolidayText
{
  key HOLIDAY_ID as HolidayID,
  MONTH_OF_HOLIDAY as MonthOfHoliday,
  DAY_OF_HOLIDAY as DayOfHoliday,
  CONFIGDEPRECATIONCODE as Configdeprecationcode,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _HolidayText,
  _Holiday_S,
  1 as SingletonID
  
}
