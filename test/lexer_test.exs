# Salidas de Lexer
# int  -> :pclave_int 
# main -> :pclave_main
# ( -> :abre_paren
# ) -> :cierra_paren
# { -> :abre_llave
# return -> :pclave_return
# ; -> :puntoycoma
# } -> cierra_llave
# Lo restante debe ser constante


defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

###### - Casos validos ######

  setup_all do
    {:ok,
      tokens: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, {:constante, 2}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_100: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, {:constante, 100}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_0: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, {:constante, 0}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_se: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {1, :pclave_return},
    {1, {:constante, 2}},
    {1, :puntoycoma},
    {1, :cierra_llave}
    ], 

    tokens_1: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, :negacion},
    {2, {:constante, 2}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_2: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, :negacion_logica},
    {2, {:constante, 2}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_3: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, :complemento},
    {2, {:constante, 2}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_nl: [
    {1, :pclave_int},
    {2, :pclave_main},
    {3, :abre_paren},
    {4, :cierra_paren},
    {5, :abre_llave},
    {6, :pclave_return},
    {7, {:constante, 2}},
    {8, :puntoycoma},
    {9, :cierra_llave}
    ], 

    tokens_4: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, :negacion},
    {2, :complemento},
    {2, {:constante, 0}},
    {2, :puntoycoma},
    {3, :cierra_llave}  
    ],
    
    tokens_5: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, :negacion_logica},
    {2, :negacion},
    {2, {:constante, 3}},
    {2, :puntoycoma},
    {3, :cierra_llave}  
    ],

    tokens_add: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, {:constante, 1}},
    {2, :suma},
    {2, {:constante, 2}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_aso: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, {:constante, 1}},
    {2, :negacion},
    {2, {:constante, 2}},
    {2, :negacion},
    {2, {:constante, 3}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_aso2: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, {:constante, 6}},
    {2, :division},
    {2, {:constante, 3}},
    {2, :division},
    {2, {:constante, 2}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_paren: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, {:constante, 2}},
    {2, :multiplicacion},
    {2, :abre_paren},
    {2, {:constante, 3}},
    {2, :suma},
    {2, {:constante, 4}},
    {2, :cierra_paren},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_subNeg: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, {:constante, 2}},
    {2, :negacion},
    {2, :negacion},
    {2, {:constante, 1}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_unopP: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, :complemento},
    {2, :abre_paren},
    {2, {:constante, 1}},
    {2, :suma},
    {2, {:constante, 1}},
    {2, :cierra_paren},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ], 

    tokens_prec24: [
    {1, :pclave_int},
    {1, :pclave_main},
    {1, :abre_paren},
    {1, :cierra_paren},
    {1, :abre_llave},
    {2, :pclave_return},
    {2, :abre_paren},
    {2, {:constante, 1}},
    {2, :logicalOr},
    {2, {:constante, 0}},
    {2, :cierra_paren},
    {2, :logicalAnd},
    {2, {:constante, 0}},
    {2, :puntoycoma},
    {3, :cierra_llave}
    ]

  }end

#Semana 1

  test " Return 2", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main(){"], [2, "return "], [2, "2;"], [3, "}"]], []
  ) == state[:tokens]
  end
  
  test " Return 0", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main(){"], [2, "return "], [2, "0;"], [3, "}"]], []
  ) == state[:tokens_0]
  end

  
  test " Solo espaciado", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main"], [1, "("], [1, ")"], [1, "{"], [1, "return "], [1, "2"], [1, ";"], [1, "}"]], []
  ) == state[:tokens_se]
  end
  
  test " Sin saltos de linea", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main"], [1, "("], [1, ")"], [1, "{"], [1, "return "], [1, "2"], [1, ";"], [1, "}"]], []
  ) == state[:tokens_se]
  end

#Semana 2

  test " Falta punto y coma", state do
    expected_result = state[:tokens] -- [{2, :puntoycoma}]
    assert Lexer.lexer_principal([[1, "int "], [1, "main(){"], [2, "return "], [2, "2"], [3, "}"]], []
      ) == expected_result
  end

  test " Faltan parentesis", state do
    expected_result = state[:tokens] -- [{1, :abre_paren}, {1, :cierra_paren},]
    assert Lexer.lexer_principal([[1, "int "], [1, "main"], [1, "{"], [2, "return "], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falta valor a retornar", state do
    expected_result = state[:tokens] -- [{2, {:constante, 2}}]
    assert Lexer.lexer_principal([[1, "int "], [1, "main(){"], [2, "return ;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falta cerrar parentesis", state do
    expected_result = state[:tokens] -- [{1, :cierra_paren}]
    assert Lexer.lexer_principal([[1, "int "], [1, "main("], [1, "{"], [2, "return "], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

#Errores Semana 2

  test " Diferente de 5", state do
    expected_result = List.update_at(state[:tokens_2], 7, fn _ -> {2, {:constante, 5}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!5;"], [3, "}"]], []
    ) == expected_result
  end

  test " Nested Ops ", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!-3;"], [3, "}"]], []
    ) == state[:tokens_5]
  end

  test " Nested Ops - 2", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "-~0;"], [3, "}"]], []
    ) == state[:tokens_4]
  end

  test " Negacion", state do
    expected_result = List.update_at(state[:tokens_1], 7, fn _ -> {2, {:constante, 5}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "-5;"], [3, "}"]], []
    ) == expected_result
  end

  test " bitwise 0", state do
    expected_result = List.update_at(state[:tokens_3], 7, fn _ -> {2, {:constante, 0}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "~0;"], [3, "}"]], []
    ) == expected_result    
  end

  test " bitwise", state do
    expected_result = List.update_at(state[:tokens_2], 7, fn _ -> {2, {:constante, 12}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!12;"], [3, "}"]], []
    ) == expected_result
  end

#Errores Semana 2

  test " orden erroneo", state do
    expected_result = List.update_at(state[:tokens_1], 6, fn _ -> {2, {:constante, 4}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :negacion} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "4-;"], [3, "}"]], []
    ) == expected_result
  end

  test " falta constante", state do
    expected_result = List.update_at(state[:tokens_2], 7, fn _ -> {2, :complemento} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "!~;"], [3, "}"]], []
      ) == expected_result
  end


#Semana 3

  test " suma 1 + 2", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "+"], [2, "2;"], [3, "}"]], []
      ) == state[:tokens_add]
  end  
  
  test " asociatividad", state do 
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "-"], [2, "2"], [2, "-"], [2, "3;"], [3, "}"]], []
      ) == state[:tokens_aso]
  end

  test " division", state do
    expected_result = List.update_at(state[:tokens_add], 6, fn _ -> {2, {:constante, 4}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :division} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 2}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "4"], [2, "/"], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " multiplicacion", state do
    expected_result = List.update_at(state[:tokens_add], 6, fn _ -> {2, {:constante, 2}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :multiplicacion} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 3}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "2"], [2, "*"], [2, "3;"], [3, "}"]], []
      ) == expected_result
  end

  test " operaciones con parentesis", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "2"], [2, "*"], [2, "(3"], [2, "+"], [2, "4);"], [3, "}"]], []
      ) == state[:tokens_paren]
  end


  test "sub", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :negacion} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "-"], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " sub neg", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "2-"], [2, "-1;"], [3, "}"]], []
      ) == state[:tokens_subNeg]
  end

  test " operador complemento suma", state do
    expected_result = List.update_at(state[:tokens_subNeg], 6, fn _ -> {2, :complemento} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, {:constante, 2}} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, :suma} end)
    expected_result = List.update_at(expected_result, 9, fn _ -> {2, {:constante, 3}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "~2"], [2, "+"], [2, "3;"], [3, "}"]], []
      ) == expected_result
  end

  test "operador complemento parentesis", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "~(1"], [2, "+"], [2, "1);"], [3, "}"]], []
      ) == state[:tokens_unopP]
  end

#Errores semana 3


  test " falta primer valor", state do
    expected_result = List.update_at(state[:tokens_2], 6, fn _ -> {2, :division} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, {:constante, 3}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "/3;"], [3, "}"]], []
      ) == expected_result
  end

  test " falta segundo valor", state do
    expected_result = List.update_at(state[:tokens_2], 6, fn _ -> {2, {:constante, 1}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :suma} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "+"], [2, ";"], [3, "}"]], []
      ) == expected_result
  end

  test " falta punto y coma en multiplicacion", state do
    expected_result = List.update_at(state[:tokens_add], 6, fn _ -> {2, {:constante, 2}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :multiplicacion} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 2}} end)
    expected_result = expected_result -- [{2, :puntoycoma}]
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "2*2"], [3, "}"]], []
      ) == expected_result
  end

#Semana 4

  test " Falso and", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :logicalAnd} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 0}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "&&"], [2, "0;"], [3, "}"]], []
      ) == expected_result
  end

  test " Verdadero and", state do
    expected_result = List.update_at(state[:tokens_subNeg], 6, fn _ -> {2, {:constante, 1}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :logicalAnd} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, :negacion} end)
    expected_result = List.update_at(expected_result, 9, fn _ -> {2, {:constante, 1}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "&&"], [2, "-1;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falso igual", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :igual_a} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "=="], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Verdadero igual",state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :igual_a} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 1}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "=="], [2, "1;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falso mayor o igual a", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :mayor_igual} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, ">="], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Verdadero mayor o igual a", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :mayor_igual} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 1}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, ">="], [2, "1;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falso mayor a", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :mayor_que} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, ">"], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Verdadero mayor a", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :mayor_que} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 0}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, ">"], [2, "0;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falso menor o igual a", state do
    expected_result = List.update_at(state[:tokens_subNeg], 7, fn _ -> {2, :menor_igual} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, :negacion} end)
    expected_result = List.update_at(expected_result, 9, fn _ -> {2, {:constante, 1}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "2"], [2, "<="], [2, "-1;"], [3, "}"]], []
      ) == expected_result
  end

  test " Verdadero menor o igual a", state do
    expected_result = List.update_at(state[:tokens_add], 6, fn _ -> {2, {:constante, 0}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :menor_igual} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 2}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "0"], [2, "<="], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falso menor a", state do
    expected_result = List.update_at(state[:tokens_add], 6, fn _ -> {2, {:constante, 2}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :menor_que} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 1}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "2"], [2, "<"], [2, "1;"], [3, "}"]], []
      ) == expected_result
  end

  test " Verdadero menor a", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :menor_que} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "<"], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falso diferente de", state do
    expected_result = List.update_at(state[:tokens_add], 6, fn _ -> {2, {:constante, 0}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :diferente_de} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 0}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "0"], [2, "!="], [2, "0;"], [3, "}"]], []
      ) == expected_result
  end

  test " Verdadero diferente de", state do
    expected_result = List.update_at(state[:tokens_aso2], 6, fn _ -> {2, :negacion} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, {:constante, 1}} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, :diferente_de} end)
    expected_result = List.update_at(expected_result, 9, fn _ -> {2, :negacion} end)
    expected_result = List.update_at(expected_result, 10, fn _ -> {2, {:constante, 2}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "-1"], [2, "!="], [2, "-2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falso or", state do
    expected_result = List.update_at(state[:tokens_add], 6, fn _ -> {2, {:constante, 0}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :logicalOr} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 0}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "0"], [2, "||"], [2, "0;"], [3, "}"]], []
      ) == expected_result
  end

  test " Verdadero or", state do
    expected_result = List.update_at(state[:tokens_add], 6, fn _ -> {2, {:constante, 1}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :logicalOr} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 0}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "||"], [2, "0;"], [3, "}"]], []
      ) == expected_result
  end

  test " Precedencia semana 4", state do #97
    expected_result = List.update_at(state[:tokens_aso2], 6, fn _ -> {2, {:constante, 1}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :logicalOr} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, {:constante, 0}} end)
    expected_result = List.update_at(expected_result, 9, fn _ -> {2, :logicalAnd} end)
    expected_result = List.update_at(expected_result, 10, fn _ -> {2, {:constante, 2}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "||"], [2, "0"], [2, "&&"], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Precedencia 2 semana 4", state do
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "(1"], [2, "||"], [2, "0)"], [2, "&&"], [2, "0;"], [3, "}"]], []
      ) == state[:tokens_prec24]
  end


#Errores Semana 4

  test " Falta primer operando semana 4", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :menor_igual} end)
    expected_result = expected_result -- [{2, {:constante, 1}}]
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "<="], [2, "2;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falta segundo operando semana 4", state do
    expected_result = state[:tokens_add] -- [{2, {:constante, 2}}]
    expected_result = List.update_at(expected_result, 6, fn _ -> {2, {:constante, 2}} end)
    expected_result = List.update_at(expected_result, 7, fn _ -> {2, :logicalAnd} end)
    expected_result = expected_result -- [{2, :puntoycoma}]
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "2"], [2, "&&"], [3, "}"]], []
      ) == expected_result
  end

  test " Falta operando de en medio", state do
    expected_result = List.update_at(state[:tokens_subNeg], 7, fn _ -> {2, :menor_que} end)
    expected_result = List.update_at(expected_result, 6, fn _ -> {2, {:constante, 1}} end)
    expected_result = List.update_at(expected_result, 8, fn _ -> {2, :mayor_que} end)
    expected_result = List.update_at(expected_result, 9, fn _ -> {2, {:constante, 3}} end)
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "<"], [2, ">"], [2, "3;"], [3, "}"]], []
      ) == expected_result
  end

  test " Falta punto y coma semana 4", state do
    expected_result = List.update_at(state[:tokens_add], 7, fn _ -> {2, :logicalOr} end)
    expected_result = expected_result -- [{2, :puntoycoma}]
    assert Lexer.lexer_principal([[1, "int "], [1, "main()"], [1, "{"], [2, "return "], [2, "1"], [2, "||"], [2, "2"], [3, "}"]], []
      ) == expected_result
  end

end
