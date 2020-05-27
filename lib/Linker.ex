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

 def generate_binary(assembler, assembly_path, nombre_elegido) do
  	 #return (3+4 <= 4 | 1 && 2!=3 > -6) ;
    assembly_file_name = Path.basename(assembly_path) ## Ultimo archivo de la direccion  codigo.s
    #binary_file_name = Path.basename(assembly_path, ".s") ## quito la extension del nombre  nom.s --> nom 
    output_dir_name = Path.dirname(assembly_path)## regresamos toda la direccion excepto el archivo 
    assembly_path = output_dir_name <> "/" <> assembly_file_name ### direccion/archivo
    File.write!(assembly_path, assembler) 
    System.cmd("gcc", [ assembly_file_name, "-o#{nombre_elegido}"], cd: output_dir_name)
    fin= "SE genero el ejecutable <<#{nombre_elegido}>> en la ruta: #{output_dir_name}/"
    fin
    #File.rm!(assembly_path)

  end


end
