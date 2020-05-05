defmodule Lexer do
  def clearesp (lista) do
    if lista != "int " and lista != "return " do
      lista=String.trim(lista)
      lista
    else
      lista
    end
  end

  def tokens({numRenglon,lista}) when lista != "" and lista != " " do
    lista = clearesp(lista)
    {token, ts} =
      case lista do
        "{" <> ts ->
          {:abre_llave, ts}

        "int " <> ts ->
          {:pclave_int, ts}

        "main" <> ts ->
          {:pclave_main, ts}

        "(" <> ts ->
          {:abre_paren, ts}

        ")" <> ts ->
          {:cierra_paren, ts}

        "return " <> ts ->
          {:pclave_return, ts}

        "-" <> ts ->
          {:negacion, ts}

        "~" <> ts ->
          {:complemento, ts}
	
        "!=" <> ts ->
          {:diferente_de, ts}

        _ -> 
          case Regex.run(~r/^\d+/, lista) do
            [value] -> {{:constante, String.to_integer(value)}, String.trim_leading(lista, value)}
            _ -> {:error_token, " "}
          end
      end
    
    ts = tokens({numRenglon,ts})
    [{numRenglon,token} | ts]
    
  end

  def tokens(_lista) do
    []
  end

  def flatmap([{numRenglon,cadena}]) do
    Enum.flat_map({numRenglon,cadena}, &tokens/1)
  end

  def lexer_principal(lista_principal, lista_tokens) do
    len_temp = length(lista_principal)

    #verifica que la lista ingresada este vacía
    if len_temp > 0 do
      #lista auxiliar que contien el primer elemento de la lista ingresada
      lista_aux = hd(lista_principal)
      #se elimina el primer elemento de la lista ingresada 
      lista_principal = List.delete_at(lista_principal, 0)
      cadena_aux = tl(lista_aux)
      cadena_aux = hd(cadena_aux)
      numRenglon = hd(lista_aux)
      lista_aux = {numRenglon,cadena_aux}
      #el primer elemento de la lista ingresada se compara con los tokens predefinidos
      lista_aux = Lexer.tokens(lista_aux)
      # a la lista de tokens se le va agregando los elementos ya comparados
      lista_tokens = lista_tokens ++ lista_aux
      # la función es recursiva hasta que la lista ingresada este vacía
      Lexer.lexer_principal(lista_principal, lista_tokens)
    else
      #antes de imprimir la lista de tokens se verifica que no haya errores.
      if errores(lista_tokens) == true do # si la funcion manda un true entonces no hay errores
        lista_tokens
      else
        errores(lista_tokens) #de lo contrario vuelve a llamar a la funcion
      end
    end
  end

  #recibe una lista de tuplas
  def errores (lista_tokens) do 
    #verifica que la lista final no sea vacía
    if lista_tokens != [] do 
      #divide la lista en cabeza y cola
      [ini | fin] = lista_tokens 
      #compara el token de la tupla con el atomo de error
      if elem(ini,1) == :error_token do  
        {:error, "linea: #{elem(ini,0)}; #{elem(ini,1)} no definido"}
      else
        errores(fin)
      end
    else
      :true
    end
  end
end