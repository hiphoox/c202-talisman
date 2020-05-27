defmodule ImprimirArbol do
  def imprimir(ast) do
    IO.puts("\n \n Salida de Parser:  \n")
    IO.inspect(ast)
    IO.puts("\n\n")
    #post_order(ast)
    IO.puts("\n\n")
  end

  def post_order(node) do
    case node do
      nil ->
        nil

      ast_node ->
        padre = Atom.to_string(ast_node.node_name)
        IO.puts("Padre " <> padre)

        resul = post_order(ast_node.left_node)
        if resul == 1 do 
          nombre = Atom.to_string(ast_node.left_node.node_name)
          IO.puts("Hijo_izq" <> nombre)
        else 
          #nodo hoja
          value = ast_node.value
          IO.puts(value)
        end

        resul =  post_order(ast_node.right_node)
    end
  end
end
