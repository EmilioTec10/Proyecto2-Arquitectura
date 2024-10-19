def create_mif_from_txt(input_txt_path, output_mif_path):
    # Leer los colores hexadecimales del archivo .txt
    with open(input_txt_path, 'r') as txt_file:
        hex_colors = [line.strip() for line in txt_file if line.strip()]

    # Verificar que el número de colores sea correcto (400x400 = 160000)
    if len(hex_colors) != 160000:
        raise ValueError("El archivo de entrada no contiene exactamente 160000 colores.")

    # Dimensiones de los bloques
    block_size = 100
    buffer = []

    # Reorganizar los colores en el orden de bloques de 100x100
    for block_row in range(0, 400, block_size):
        for block_col in range(0, 400, block_size):
            # Recorrer los píxeles dentro del bloque de 100x100
            for y in range(block_size):
                for x in range(block_size):
                    # Calcular el índice actual en la matriz de 400x400
                    current_index = (block_row + y) * 400 + (block_col + x)
                    # Agregar el valor de color hexadecimal al buffer
                    buffer.append(hex_colors[current_index])

    # Escribir el archivo .mif
    with open(output_mif_path, 'w') as mif_file:
        mif_file.write("DEPTH = 160000;\n")
        mif_file.write("WIDTH = 24;\n")
        mif_file.write("ADDRESS_RADIX = DEC;\n")
        mif_file.write("DATA_RADIX = HEX;\n")
        mif_file.write("CONTENT BEGIN\n")
        
        # Escribir cada línea con el formato "address : data;"
        for address, data in enumerate(buffer):
            mif_file.write(f"    {address} : {data};\n")
        
        mif_file.write("END;\n")

# Rutas del archivo de entrada y salida
input_txt_path = 'VGA\datos_imagen_hex.txt'
output_mif_path = 'output.mif'

# Crear el archivo .mif a partir del archivo .txt
create_mif_from_txt(input_txt_path, output_mif_path)
