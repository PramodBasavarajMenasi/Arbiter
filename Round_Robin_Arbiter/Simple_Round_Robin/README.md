# Simple Round Robin Arbiter

### Description

The Simple Round Robin Arbiter is a Verilog-based hardware module that manages access to a shared resource for four devices using a round-robin scheduling technique. It ensures fair resource allocation by cycling through the devices in a fixed order.

### Features

- 4-bit request input (req[3:0]) for 4 devices.
- 4-bit grant output (grant[3:0]) that indicates which device has access.
- Round-robin scheduling for fair and sequential resource allocation.
- Synchronous with the clock signal.
  
### How It Works

- The arbiter cycles through the devices on every clock cycle.
- If a device has an active request, it is granted access in turn.
- When no device requests, no grant is issued.

### Code Overview

The Verilog code for the arbiter uses a simple counter that rotates through the four devices. The req[3:0] input determines if a device is requesting access, and the grant[3:0] output indicates the device granted access. The round-robin logic ensures that devices are given turns in a fair and sequential manner.