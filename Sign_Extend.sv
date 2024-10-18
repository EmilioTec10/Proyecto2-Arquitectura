module Sign_Extend(
    input [33:0] In,      // Entrada de 34 bits (de acuerdo a tu ISA)
    input [1:0] ImmSrc,   // Fuente del inmediato (selecciona cómo extender)
    output [23:0] Imm_Ext // Inmediato extendido (a 24 bits)
);

    // Extensión de signo dependiendo del tipo de inmediato
    assign Imm_Ext =  (ImmSrc == 2'b00) ? {{14{In[9]}}, In[9:0]} :  // Inmediato de 10 bits extendido a 24 bits
                      (ImmSrc == 2'b01) ? {{8{In[15]}}, In[15:0]} : // Inmediato de 16 bits extendido a 24 bits
                      (ImmSrc == 2'b10) ? {{22{In[1]}}, In[1:0]} :  // Inmediato corto (2 bits) extendido a 24 bits
                                           24'h000000;              // Valor por defecto si no coincide ninguna condición

endmodule
