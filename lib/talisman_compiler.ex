defmodule TalismanCompiler do
  @moduledoc """
  Documentation for `TalismanCompiler`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TalismanCompiler.hello()
      :world

  """
  def hello do
    :world
  end

  def  depuracion(archivo) do  

    list = archivo |>  String.split(~r{\n})
    list =  Enum.with_index(list, 1 ) 
    list =  Enum.map(list, fn {subcadena, numRenglon} -> [numRenglon, subcadena] end ) #convertir tuplas en listas
    list =  Enum.reject(list, &Enum.member?( &1 , " " )) 

    tok = sub_listas(list)
  end

  def  sub_listas(list) do  

    if length(list) >  0  do

      lista2 = Enum.take(list, 1 ) 
      lista2 = List.flatten(lista2) 
      sobrante  = List.delete_at(list, 0 )
      lista_unica = sanit(lista2)

      if length(sobrante) > 0  do

        lista_unica = lista_unica ++ sub_listas(sobrante)

      else

        lista_unica

      end
    end
  end

  def  sanit(lista2) do 

    inicio_l = hd(lista2)
    final_l = to_string(tl(lista2))
    simbolo = final_l |>  String.split(~r{\t},trim: true)
    simbolo =  Enum.map(simbolo, fn f -> [inicio_l, f] end )
    #IO.inspect(simbolo, label: "simbolo\n")
  end


end
