"Estrutura criada para receber os dados de wa-input-cep_cnpj_response-atividade_principal(tipo categoria de tabela)
TYPES: BEGIN OF ty_campo1,
         text TYPE string,
         tipo TYPE char4,
       END OF ty_campo1.

"declaração de classe local para chamada do proxy
CLASS lcl_proxy DEFINITION.
  PUBLIC SECTION.
    METHODS:
      chamar_proxy,
      listar_dados.

*Declaração de variáveis da classe
  PRIVATE SECTION.
    DATA: lr_proxi TYPE REF TO zco_consulta_sync_out,
          i_output TYPE zcep_cnpj1,
          wa_input TYPE zcep_cnpj_response1,
          lo_root  TYPE REF TO cx_ai_system_fault,
          lv_msgt  TYPE string,
          t_saida  TYPE TABLE OF ty_campo1,
          wa_saida LIKE LINE OF t_saida.
ENDCLASS.