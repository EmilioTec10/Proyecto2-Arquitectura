module Ram (
    address,
    clock,
    data,
    wren,
    byteena, // Nueva entrada para habilitar bytes específicos
    q
);

input   [17:0]  address;
input           clock;
input   [23:0]  data;
input           wren;
input   [2:0]   byteena; // Señal de byte enable para 3 bloques de 8 bits
output  [23:0]  q;

`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
    tri1   clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

wire [23:0] sub_wire0;
wire [23:0] q = sub_wire0[23:0];

altsyncram  altsyncram_component (
    .address_a (address),
    .clock0 (clock),
    .data_a (data),
    .wren_a (wren),
    .byteena_a (byteena), // Conectar la señal de byte enable
    .q_a (sub_wire0),
    .aclr0 (1'b0),
    .aclr1 (1'b0),
    .address_b (1'b1),
    .addressstall_a (1'b0),
    .addressstall_b (1'b0),
    .clock1 (1'b1),
    .data_b (1'b1),
    .eccstatus (),
    .q_b (),
    .rden_a (1'b1),
    .rden_b (1'b1),
    .wren_b (1'b0)
);
defparam
    altsyncram_component.init_file = "ram.mif",
    altsyncram_component.intended_device_family = "Cyclone V",
    altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
    altsyncram_component.lpm_type = "altsyncram",
    altsyncram_component.numwords_a = 200008,
    altsyncram_component.operation_mode = "SINGLE_PORT",
    altsyncram_component.outdata_aclr_a = "NONE",
    altsyncram_component.outdata_reg_a = "UNREGISTERED",
    altsyncram_component.power_up_uninitialized = "FALSE",
    altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
    altsyncram_component.widthad_a = 18,
    altsyncram_component.width_a = 24,
    altsyncram_component.width_byteena_a = 3; // Configurar para 3 bloques de 8 bits

endmodule
