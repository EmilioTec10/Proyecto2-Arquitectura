module contador_cursor (
    input logic boton_cursor,        // Botón de entrada (flanco positivo para incrementar)
    output logic [3:0] pos_cursor_contado // Salida de la posición contada
);
    // Declarar la variable pos_cursor como un registro de 4 bits
    logic [3:0] pos_cursor;
    
    // Lógica secuencial (flip-flop) para actualizar la posición con el botón
    always_ff @(posedge boton_cursor) begin
        if (pos_cursor == 4'd15) begin
            pos_cursor <= 4'd0;  // Reinicia la posición si llega a 15
        end else begin
            pos_cursor <= pos_cursor + 4'd1;  // Incrementa la posición
        end
        pos_cursor_contado <= pos_cursor;  // Actualiza la salida
    end
endmodule
