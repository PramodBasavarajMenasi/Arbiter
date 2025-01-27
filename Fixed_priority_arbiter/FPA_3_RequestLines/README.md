# Fixed Priority Arbiter (FPA) with 3 Request Lines

### Overview

This Verilog module manages access to shared resources among 3 request lines (request[2:0]) based on fixed priority:

> request[0] > request[1] > request[2].

### Features

- Inputs: clk, rst, request[2:0].
- Outputs: grant[2:0].
- Grants highest-priority active request.
- Resets grants on rst.

### Usage

Simulate using the provided testbench to verify priority-based grant issuance
