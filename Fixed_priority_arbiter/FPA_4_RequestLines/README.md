# Fixed Priority Arbiter (FPA) with 4 Request Lines

### Overview
This Verilog module manages access to shared resources among 4 request lines (request[3:0]) based on fixed priority:

> request[0] > request[1] > request[2] > request[3].

### Features

- Inputs: clk, rst, request[3:0].
- Outputs: grant[3:0].
- Grants the highest-priority active request.
- Resets all grants on rst.

### Usage
Simulate using the provided testbench to verify functionality.
