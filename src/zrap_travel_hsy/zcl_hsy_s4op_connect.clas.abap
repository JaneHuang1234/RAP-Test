CLASS zcl_hsy_s4op_connect DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hsy_s4op_connect IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
      types: begin of zz_hsy_bp,
             BusinessPartner type c length 10,
             FullName type c length 12,
             end of zz_hsy_bp.


    "Section 1: Access http resource using service consumption model
       data: ls_entity_key    type zz_hsy_bp,
             ls_business_data type zz_hsy_bp,
             lo_http_client   type ref to if_web_http_client,
             lo_client_proxy  type ref to /iwbep/if_cp_client_proxy,
             lo_resource      type ref to /iwbep/if_cp_resource_entity,
             lo_request       type ref to /iwbep/if_cp_request_read,
             lo_response      type ref to /iwbep/if_cp_response_read.

    TRY.
        " Create http client
        " Details depend on your connection settings
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                                  cl_http_destination_provider=>create_by_cloud_destination(
                                         i_name                  = 'S4TCF'
                                         i_service_instance_name = 'address-manager-destination'
                                         i_authn_mode            = if_a4c_cp_service=>service_specific   ) ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'API_BUSINESS_PARTNER'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_BUSINESS_PARTNER' ).


        " Set entity key
        ls_entity_key = value #(
                            BusinessPartner = 'JANEHUANG'
                         ).


        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_BusinessPartner' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
        out->write( ls_business_data ).
      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        out->write( 'REMOTE:' && | | && lx_remote->get_text( ) ).

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        out->write( 'GATEWAY:' && | | && lx_gateway->get_text( ) ).
      CATCH cx_web_http_client_error INTO DATA(lx_http).
        out->write( 'HTTP:' && | | && lx_http->get_text( ) ).
      CATCH cx_http_dest_provider_error INTO DATA(lx_dest).
        out->write( 'DESTINATION:' && | | && lx_dest->get_text( ) ).
    ENDTRY.



    " Section 2: Access rfc resource using service consumption model
    "    data dest type ref to if_rfc_dest.
*    DATA myobj  TYPE REF TO zcl_proxy_rfc_systeminfo.
*
*    DATA current_resources TYPE zcl_proxy_rfc_systeminfo=>syst_index.
*    DATA fast_ser_vers TYPE int4.
*    DATA maximal_resources TYPE zcl_proxy_rfc_systeminfo=>syst_index.
*    DATA recommended_delay TYPE zcl_proxy_rfc_systeminfo=>syst_index.
*    DATA rfcsi_export TYPE zcl_proxy_rfc_systeminfo=>rfcsi.
*    DATA s4_hana TYPE zcl_proxy_rfc_systeminfo=>char1.
*
*    TRY.
*        dest = cl_rfc_destination_provider=>create_by_cloud_destination( i_name = '<RFC destination name>' ).
*
*        CREATE OBJECT myobj
*          EXPORTING
*            destination = dest.
*      CATCH cx_rfc_dest_provider_error.
*        " handle CX_RFC_DEST_PROVIDER_ERROR
*    ENDTRY.
*
*    TRY.
*        myobj->rfc_system_info(
*           IMPORTING
*             current_resources = current_resources
*             fast_ser_vers = fast_ser_vers
*             maximal_resources = maximal_resources
*             recommended_delay = recommended_delay
*             rfcsi_export = rfcsi_export
*             s4_hana = s4_hana ).
*        out->write( |{ current_resources }, { fast_ser_vers }, { maximal_resources }, { recommended_delay }, { rfcsi_export-rfcchartyp }, { s4_hana }| ).
*        out->write(  rfcsi_export ).
*
*      CATCH  cx_aco_communication_failure INTO DATA(lcx_comm).
*        " handle CX_ACO_COMMUNICATION_FAILURE (sy-msg* in lcx_comm->IF_T100_MESSAGE~T100KEY)
*      CATCH cx_aco_system_failure INTO DATA(lcx_sys).
*        " handle CX_ACO_SYSTEM_FAILURE (sy-msg* in lcx_sys->IF_T100_MESSAGE~T100KEY)
*      CATCH cx_aco_application_exception INTO DATA(lcx_appl).
*        " handle APPLICATION_EXCEPTIONS (sy-msg* in lcx_appl->IF_T100_MESSAGE~T100KEY)
*    ENDTRY.

  ENDMETHOD.

ENDCLASS.
