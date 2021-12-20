@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forHolidayText'
define view entity ZI_BC_HOLIDAYTEXT_HSY
  as select from ZHSY_FCAL_HOLI_T
  association to parent ZI_BC_Holiday_HSY as _Holiday on $projection.HolidayID = _Holiday.HolidayID
  association [1] to ZI_BC_Holiday_S_HSY as _Holiday_S on $projection.SingletonID = _Holiday_S.SingletonID
{
  key SPRAS as Language,
  key HOLIDAY_ID as HolidayID,
  FCAL_DESCRIPTION as FcalDescription,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _Holiday,
  _Holiday_S,
  1 as SingletonID
  
}
