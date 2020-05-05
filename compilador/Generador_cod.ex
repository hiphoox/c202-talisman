defmodule Generador_c do

  def codigo_generador(ast) do
    codigo = post_order(ast, "")
    IO.puts("\n--------------------\n")
    IO.puts(" Generacion de codigo:")
    IO.puts("\n--------------------\n")
    IO.puts(codigo)
    codigo
  end

  def post_order(node, codigo) do
    case node do
      nil ->
        ""

      ast_node ->
        if ast_node.node_name == :constante do 
          entregar_codigo(:constante, codigo, ast_node.value)
        else
          code_snippet = 
            post_order(ast_node.left_node, codigo) 
            <> post_order(ast_node.right_node, codigo) 
          entregar_codigo(ast_node.node_name, code_snippet, ast_node.value)
        end
    end
  end

  def entregar_codigo(:program, code_snippet, _) do
    """
      .file "codigo.c"
      .text
      .p2align 4
    """ <> code_snippet
  end

 
  def entregar_codigo(:funcion, code_snippet, :main) do
    """
      .globl  main
      main:                  
    """ <> code_snippet
  end

 
  def entregar_codigo(:return, code_snippet, _) do
    code_snippet <>
    """
      ret
    """
  end


  def entregar_codigo(:constante, _code_snippet, value) do
    """
         mov  $#{value}, %rax
    """
  end


  def entregar_codigo(:negacion, code_snippet, _) do
    code_snippet <>
    """ 
      neg %rax
    """
  end


  def entregar_codigo(:complemento, code_snippet, _) do
    code_snippet <>
    """
      not %rax
    """
  end


  def entregar_codigo(:negacion_logica, code_snippet, _) do
    code_snippet <>
    """
      cmp $0, %rax
      mov $0, %rax
      sete %al
    """
  end
  def entregar_codigo(:suma, code_snippet, _) do
    code_snippet<>
    """
      add 
    """
  end



end