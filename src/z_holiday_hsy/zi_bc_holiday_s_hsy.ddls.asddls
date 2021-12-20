@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forHoliday_S'
define root view entity ZI_BC_HOLIDAY_S_HSY
  as select from I_Language
    left outer join zhsy_fcal_holi as child_tab on 0 = 0
  composition [0..*] of ZI_BC_Holiday_HSY as _Holiday
{
  key 1 as SingletonID,
  _Holiday,
  max (child_tab.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as sxco_transport) as Request,
  cast( 'X' as abap_boolean) as HideTransport
  
}
where I_Language.Language = $session.system_language
