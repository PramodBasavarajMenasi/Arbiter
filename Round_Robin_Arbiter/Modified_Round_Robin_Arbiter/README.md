
# Modified Round Robin Arbiter

### Description

The Modified Round Robin Arbiter is a Verilog-based hardware module that ensures fair resource allocation among multiple devices using a modified round-robin scheduling technique. Unlike the standard round-robin, this version prioritizes devices with active requests, ensuring that a device that has been skipped doesn't starve while maintaining fairness.

### Features

- 4-bit request input (req[3:0]) for 4 devices.
- 4-bit grant output (grant[3:0]) indicating the device granted access.
- Modified round-robin scheduling: prioritizes active requests.
- Synchronous with the clock signal.

### How It Works

- The arbiter uses a ring counter that cycles through the devices.
- If a device has an active request, it is granted access while the counter continues in a round-robin fashion.
- Devices with no request are skipped until they have an active request, ensuring fair access for all devices.

### Code Overview

The Verilog code utilizes a ring counter for the modified round-robin scheduling. The req[3:0] input indicates the request status of the devices. The grant[3:0] output shows which device has been granted access. The counter ensures that the arbiter will prioritize devices with ongoing requests while still maintaining fairness. If no request is active from a device, it is skipped in the round-robin cycle.

### Usage

- Suitable for systems where devices need fair but prioritized access to a shared resource.
