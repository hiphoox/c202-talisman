defmodule Linker do
  def generate_binary(assembler, assembly_path) do
  	assembly_file_name = Path.basename(assembly_path)
  	binary_file_name = Path.basename(assembly_path, ".s")
  	output_dir_name = Path.dirname(assembly_path)
    assembly_path = output_dir_name <> "/" <> assembly_file_name ### direccion/archivo
    File.write!(assembly_path, assembler)
    System.cmd("gcc", [binary_file_name <> ".c", "-o#{binary_file_name}"], cd: output_dir_name)
    mensaje = "Ejecutable creado <<#{binary_file_name}>> en el directorio: #{output_dir_name}/"
    mensaje
    #File.rm!(assembly_path)

  end


end
