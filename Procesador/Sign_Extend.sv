module Sign_Extend(
    input [33:0] In,      // Entrada de 34 bits
    input [1:0] ImmSrc,   // Fuente del inmediato (selecciona cómo extender)
    output [17:0] Imm_Ext // Inmediato extendido a 18 bits
);

    // Extensión de signo dependiendo del tipo de inmediato
    assign Imm_Ext =  (ImmSrc == 2'b00) ? {{8{In[9]}}, In[9:0]} :  // Inmediato de 10 bits extendido a 18 bits
                      (ImmSrc == 2'b01) ? {{2{In[15]}}, In[15:0]} : // Inmediato de 16 bits extendido a 18 bits
                      (ImmSrc == 2'b10) ? {{16{In[1]}}, In[1:0]} :  // Inmediato corto (2 bits) extendido a 18 bits
                                           18'h00000;               // Valor por defecto si no coincide ninguna condición

endmodule
