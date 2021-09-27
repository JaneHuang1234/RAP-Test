@EndUserText.label: 'Travel BO projection view'
@AccessControl.authorizationCheck: #CHECK

@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_RAP_Travel_HSY
  as projection on ZI_RAP_TRAVEL_HSY
{
  key TravelUuid,
      @Search.defaultSearchElement: true
      TravelId,
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Agency', element: 'AgencyID'} }]
      @ObjectModel.text.element: ['AgencyName']
      @Search.defaultSearchElement: true
      AgencyId,
      _Agency.Name       as AgencyName,
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer', element: 'CustomerID'} }]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      CustomerId,
      _Customer.LastName as CustomerName,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency'} }]
      CurrencyCode,
      Description,
      OverallStatus,
      LastChangedAt,
      LocalLastChangedAt,

      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZC_RAP_Booking_HSY,
      _Currency,
      _Customer
}
