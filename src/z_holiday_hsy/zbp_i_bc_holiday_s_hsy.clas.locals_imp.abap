CLASS LHC_HOLIDAY_S DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR Holiday_S
        RESULT result,
      SELECTTRANSPORT FOR MODIFY
        IMPORTING
          KEYS FOR ACTION Holiday_S~selectTransport
        RESULT result.
ENDCLASS.

CLASS LHC_HOLIDAY_S IMPLEMENTATION.
  METHOD GET_INSTANCE_FEATURES.
  READ ENTITIES OF ZI_BC_Holiday_S_HSY IN LOCAL MODE
  ENTITY Holiday_S
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(all).
  result = VALUE #( ( %tky = all[ 1 ]-%tky
                      %action-selecttransport = COND #( WHEN all[ 1 ]-%is_draft = if_abap_behv=>mk-on THEN if_abap_behv=>mk-off
                                                        ELSE if_abap_behv=>mk-on  )   ) ).
  ENDMETHOD.
  METHOD SELECTTRANSPORT.
  MODIFY ENTITIES OF ZI_BC_Holiday_S_HSY IN LOCAL MODE
  ENTITY Holiday_S
  UPDATE FIELDS ( request hidetransport )
  WITH VALUE #( FOR key IN keys
                 ( %tky         = key-%tky
                   request = key-%param-transportrequestid
                   hidetransport = abap_false ) )
      FAILED failed
      REPORTED reported.


      READ ENTITIES OF ZI_BC_Holiday_S_HSY  IN LOCAL MODE
        ENTITY Holiday_S
          ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(singletons).
      result = VALUE #( FOR singleton IN singletons
                          ( %tky   = singleton-%tky
                            %param = singleton ) ).
  ENDMETHOD.
ENDCLASS.
