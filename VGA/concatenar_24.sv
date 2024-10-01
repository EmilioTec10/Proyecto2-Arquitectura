module concatenar_24 (
    input logic [7:0] num1,     // Primer número de 8 bits
    input logic [7:0] num2,     // Segundo número de 8 bits
    input logic [7:0] num3,     // Tercer número de 8 bits
    output logic [23:0] result // Resultado de 24 bits
);

    // Concatenar los números de 8 bits en un número de 24 bits
    always_comb begin
        result = {num1, num2, num3}; // Concatenación
    end

endmodule