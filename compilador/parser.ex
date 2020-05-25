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

  # Es el equivalente  parse_statement 
  def analizador_gramatica([tupla_siguiente | rest]) do
    {num, siguiente_token} = tupla_siguiente

    if siguiente_token == :pclave_return do
      expresion = analizador_expresion(rest)

      case expresion do
        {{:error, mensaje_error}, rest} ->
          {{:error, mensaje_error}, rest}

        {:error, mensaje}->
          {:error,mensaje}

        {exp_node, lista_final} ->
          [tupla_siguiente | rest] = lista_final
          {_num, siguiente_token} = tupla_siguiente

          # IO.inspect(lista_final, label: "Resto de regreso")

          if siguiente_token == :puntoycoma do
            {%AST{node_name: :return, left_node: exp_node}, rest}
          else
            {{:error, "Error: se esparaba ;"}}
          end
      end
    else
      {{:error, "Linea: #{num+1}. Error: se esperaba punto y coma."}}
    end
  end

    #PARA PARSE EXPRESION
    ##TAmbien se modifico este para la 4 entrega

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

  def analizador_expresion(tokens) do
    #IO.inspect("ENtramos")
    datos_term = logical_andexp(tokens)
    {termino,rest}  = datos_term  
    case datos_term do 
      {:error,mensaje} ->
        {:error,mensaje}
      _->
        next =  peek_tokens(rest) ##el que sigue 
        resultado = while_exp(rest,termino, next)
        resultado
    end 
    #IO.inspect(resultado, label: "RES analizador_expresion")
  end 


  ### PARA PARSE TERM 
  def  while_term(rest, factor, next) when  next != :division and next !=:multiplicacion do 
      {factor,rest} #solo devolvemos la lista 
  end 

   def while_term(rest,factor,_next) do 
      [tupla_siguiente | rest ] = rest #  Sacamos el operador  
      {_num,token} = tupla_siguiente
       #IO.inspect(token)
       #Convert to operador 
      op = get_operador_binario(token)
      {op, _algo}  = op
      next_term = parse_factor(rest)
      {next_factor,rest} = next_term
      term = operador_Binario(op,factor,next_factor)
      next = peek_tokens(rest)
      while_term(rest,term,next)
  end 

  def parse_term(tokens) do
    datos_factor = parse_factor(tokens) 
    # {:error , desc} ->posible error que ven
    {factor,rest}  = datos_factor 
    next =  peek_tokens(rest) ##el que sigue 
    resultado = while_term(rest,factor, next)
    resultado
    #IO.inspect(resultado, label: "RES parse_term")
  end 

  ###3#### AMBAS 
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

  def peek_tokens(tokens) do

    case tokens do 
      []-> 
        {:error, "Faltan elementos"}
      _->
        [tupla_siguiente | _rest ] = tokens
         {_num, token} = tupla_siguiente 
         token
    end 

