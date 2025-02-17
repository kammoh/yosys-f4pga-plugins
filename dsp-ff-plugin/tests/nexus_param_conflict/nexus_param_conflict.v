// Copyright (C) 2020-2021  The SymbiFlow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier:ISC

module conflict_dsp_ctrl_param (
    input  wire        CLK,
    input  wire [ 8:0] A,
    input  wire [ 8:0] B,
    output reg  [17:0] Z,
);

    wire [17:0] z;
    always @(posedge CLK)
        Z <= z;

    MULT9X9 # (
        .REGINPUTA("BYPASS"),
        .REGINPUTB("BYPASS"),
        .REGOUTPUT("REGISTER")
    ) mult (
        .A (A),
        .B (B),
        .Z (z)
    );

endmodule

module conflict_dsp_common_param (
    input  wire        CLK,
    input  wire        RST,
    input  wire [ 8:0] A,
    input  wire [ 8:0] B,
    output wire [17:0] Z,
);

    wire [8:0] ra;
    always @(posedge CLK or posedge RST)
        if (RST) ra <= 0;
        else     ra <= A;

    wire [8:0] rb;
    always @(posedge CLK)
        if (RST) rb <= 0;
        else     rb <= B;

    MULT9X9 # (
        .REGINPUTA("BYPASS"),
        .REGINPUTB("BYPASS"),
        .REGOUTPUT("BYPASS")
    ) mult (
        .A (ra),
        .B (rb),
        .Z (Z)
    );

endmodule

module conflict_ff_param (
    input  wire        CLK,
    input  wire        RST,
    input  wire [ 8:0] A,
    input  wire [ 8:0] B,
    output wire [17:0] Z,
);

    wire [8:0] ra;
    always @(posedge CLK or posedge RST)
        if (RST) ra[8:4] <= 0;
        else     ra[8:4] <= A[8:4];

    always @(posedge CLK)
        if (RST) ra[3:0] <= 0;
        else     ra[3:0] <= A[3:0];

    MULT9X9 # (
        .REGINPUTA("BYPASS"),
        .REGINPUTB("BYPASS"),
        .REGOUTPUT("BYPASS")
    ) mult (
        .A (ra),
        .B (B),
        .Z (Z)
    );

endmodule

