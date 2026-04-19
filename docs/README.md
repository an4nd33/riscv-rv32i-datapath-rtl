# 📘 RV32I RTL-to-GDS Flow

## 📌 Overview
This repository implements a **RISC-V RV32I processor** and demonstrates a complete **RTL-to-GDSII ASIC design flow**, covering front-end design, verification, synthesis, and physical design.

The project focuses on building a synthesizable RV32I core and taking it through industry-standard VLSI stages including:
- RTL Design (Verilog/SystemVerilog)
- Functional Verification (Testbench / UVM)
- Logic Synthesis
- Power Intent Integration (UPF)
- Physical Design (PnR)
- Power & Timing Analysis

---

## 🎯 Objectives
- Design a modular **RV32I processor**
- Verify functionality using SystemVerilog/UVM
- Implement low-power techniques (UPF / multi-voltage domains)
- Generate gate-level netlist and final GDSII
- Perform timing, power, and physical verification

---

## 🧱 Design Architecture
The processor consists of the following key blocks:

- Program Counter (PC)
- Instruction Memory
- Register File
- ALU (Arithmetic Logic Unit)
- Control Unit
- Data Memory
- Datapath / Pipeline logic (if applicable)

---

---

## ⚙️ Tools & Technologies

### Design & Simulation
- Verilog / SystemVerilog  
- VCS / Icarus Verilog / Questa  
- GTKWave  

### Synthesis
- Synopsys Design Compiler / Yosys  

### Physical Design
- ICC2 / OpenLane  
- Magic  

### Verification
- UVM  

### Power Analysis
- UPF  
- PrimeTime PX / OpenROAD  

---


