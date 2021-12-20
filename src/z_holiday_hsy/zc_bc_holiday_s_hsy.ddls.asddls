@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forHoliday_S'
@ObjectModel.semanticKey: [ 'SingletonID' ]
@Search.searchable: true
define root view entity ZC_BC_HOLIDAY_S_HSY
  as projection on ZI_BC_Holiday_S_HSY
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key SingletonID,
  _Holiday : redirected to composition child ZC_BC_Holiday_HSY,
  LastChangedAtMax,
  Request,
  HideTransport
  
}
