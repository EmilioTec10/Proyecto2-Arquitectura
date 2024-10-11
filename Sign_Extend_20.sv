module Sign_Extend_20 (
    input [19:0] In,      // Entrada de 20 bits (de acuerdo a tu ISA)
    input [1:0] ImmSrc,   // Fuente del inmediato (selecciona cómo extender)
    output [19:0] Imm_Ext // Inmediato extendido (a 20 bits)
);

    // Extensión de signo dependiendo del tipo de inmediato
    assign Imm_Ext =  (ImmSrc == 2'b00) ? {{11{In[9]}}, In[9:0]} :  // Inmediato de 10 bits
                      (ImmSrc == 2'b01) ? {{10{In[9]}}, In[9:0]} :  // Inmediato de 10 bits con diferente extensión
                      (ImmSrc == 2'b10) ? {{11{In[1]}}, In[1:0]} :  // Inmediato corto (2 bits)
                                           20'h00000;                // Valor por defecto si no coincide ninguna condición

endmodule
