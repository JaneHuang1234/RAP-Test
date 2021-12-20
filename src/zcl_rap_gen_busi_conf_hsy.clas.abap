CLASS zcl_rap_gen_busi_conf_hsy DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS: main REDEFINITION.
    METHODS get_json_string
      RETURNING VALUE(json_string) TYPE string.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rap_gen_busi_conf_hsy IMPLEMENTATION.
  METHOD main.
    TRY.
        DATA(json_string) = get_json_string( ).
        DATA(rap_generator) = /dmo/cl_rap_generator=>create_for_cloud_development( json_string ).
*        DATA(rap_generator) = /dmo/cl_rap_generator=>create_for_s4_2020_development( json_string ).
        DATA(framework_messages) = rap_generator->generate_bo( ).
        IF rap_generator->exception_occured( ).
          out->write( |Caution: Exception occured| ).
          out->write( |Check repository objects of RAP BO { rap_generator->get_rap_bo_name( ) }. | ).
        ELSE.
          out->write( |RAP BO { rap_generator->get_rap_bo_name( ) } generated successfully| ).
        ENDIF.
        out->write( |Message from framework: | ).
        LOOP AT framework_messages INTO DATA(framework_message).
          out->write( framework_message ).
        ENDLOOP.
      CATCH /dmo/cx_rap_generator INTO DATA(rap_generator_exception).
        out->write( |RAP Generator has raised the following exception:| ).
        out->write( rap_generator_exception->get_text( ) ).
    ENDTRY.
  ENDMETHOD.

  METHOD get_json_string.
    json_string = '{' &&
                '    "$schema": "https://raw.githubusercontent.com/SAP-samples/cloud-abap-rap/main/json_schemas/RAPGenerator-schema-all.json",' &&
                '    "namespace": "Z",' &&
                '    "package": "Z_HOLIDAY_HSY",' &&
                '    "dataSourceType": "table",' &&
                '    "multiInlineEdit": true,' &&
                '    "isCustomizingTable": false,' &&
                '    "addBusinessConfigurationRegistration": true,' &&
                '    "implementationtype": "managed_semantic",' &&
                '    "bindingType": "odata_v4_ui",' &&
                '    "prefix": "BC_",' &&
                '    "suffix": "_HSY",' &&
                '    "draftenabled": true,' &&
                '    "hierarchy": {' &&
                '        "entityName": "Holiday",' &&
                '        "dataSource": "zhsy_fcal_holi",' &&
                '        "objectId": "holiday_id",' &&
                '        "localInstanceLastChangedAt": "local_last_changed_at",        ' &&
                '        "etagMaster": "local_last_changed_at",' &&
                '        "children": [' &&
                '            {' &&
                '                "entityName": "HolidayText",' &&
                '                "dataSource": "zhsy_fcal_holi_t",' &&
                '                "objectId": "holiday_id",' &&
                '                "localInstanceLastChangedAt": "local_last_changed_at",' &&
                '                "etagMaster": "local_last_changed_at"' &&
                '            }' &&
                '        ]' &&
                '    }' &&
                '}'.
  ENDMETHOD.

ENDCLASS.
