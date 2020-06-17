defmodule Parser do
#Ingreso tokens
 def programa_parser(lista_tokens) when lista_tokens != [] do
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

                {{:error, "Error: se esperaba ;"}} ->
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
  def  while_exp(rest, termino, next) when  next !=:logicalOr  do 
    {termino, rest} #solo devolvemos la lista 
  end 

  def while_exp(rest,termino,_next) do 
    [tupla_siguiente | rest ] = rest 
    {_num , token}= tupla_siguiente
    #Se convierte el token en operador
    op  = get_operador_binario(token)
    {op, _algo} = op
    next_term = parse_term(token)
    {next_termino,rest} = next_term
    term = operador_Binario(op,termino,next_termino)
    next = peek_tokens(rest)
    while_exp(rest,term,next)
  end
  #Funcion encontrada , para ayudar a un correcto analisis de nuestras operaciones
  def analizador_expresion(tokens) do
    datos_term = parse_term(tokens)
    {termino,rest}  = datos_term  
    case datos_term do 
      {:error,mensaje} ->
        {:error,mensaje}
      _->
        next =  peek_tokens(rest) ##el que sigue 
        resultado = while_exp(rest,termino, next)
        resultado
    end 
  end 

  
  #Parse factor

   def parse_factor([tupla_siguiente | rest]) do 
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
            {tupla_mensaje,rest} 

          {name_nodo, :ok} ->
            # Buscando su constante
            factor = parse_factor(rest)
            ## es lo que se regresa 
            crear_operador(name_nodo, factor)
        end

    end
  end

  #Parse term
 
 def  while_term(rest, factor, next) when  next != :division and next !=:multiplicacion do 
      {factor,rest} #solo devolvemos la lista 
  end 

   def while_term(rest,factor,_next) do 
      [tupla_siguiente | rest ] = rest #Obtenemos un operador 
      {_num,token} = tupla_siguiente
       #Se convierte token en operador
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
      :logicalOr ->
        {:logicalOr,:ok}
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
      :logicalAnd->
         {:logicalAnd,:ok}
      _ ->
       {{:error, "Binario no valido"}, :mal}
    end 
  end

  def operador_Binario(siguiente,factor,next_factor) do 

    union  = %AST{node_name: siguiente, left_node: factor, right_node: next_factor}
    #union = "[OP : #{siguiente} FL :#{factor} Fr#{next_factor}]"
    union
  end

end