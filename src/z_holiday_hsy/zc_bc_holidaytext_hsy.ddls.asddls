@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forHolidayText'
@ObjectModel.semanticKey: [ 'HolidayID' ]
@Search.searchable: true
define view entity ZC_BC_HOLIDAYTEXT_HSY
  as projection on ZI_BC_HolidayText_HSY
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_Language', 
      element: 'Language'
    }
  } ]
  key Language,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key HolidayID,
  FcalDescription,
  LocalLastChangedAt,
  _Holiday : redirected to parent ZC_BC_Holiday_HSY,
  _Holiday_S : redirected to ZC_BC_Holiday_S_HSY,
  SingletonID
  
}
