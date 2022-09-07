CLASS lcl_proxy IMPLEMENTATION.

    METHOD chamar_proxy.
  
      "Campos da tela de seleção iguais aos campos da estrtura do proxy
      i_output-cep_cnpj-tipo     = p_tipo.
      i_output-cep_cnpj-cep_cnpj = p_chave.
  
  
      TRY.
          "Proxy acesso transmissão dados
          IF lr_proxi IS NOT BOUND.
            "Cria um objeto do tipo da classe do proxy
            CREATE OBJECT lr_proxi TYPE zco_consulta_sync_out.
          ENDIF.
  
          "Chama o metodo que irá retornar os dados do proxy
          CALL METHOD lr_proxi->consulta_sync_out
            EXPORTING
              output = i_output
            IMPORTING
              input  = wa_input.
  
          "move o campo da estrutura wa_input(tipo categoria de tabela) para tabela interna
          MOVE-CORRESPONDING wa_input-cep_cnpj_response-atividade_principal TO t_saida.
  
          "Determina a linha a ser lida da tabela para a work area
          READ TABLE t_saida INTO wa_saida INDEX 1.
  
  
          "Tratamento de erro
        CATCH cx_ai_system_fault INTO lo_root.
          lv_msgt = lo_root->get_text( ).
          MESSAGE lv_msgt TYPE 'E' DISPLAY LIKE 'W'.
      ENDTRY.
  
      "Chama o metodo que irá listar os dados encontrados no proxy
      me->listar_dados( ).
    ENDMETHOD.
  
    METHOD listar_dados.
  
  
      "Variável que receberá o valor de p_chave no formato de CNPJ
      DATA: lv_cnpj TYPE char20.
  
      "Lista os dados filtrando pelo tipo na tela de seleção
      CASE p_tipo.
        WHEN 'CEP'.
  
          WRITE:
                / 'CEP: '         && wa_input-cep_cnpj_response-cep,
                / 'Logradouro : ' && wa_input-cep_cnpj_response-logradouro,
                / 'Numero: '      && wa_input-cep_cnpj_response-numero,
                / 'Complemento: ' && wa_input-cep_cnpj_response-complemento,
                / 'Bairro: '      && wa_input-cep_cnpj_response-bairro,
                / 'Localidade: '  && wa_input-cep_cnpj_response-localidade,
                / 'UF: '          && wa_input-cep_cnpj_response-uf.
  
        WHEN 'CNPJ'.
  
          "Usa uma mascara para separar o campo em formato de um CNPJ
          WRITE p_chave USING EDIT MASK '__.___.___/____-__' TO lv_cnpj.
  
          WRITE:/'CNPJ: '                 && lv_cnpj,
                / 'Atividade Principal: ' && wa_saida-text,
                / 'Tipo: '                && wa_input-cep_cnpj_response-tipo,
                / 'Nome: '                && wa_input-cep_cnpj_response-nome,
                / 'Telefone: '            && wa_input-cep_cnpj_response-telefone,
                / 'E-mail: '              && wa_input-cep_cnpj_response-email,
                / 'Situação: '            && wa_input-cep_cnpj_response-situacao,
                / 'Data Situação: '       && wa_input-cep_cnpj_response-data_situacao,
                / 'Abertura: '            && wa_input-cep_cnpj_response-abertura,
                / 'Natureza Juridica: '   && wa_input-cep_cnpj_response-natureza_juridica,
                / 'Nome Fantasia: '       && wa_input-cep_cnpj_response-fantasia,
                / 'Ultima Atualização: '  && wa_input-cep_cnpj_response-ultima_atualizacao,
                / 'Capital Social: '      && wa_input-cep_cnpj_response-capital_social.
  
      ENDCASE.
    ENDMETHOD.
  ENDCLASS.