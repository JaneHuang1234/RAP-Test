CLASS zcl_rap_eml_hsy DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rap_eml_hsy IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " step 1 - READ
    READ ENTITIES OF ZI_RAP_Travel_HSY
          ENTITY travel
            FROM VALUE #( ( TravelUuid = '4F841E60859441B617000E02AB258217' ) )
          RESULT DATA(travels).

    out->write( travels ).

    " step 2 - READ with Fields
    READ ENTITIES OF ZI_RAP_Travel_HSY
          ENTITY travel
            FIELDS ( AgencyId CustomerId )
          WITH VALUE #( ( TravelUuid = '4F841E60859441B617000E02AB258217' ) )
          RESULT travels.
    out->write( travels ).

    " step 3 - READ with ALL Fields
    READ ENTITIES OF ZI_RAP_Travel_HSY
          ENTITY travel
            ALL FIELDS
          WITH VALUE #( ( TravelUuid = '4F841E60859441B617000E02AB258217' ) )
          result travels.
    out->write( travels ).

    " step4 - READ by Association
    READ ENTITIES OF ZI_RAP_Travel_HSY
          ENTITY travel BY \_Booking
            ALL FIELDS WITH VALUE #( ( TravelUuid = '4F841E60859441B617000E02AB258217' ) )
          RESULT DATA(bookings).
    out->write( bookings ).

    " step 5 - Unsuccessful READ
    READ ENTITIES OF ZI_RAP_Travel_HSY
          ENTITY travel
            ALL FIELDS WITH VALUE #( ( TravelUUID = '11111111111111111111111111111111' ) )
          RESULT travels
          FAILED DATA(failed)
          REPORTED DATA(reported).

    out->write( travels ).
    out->write( failed ).   " complex structures not supported by the console output
    out->write( reported ). " complex structures not supported by the console output

    " step 6a - MODIFY Update
    MODIFY ENTITIES OF ZI_RAP_Travel_HSY
        ENTITY travel
          UPDATE
            SET FIELDS WITH VALUE
              #( ( TravelUuid  = '63841E60859441B617000E02AB258217'
                   Description = 'I like RAP@openSAP' ) )
        FAILED failed
        REPORTED reported.

    " step 6b - Commit Entities
    COMMIT ENTITIES
      RESPONSE OF ZI_RAP_Travel_HSY
      FAILED DATA(failed_commit)
      REPORTED DATA(reported_commit).

    out->write( 'Update done' ).

    " step 7 - MODIFY Create
    MODIFY ENTITIES OF ZI_RAP_Travel_HSY
      ENTITY travel
        CREATE
          SET FIELDS WITH VALUE
            #( (  %cid        = 'MyContentID_1'
                  AgencyId    = '70012'
                  CustomerId  = '14'
                  BeginDate   = cl_abap_context_info=>get_system_date( )
                  EndDate     = cl_abap_context_info=>get_system_date( ) + 10
                  Description = 'I like RAP@openSAP' ) )
       MAPPED DATA(mapped)
       FAILED failed
       reported reported.

     out->write( mapped-travel ).

     COMMIT ENTITIES
       RESPONSE OF ZI_RAP_Travel_HSY
       FAILED failed_commit
       REPORTED reported_commit.

     out->write( 'Create done' ).

     " step 8 - MODIFY Delete
     MODIFY ENTITIES OF ZI_RAP_Travel_HSY
       ENTITY travel
         DELETE FROM
           VALUE #( ( TravelUuid  = '02963580EF241EDC8884157E81E3F163' ) )
       FAILED failed
       REPORTED reported.

     COMMIT ENTITIES
       RESPONSE OF ZI_RAP_Travel_HSY
       FAILED failed_commit
       REPORTED reported_commit.

    out->write( 'Delete Done' ).
  ENDMETHOD.
ENDCLASS.
