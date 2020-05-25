defmodule Parser do

  def programa_parser(lista_tokens) when lista_tokens != [] do
    # IO.inspect(lista_tokens, label: "Entrada de parser")
    funcion = funcion_parser(lista_tokens)

    case funcion do
      {{:error, mensaje_error}, _rest} ->
        {:error, mensaje_error}

      {funcion_nodo, rest} ->          
        if rest == []  do
          %AST{node_name: :program, left_node: funcion_nodo}
        else
          {:error, "Error: Falla en los operandos"}
        end
    end
  end

  def funcion_parser([tupla_siguiente | rest]) do
    {_num, siguiente_token} = tupla_siguiente

    if siguiente_token == :pclave_int do
      [tupla_siguiente | rest] = rest
      {_num, siguiente_token} = tupla_siguiente

      if siguiente_token == :pclave_main do
        [tupla_siguiente | rest] = rest
        { num, siguiente_token} = tupla_siguiente

        if siguiente_token == :abre_paren do
          [tupla_siguiente | rest] = rest
          {_num, siguiente_token} = tupla_siguiente

          if siguiente_token == :cierra_paren do
            [tupla_siguiente | rest] = rest
            {_num, siguiente_token} = tupla_siguiente

            if siguiente_token == :abre_llave do
              analizador = analizador_gramatica(rest)

              case analizador do
                {{:error, _mensaje_error}, _rest} -> ##CHECAR BIEN CUANDO SE DEFINAN LOS ERRORES
                  # Tuvo que ser cambiado por las pruebas 
                {:error, "Linea: #{num}. Error: la funcion no devuelve nada"}

                {{:error, "Error: se esparaba ;"}} ->
                  {:error, "Linea: #{elem(tupla_siguiente,0)+1}. Error: Orden de operandos erroneos"}
                
                {:error, mensaje} ->
                  {:error, mensaje}

                {analizador_nodo, [tupla_siguiente | rest]} ->
                  {_num, siguiente_token} = tupla_siguiente

                  if siguiente_token == :cierra_llave do
                    {%AST{node_name: :funcion, value: :main, left_node: analizador_nodo}, rest}
                  else
                    {{:error, "Error: Se esperaba llave que cierra"}, rest}
                  end
              end
            else
              {:error, "Error: se esparaba llave que abriera"}
            end
          else
            {:error, "Linea: #{num}. Error: se esparaba parentesis que cerrara"}
          end
        else
          {:error, "Linea: #{num}. Error: se esparaba parentesis que abriera"}
        end
      else
        {:error, "Error: se esparaba funcion main"}
      end
    else
      {:error, "Linea: #{elem(siguiente_token,0)}. Error: la funcion no devuelve nada"}
    end
  end

 
