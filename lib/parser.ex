defmodule Parser do
#Ingreso tokens
 def programa_parser(lista_tokens) when lista_tokens != [] do
    # IO.inspect(lista_tokens, label: "Parser")
    funcion = funcion_parser(lista_tokens)
    case funcion do
      {{:error, mensaje_error}, _rest} ->
        {:error, mensaje_error}

      {funcion_nodo, rest} ->          
        if rest == []  do
          AST{node_name: :program, left_node: funcion_nodo}
        else
          {:error, "Error, Error, error"}
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
    [tupla_siguiente | rest ] = rest 
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
  
  #Parse factor








  #Parse term










  #Funciones de conjuncion

  def crear_operador(nombre_nodo, hijo_left) do
    case hijo_left do
      {{:error, mensaje_error}, rest} ->
        {{:error, mensaje_error}, rest}

      {next_nodo, rest} ->
        {%AST{node_name: nombre_nodo, left_node: next_nodo}, rest}
    end
  end

  def get_operador_unario(siguiente_token) do
      case siguiente_token do
        :complemento ->
          {:complemento, :ok}

        :negacion ->
          {:negacion, :ok}

        :negacion_logica ->
          {:negacion_logica, :ok}

      _ - >
        {{:error, "Unario no valido"}, :mal}
    end
  end


  def peek_tokens(tokens) do
    case tokens do 
      []-> 
        {:error, "Faltan elementos"}
      _->
        [tupla_siguiente | _rest ] = tokens
         {_num, token} = tupla_siguiente 
         token
    end 
  end

  def operador_Binario(siguiente,factor,next_factor) do 
    union  = %AST{node_name: siguiente, left_node: factor, right_node: next_factor}
  end
#fUNCION CREADA PARA TERCER ENTREGA
    def get_operador_binario(siguiente_token) do 
    case siguiente_token do 
      :suma ->
        {:suma,:ok}
      :negacion ->
        {:resta,:ok}
      :multiplicacion ->
        {:multiplicacion,:ok}
      :division ->
        {:division,:ok}
      :o_logico ->
        {:o_logico,:ok}
      :menor_que ->
         {:menor_que,:ok}
      :mayor_que ->
         {:mayor_que,:ok}
      :menor_igual ->
         {:menor_igual,:ok}
      :mayor_igual ->
         {:mayor_igual,:ok}
      :diferente_de ->
         {:diferente_de,:ok}
      :igual_a ->
         {:igual_a,:ok}
      :ampersand->
         {:ampersand,:ok}
      _ ->
       {{:error, "Binario no valido"}, :mal}
    end 

  end 
