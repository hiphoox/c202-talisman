defmodule Parser do
#Ingreso tokens
 def programa_parser(lista_tokens) when lista_tokens != [] do
    # IO.inspect(lista_tokens, label: "Entrada de parser")
    funcion = funcion_parser(lista_tokens)
    case funcion do
      {{:error, mensaje_error}, _rest} ->
        {:error, mensaje_error}

      {funcion_nodo, rest} ->          
        if rest == []  do
          AST{node_name: :program, left_node: funcion_nodo}
        else
          {:error, "Error: Falla en los operandos"}
        end
    end
  end
# Funcion tokens primera entrega
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

                  if siguiente_token == :cierra_llave do
                    {%AST{node_name: :funcion, value: :main, left_node: analizador_nodo}, rest}
                  else
                    {{:error, "Error:Falta LLave de cierre"}, rest}
                  end
              end
            else
              {:error, "Error:Falta Llave de abertura"}
            end
          else
            {:error, "Error: Falta parentesis de cierre"}
          end
        else
          {:error, "Error: Falta parentesis de abertura"}
        end
      else
        {:error, "Error: Falta de main"}
      end
  end
  
  #Parse expression
  def  while_exp(rest, termino, next) when  next !=:o_logico  do 
    {termino, rest} #solo devolvemos la lista 
  end 

  def while_exp(rest,termino,_next) do 
    [tupla_siguiente | rest ] = rest ##sacamos el operador 
    {_num , token}= tupla_siguiente
    ##Convert to operador (lo sasamos)
    op  = get_operador_binario(token)
    {op, _algo} = op
    next_term = logical_andexp(rest)
    {next_termino,rest} = next_term
    term = operador_Binario(op,termino,next_termino)
    next = peek_tokens(rest)
    while_exp(rest,term,next)
  end 
  
  
  

