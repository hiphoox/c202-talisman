defmodule Menu do
  @commands %{
    "help" => "imprime las banderas que pueden ser utilizadas",
    "tk" => "Imprime la lista de tokens obtenida por el Lexer",
    "ast" => "Imprime el arbol AST obtenido por el parser",
    "gc" => "Imprime el codigo ensamblador generado",
  }

  def main(args) do
    args
    |> parse_args
    |> IO.inspect(label: "Salida de parse_args")
    |> process_args
  end

  #### CASOS
  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean, tk: :boolean, ast: :boolean, gc: :boolean, o: :boolean])
  end


  defp process_args({[help: true], _, _}) do
    print_help_message()
  end

  defp process_args({[], [], []}) do
    print_help_message()
  end

  defp process_args({_, [], []}) do
    print_help_message()
  end

  defp process_args({[], [file_name], _}) do
    if formato_file(file_name) == true do
      compile_file(file_name)
    else
      IO.puts("Archivo no valido")
    end
  end

  defp process_args({[ast: true], [file_name], _}) do
    if formato_file(file_name) == true do
      compile_file_ast(file_name)
    else
      IO.puts("Archivo no valido")
    end
  end

  defp process_args({[gc: true], [file_name], _}) do
    if formato_file(file_name) == true do
      compile_file_gc(file_name)
    else
      IO.puts("Archivo no valido")
    end
  end

  defp process_args({[tk: true], [file_name], _}) do
    if formato_file(file_name) == true do
      compile_file_tk(file_name)
    else
      IO.puts("Archivo no valido")
    end
  end

  ### Formato de archivo 

  defp formato_file(file_name) do
    file_name = String.split(file_name, ".")
    # IO.inspect(file_name, label: "Salida split nombre archivo")
    [_nom | ext] = file_name
    # IO.inspect(ext,label: "Continuamos")
    if ext == ["c"] do
      true
    else
      false
    end
  end


  ####   

   def compile_file(file_path) do
    IO.puts("Compiling file: " <> file_path)
    assembly_path = String.replace_trailing(file_path, ".c", ".s")

    doc = File.read!(file_path)
    depu = TalismanCompiler.depuracion(doc)
    IO.inspect(depu,label: "\nSanitizer ouput")
    tokens =  Lexer.lexer_principal(depu,[])
      case tokens do 
        {:error, _algo} ->
          IO.inspect(tokens,label: "\nLexer ouput")
        _->
          IO.inspect(tokens,label: "\nLexer ouput")
          ast = Parser.programa_parser(tokens)
        case ast do
          {:error, _algo} ->
              IO.inspect(ast,label: "\nLexer ouput")
          _->
            IO.inspect(ast,label: "\nParser ouput")
            gc = Generador_cod.codigo_generador(ast)
            case gc do 
              {:error, _algo} ->
                  IO.inspect(gc,label: "\n\n GC generado: \n")
              _->
                 fin = Linker.generate_binary(gc,assembly_path)
                 IO.inspect(fin, label: "\n RUTAS")
            end 
        end
      end
  end 


  defp compile_file_tk(file_path) do
    documento = File.read!(file_path)
    listasan = TalismanCompiler.depuracion(documento)
    IO.inspect(listasan, label: "Salida depuracion\n")
    listatokens = Lexer.lexer_principal(listasan, [])
    IO.inspect(listatokens, label: "\nSalida lexer (lista de tokens) \n")
  end

  defp compile_file_ast(file_path) do
    documento = File.read!(file_path)
    listasan = TalismanCompiler.depuracion(documento)
    listatokens = Lexer.lexer_principal(listasan, [])
    arbolast = Parser.programa_parser(listatokens)
    ImprimirArbol.imprimir(arbolast)
  end

  defp compile_file_gc(file_path) do
    documento = File.read!(file_path)
    listasan = TalismanCompiler.depuracion(documento)
    listatokens = Lexer.lexer_principal(listasan, [])
    arbolast = Parser.programa_parser(listatokens)
    _generador_codigo = Generador_cod.codigo_generador(arbolast)
  end


  #### Mensaje de help

  defp print_help_message do
    IO.puts("\n Funciones del compilador :\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)

     IO.puts("\n Ejemplo: ./talisman_compiler --opcion nombre.c \n")
  end
end
