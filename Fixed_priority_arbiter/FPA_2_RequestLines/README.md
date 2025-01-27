## Fixed Priority Arbiter (FPA) with 2 Request Lines

### Overview

The Fixed Priority Arbiter (FPA) manages access to shared resources for two request lines (request[1:0]). The arbiter grants access based on a fixed priority where request[0] has higher priority than request[1].

### Features

--> Inputs: clk, rst, request[1:0]

--> Outputs: grant[1:0]

--> Priority: request[0] > request[1]

--> Reset Support: Clears grants when rst is active.


### Usage

-> Simulate using the provided testbench (tb_fixed_priority_arbiter_2).

-> The arbiter grants access to the highest-priority active request.