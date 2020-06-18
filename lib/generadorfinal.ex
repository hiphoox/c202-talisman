defmodule Generador_cod do

  def codigo_generador(ast) do
    codigo = post_order(ast, "")
     IO.puts("\n
  / ___|  ___    _ __ ___    _ __   (_) | |   __ _   _ __     __| |   ___  
 | |     / _ \  | '_ ` _ \  | '_ \  | | | |  / _` | | '_ \   / _` |  / _ \ 
 | |___  | (_) | | | | | | | | |_) | | | | | | (_| | | | | | | (_| | | (_) |
   ____|  \___/  |_| |_| |_| | .__/  |_| |_|  \__,_| |_| |_|  \__,_|  \___/ 
                             |_|                                            ")
    IO.puts("------------------------------------------------------------------------------------------------------------\n")
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
      add %rbx, %rax
    """
  end
  
 def entregar_codigo(:resta, code_snippet, _) do
    code_snippet<> 
    """
      sub     %rax, %rbx
      mov     %rbx, %rax
     """
  end
   def entregar_codigo(:multiplicacion, code_snippet, _) do
    code_snippet<>
    """
      imul %rbx, %rax;
    """
  end
  
  def entregar_codigo(:division, code_snippet, _) do
    code_snippet<>
    """
      push     %rax
      mov      %rbx, %rax
      popq     %rbx
      cqo
      idivq    %rbx
    """
  end
 
 ##Operandos 4 entrega

   def entregar_codigo(:menor_que, code_snippet, _) do
    code_snippet<>
    """
      cmpl %eax, %ebx
      mov $0, %eax
      setl %al
    """
  end
  def entregar_codigo(:mayor_que, code_snippet, _) do
    code_snippet<>
    """
      cmpl %eax, %ebx
      movl $0, %eax
      setg %al 
    """
  end
  
   def entregar_codigo(:menor_igual, code_snippet, _) do
    code_snippet<>
    """
      cmpl %eax, %ebx
      movl $0, %eax
      setle %al
    """
  end
  
  def entregar_codigo(:mayor_igual, code_snippet, _) do
    code_snippet<>
    """
      cmpl %eax,%ebx
      movl $0, %eax
      setge %al
    """
  end
  
    def entregar_codigo(:diferente_de, code_snippet, _) do
    code_snippet<>
    """
      cmpl %eax, %ebx
      movl $0, %eax
      setne %al
    """
  end

  def entregar_codigo(:igual_a, code_snippet, _) do
    code_snippet<>
    """
      cmp %rax,%rbx
      mov $0, %rax
      sete %al
    """
  end
 
  def entregar_codigo(:logicalAnd, code_snippet, _) do
    eg1= Regex.scan(~r/clause_and\d{1,}/, code_snippet)
    eg2 = Regex.scan(~r/clause_and\d{1,}/, code_snippet)
    calculado= Integer.to_string(length(eg1) + length(eg2) + 1)

    code_snippet <>
      """
                cmp $0, %rax
                jne clause_and#{calculado}
                jmp end_and#{calculado}
            clause_and#{calculado}:
                cmp $0, %rax
                mov $0, %rax
                setne %al
            end_and#{calculado}:
      """
  end
  
  def entregar_codigo(:logicalOr, code_snippet, _) do
    eg1 = Regex.scan(~r/clause_or\d{1,}/, code_snippet)
    eg2 = Regex.scan(~r/clause_or\d{1,}/, code_snippet)
    calculado = Integer.to_string(length(eg1) + length(eg2) + 1)

    code_snippet <>
      """
                cmp $0, %rax
                je clause_or#{calculado}
                mov $1,%rax
                jmp end_or#{calculado}
            clause_or#{calculado}:
                cmp $0, %rax
                mov $0, %rax
                setne %al
            end_or#{calculado}:
      """
  end



end