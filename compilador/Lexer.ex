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
	 
	 "+" <> t_sobrantes ->
          {:suma, t_sobrantes}

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

    if len_temp > 0 do
      lista_aux = hd(lista_principal)
      lista_principal = List.delete_at(lista_principal, 0)
      cadena_aux = tl(lista_aux)
      cadena_aux = hd(cadena_aux)
      numRenglon = hd(lista_aux)
      lista_aux = {numRenglon,cadena_aux}
      lista_aux = Lexer.tokens(lista_aux)
      lista_tokens = lista_tokens ++ lista_aux
      Lexer.lexer_principal(lista_principal, lista_tokens)
    else
      if errores(lista_tokens) == true do
        lista_tokens
      else
        errores(lista_tokens) 
      end
    end
  end

  def errores (lista_tokens) do 
    if lista_tokens != [] do 
      [ini | fin] = lista_tokens 
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
