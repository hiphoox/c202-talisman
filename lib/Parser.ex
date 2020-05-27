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
          %AST{node_name: :program, left_node: funcion_nodo}
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
      else
      {:error, "Linea: #{elem(siguiente_token,0)}. Error: la funcion no devuelve nada"}
    end
  end

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

  
  #Parse factor

  #Parse term
 
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
    #IO.inspect(resultado, label: "pruebbababababasjjsasd")
  end 

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

        _ ->
        {{:error, "Unario no valido"}, :mal}
    end
  end

  def parse_factor([tupla_siguiente | rest]) do #REGRESA  {ALGO1,ALGO2}
    {_num, siguiente_token} = tupla_siguiente

    case siguiente_token do

      {:constante, valor} ->
        {%AST{node_name: :constante, value: valor}, rest}
        
      :abre_paren ->
        datos_regreso = analizador_expresion(rest)
        {exp , tokens}  = datos_regreso 

        #rest contiene todos los tokens debemos saber que sigue 
        [tupla_siguiente | rest] = tokens
        {_num, siguiente_token} = tupla_siguiente
      
        if siguiente_token == :cierra_paren do
          {exp, rest} #regresemos la expresion que se formo y el resto 
        else
          {:error, "Falta un parentesis )"}
        end

      un_operador ->
        valido = get_operador_unario(un_operador)

        case valido do
          {tupla_mensaje, :mal} ->
            ## Se regresa a parse_statement
            {tupla_mensaje,rest} ##no es ningun operado unario 

          {name_nodo, :ok} ->
            # Buscando su constante
            factor = parse_factor(rest)
            ## es lo que se regresa 
            crear_operador(name_nodo, factor)
        end

    end
  end

  def  while_logical_andexp(rest, termino, next) when  next != :ampersand do 
    {termino, rest} #solo devolvemos la lista 
  end 

  def while_logical_andexp(rest,termino,_next) do 
      [tupla_siguiente | rest ] = rest ##sacamos el operador 
      {_num , token}= tupla_siguiente
      ##Convert to operador (lo sasamos)
      op  = get_operador_binario(token)
      {op, _algo}  = op
      next_term = equality_exp(rest)
      {next_termino,rest} = next_term
      term = operador_Binario(op,termino,next_termino)
      next = peek_tokens(rest)
      while_logical_andexp(rest,term,next)
  end 

  def logical_andexp(tokens) do
    #IO.inspect("ENtramos")
    datos_term = equality_exp(tokens)
    {termino,rest}  = datos_term  
    next =  peek_tokens(rest) ##el que sigue 
    case next do
      {:error,mensaje} ->
        {:error, mensaje}
      _ ->
        resultado = while_logical_andexp(rest,termino, next)
        resultado
    end
    #IO.inspect(resultado, label: "RES analizador_expresion")
  end 

    ####
  def  while_equality_exp(rest, termino, next) when  next != :diferente_de  and next != :igual_a do 
    {termino, rest} #solo devolvemos la lista 
  end 

  def while_equality_exp(rest,termino,_next) do 
      [tupla_siguiente | rest ] = rest ##sacamos el operador 
      {_num , token}= tupla_siguiente
      ##Convert to operador (lo sasamos)
      op  = get_operador_binario(token)
      {op, _algo}  = op
      next_term = relational_exp(rest)
      {next_termino,rest} = next_term
      term = operador_Binario(op,termino,next_termino)
      next = peek_tokens(rest)
      while_equality_exp(rest,term,next)
  end 

  def equality_exp(tokens) do
    #IO.inspect("ENtramos")
    datos_term = relational_exp(tokens)
    {termino,rest}  = datos_term  
    next =  peek_tokens(rest) ##el que sigue 
    resultado = while_equality_exp(rest,termino, next)
    resultado
    #IO.inspect(resultado, label: "RES analizador_expresion")
  end 

  ####
  def  while_relational_exp(rest, termino, next) when  next != :menor_que  and next != :mayor_que  and next != :menor_igual and next != :mayor_igual do 
    {termino, rest} #solo devolvemos la lista 
  end 

  def while_relational_exp(rest,termino,_next) do 
      [tupla_siguiente | rest ] = rest ##sacamos el operador 
      {_num , token}= tupla_siguiente
      ##Convert to operador (lo sasamos)
      op  = get_operador_binario(token)
      {op, _algo}  = op
      next_term = additive_exp(rest)
      {next_termino,rest} = next_term
      term = operador_Binario(op,termino,next_termino)
      next = peek_tokens(rest)
      while_relational_exp(rest,term,next)
  end 

  def relational_exp(tokens) do
    #IO.inspect("ENtramos")
    datos_term = additive_exp(tokens)
    {termino,rest}  = datos_term  
    next =  peek_tokens(rest) ##el que sigue 
    resultado = while_relational_exp(rest,termino, next)
    resultado
    #IO.inspect(resultado, label: "RES analizador_expresion")
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
  def  while_aditive_exp(rest, termino, next) when  next != :suma and next !=:negacion do 
    {termino, rest} #solo devolvemos la lista 
  end 

  def while_aditive_exp(rest,termino,_next) do 
      [tupla_siguiente | rest ] = rest ##sacamos el operador 
      {_num , token}= tupla_siguiente
      ##Convert to operador (lo sasamos)
      op  = get_operador_binario(token)
      {op, _algo}  = op
      next_term = parse_term(rest)
      {next_termino,rest} = next_term
      term = operador_Binario(op,termino,next_termino)
      next = peek_tokens(rest)
      while_aditive_exp(rest,term,next)
  end 

  def additive_exp(tokens) do
    #IO.inspect("ENtramos")
    datos_term = parse_term(tokens)
    {termino,rest}  = datos_term  
    next =  peek_tokens(rest) ##el que sigue 
    resultado = while_aditive_exp(rest,termino, next)
    resultado
    #IO.inspect(resultado, label: "RES analizador_expresion")
  end 
end
