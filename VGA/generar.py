def txt_to_mif(txt_path, mif_path):
    # Leer los valores RGB en hexadecimal desde el archivo de texto
    with open(txt_path, 'r') as txt_file:
        hex_values = txt_file.read().splitlines()

    # Configuración del archivo MIF
    mif_header = """-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- Quartus Prime generated Memory Initialization File (.mif)

WIDTH=24;
DEPTH={depth};

ADDRESS_RADIX=UNS;
DATA_RADIX=HEX;

CONTENT BEGIN
"""
    
    mif_content = []
    # Recorrer cada valor hexadecimal del archivo de texto
    for address, hex_value in enumerate(hex_values):
        # Se toma todo el valor hexadecimal (6 caracteres que representan RGB)
        mif_content.append(f"\t{address}  :   {hex_value};")

    mif_footer = "END;"
    
    # Escribir el archivo MIF
    with open(mif_path, 'w') as mif_file:
        mif_file.write(mif_header.format(depth=len(hex_values)))
        mif_file.write("\n".join(mif_content))
        mif_file.write("\n" + mif_footer)

# Ruta del archivo .txt y del archivo .mif de salida
txt_path = 'VGA\datos_imagen_hex.txt'
mif_path = 'imagen.mif'

txt_to_mif(txt_path, mif_path)
