@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forHoliday'
@ObjectModel.semanticKey: [ 'HolidayID' ]
@Search.searchable: true
define view entity ZC_BC_HOLIDAY_HSY
  as projection on ZI_BC_Holiday_HSY
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key HolidayID,
  MonthOfHoliday,
  DayOfHoliday,
  Configdeprecationcode,
  LastChangedAt,
  LocalLastChangedAt,
  _HolidayText : redirected to composition child ZC_BC_HolidayText_HSY,
  _Holiday_S : redirected to parent ZC_BC_Holiday_S_HSY,
  SingletonID
  
}
