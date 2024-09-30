import numpy as np
from PIL import Image

def hex_to_rgb(hex_str):
    """Convierte un string hexadecimal (sin espacios) en un valor RGB."""
    r = int(hex_str[0:2], 16)
    g = int(hex_str[2:4], 16)
    b = int(hex_str[4:6], 16)
    return (r, g, b)

def generar_imagen(hex_file, output_image):
    # Dimensiones de la imagen
    width, height = 400, 400
    
    # Crear un array para almacenar los valores RGB de los píxeles
    image_data = np.zeros((height, width, 3), dtype=np.uint8)
    
    # Leer el archivo de texto que contiene los valores hexadecimales
    with open(hex_file, 'r') as file:
        hex_values = file.read().splitlines()
    
    # Asegurarse de que el archivo tenga suficientes valores
    if len(hex_values) < width * height:
        raise ValueError(f"El archivo debe tener al menos {width * height} valores hexadecimales.")
    
    # Asignar los valores RGB a la imagen
    index = 0
    for y in range(height):
        for x in range(width):
            rgb = hex_to_rgb(hex_values[index])
            image_data[y, x] = rgb
            index += 1

    # Crear la imagen utilizando PIL y guardar el archivo
    img = Image.fromarray(image_data)
    img.save(output_image)
    print(f"Imagen guardada como {output_image}")

# Uso del código
archivo_hexadecimal = 'ruta/del/archivo.txt'  # Cambia esto por la ruta de tu archivo .txt con los hexadecimales
imagen_salida = 'imagen_generada.png'        # Nombre del archivo de salida

generar_imagen(archivo_hexadecimal, imagen_salida)
