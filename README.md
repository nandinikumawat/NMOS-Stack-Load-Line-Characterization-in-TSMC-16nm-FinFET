# NMOS Stack Load-Line Characterization in TSMC 16nm FinFET

**DC I-V analysis and equilibrium point extraction for stacked NMOS configurations**

## Overview

This project analyzes the DC load-line characteristics of a 2-transistor NMOS stack under four input combinations using TSMC 16nm FinFET technology. The work demonstrates fundamental transistor stacking behavior, series resistance effects, and equilibrium voltage determination through HSPICE simulation and load-line intersection analysis.

## Project Scope

- **Technology**: TSMC 16nm FinFET (N16ADFP)
- **Operating Conditions**: VDD = 0.8V, Temperature = 80°C
- **Configuration**: 2-transistor NMOS stack (single-fin devices)
- **Analysis Method**: DC sweep with load-line intersection
- **Tool**: Synopsys HSPICE with TT corner models

## Circuit Description

### NMOS Stack Configuration

The circuit consists of two single-fin NMOS transistors connected in series:
- **M1 (Top)**: Gate = A, Drain = Vout (output node), Source = VDD (intermediate node)
- **M2 (Bottom)**: Gate = B, Drain = VSS, Source = GND

**Key Characteristics:**
- Series connection increases effective resistance
- Intermediate node voltage varies with input combination
- Load-line intersection determines DC equilibrium point

## Methodology

### Simulation Setup

**HSPICE Configuration:**
```spice
.TEMP 80
.OPTION POST ACCURATE NOMOD
.lib n16adfp_spice_model_v1d0_usage.l TTMacro_MOS_MOSCAP

.PARAM VDD=0.8
VDD vdd 0 VDD
VGND gnd 0 0
```

**Device Parameters:**
- Channel length: L = 16nm (minimum)
- Fin count: nfin = 1 (single-fin)
- Transistor type: nch_svt_mac (standard-Vt NMOS)

### Load-Line Analysis Procedure

1. **Input Configuration**: Applied four combinations of inputs A and B (00, 01, 10, 11)
2. **DC Sweep**: Swept output node Vout from 0V to VDD with 5mV steps
3. **Current Measurement**: Recorded drain-source currents I(M1) and I(M2) for each transistor
4. **Equilibrium Extraction**: Identified intersection point where I(M1) = I(M2)
5. **Voltage Analysis**: Extracted equilibrium Vout and intermediate node voltage Vss

### Four Input Cases Analyzed

**Case 1: A=1, B=1 (Both ON)**
- Both transistors in strong inversion
- Maximum pull-down current path
- Lowest output voltage at equilibrium
<p align="center">
  <img width="511" height="373" alt="image" src="https://github.com/user-attachments/assets/73c09059-b25f-4286-8aa5-e666a86808b1" />
</p>
**Case 2: A=0, B=1 (Top OFF, Bottom ON)**
- M1 in cutoff, M2 in triode
- Minimal leakage current
- Output voltage near VDD
<p align="center">
  <img width="516" height="388" alt="image" src="https://github.com/user-attachments/assets/a0e601d9-782a-4700-83bd-2367894cbe7f" />
</p>
**Case 3: A=1, B=0 (Top ON, Bottom OFF)**
- M1 in triode, M2 in cutoff
- Intermediate node charges to high voltage
- Reduced pull-down strength
<p align="center">
  <img width="577" height="429" alt="image" src="https://github.com/user-attachments/assets/ba2f7a6a-8499-4e14-9225-8563daa22478" />
</p>
**Case 4: A=0, B=0 (Both OFF)**
- Both transistors in cutoff
- Subthreshold leakage only
- Output voltage dependent on leakage balance
<p align="center">
  <img width="577" height="429" alt="image" src="https://github.com/user-attachments/assets/ba2f7a6a-8499-4e14-9225-8563daa22478" />
</p>
## Results

### Load-Line Characteristics

**Case 1: A=VDD, B=VDD (Both Transistors ON)**
- Pull-down current: 3.0 × 10⁻⁵ A (30 µA)
- Stack node voltage (Vnx): 0.062 V
- Both NMOS transistors in strong inversion form complete conduction path to ground
- High current indicates active pull-down network with strong series current flow
- Small Vnx voltage drop results from voltage division across two ON devices in series
<p align="center">
  <img width="348" height="375" alt="image" src="https://github.com/user-attachments/assets/8ff9fac8-382a-43ea-8dca-ac471c798aea" />
</p>
**Case 2: A=0, B=VDD (Bottom OFF, Top ON)**
- Pull-down current: 3.7 × 10⁻¹⁰ A (0.37 nA - leakage only)
- Stack node voltage (Vnx): 0.756 V
- Top NMOS (B-controlled) is ON but bottom NMOS (A-controlled) is OFF
- Minimal leakage current flows through OFF bottom device
- High Vnx (near VDD) occurs because floating intermediate node charges up through upper transistor
<p align="center">
  <img width="323" height="348" alt="image" src="https://github.com/user-attachments/assets/3ad943c9-677c-452f-b098-d4559e82c3e4" />
</p>
**Case 3: A=VDD, B=0 (Bottom ON, Top OFF)**
- Pull-down current: 3.5 × 10⁻¹⁰ A (0.35 nA - leakage only)
- Stack node voltage (Vnx): 0 V
- Top transistor is ON but bottom transistor OFF isolates stack from ground
- OFF device at bottom prevents conduction path → near-zero current
- Vnx clamped to ground potential due to lack of discharge path
<p align="center">
  <img width="356" height="357" alt="image" src="https://github.com/user-attachments/assets/e81bd89c-8633-4469-9d14-5f9c4ed4540a" />
</p>
**Case 4: A=0, B=0 (Both Transistors OFF)**
- Pull-down current: 1.3 × 10⁻¹⁰ A (0.13 nA - subthreshold leakage)
- Stack node voltage (Vnx): 0.038 V
- Both transistors in cutoff with only subthreshold leakage current
- Entire stack remains non-conducting with output staying high
- Vnx rises slightly above ground due to capacitive coupling and charge redistribution
<p align="center">
  <img width="314" height="327" alt="image" src="https://github.com/user-attachments/assets/2113c604-e324-4941-8679-2b1e62dc6d40" />
</p>
## Technical Analysis

### Series Stack Effects

**Voltage Division:**
- In Case 1, voltage drop distributed across both transistors in series
- Intermediate node Vnx = 0.062V shows asymmetric voltage division (8% across bottom, 92% across top)
- Series resistance = R_M1 + R_M2 increases total path resistance, limiting current to 30µA

**Current Matching:**
- At equilibrium, I_M1 = I_M2 (Kirchhoff's current law)
- Load-line intersection graphically represents this current balance
- Case 1 shows matched 30µA through both devices at Vnx = 0.062V

**Stacking Penalty:**
- Single transistor would achieve higher current (~40-50µA) compared to stacked configuration
- Case 1 shows pull-down current = 30µA (stack) vs ~40-50µA for single transistor
- Demonstrates fundamental tradeoff: stack reduces leakage (Cases 2-4 show nA-level) but degrades ON-current by ~30-40%
- Additional series resistance increases RC delay for switching applications

### FinFET Characteristics

**Single-Fin Behavior:**
- Limited drive current (~100µA) compared to multi-fin devices
- Steeper subthreshold slope improves off-state leakage
- Gate control over channel more effective in FinFET structure

**Temperature Effects at 80°C:**
- Reduced carrier mobility increases on-resistance
- Elevated subthreshold current in Cases 3 and 4
- Worst-case conditions for SRAM operation

## Key Design Insights

### Stack Configuration Trade-offs

**Advantages:**
- Reduced subthreshold leakage when both transistors OFF
- Better noise immunity through distributed voltage drops
- Useful for low-power logic gates (NAND, NOR)

**Disadvantages:**
- Increased series resistance degrades pull-down strength
- Higher intermediate node voltage in partial-ON states
- Larger delay compared to single-transistor path

### Application to SRAM Design

This load-line analysis directly applies to SRAM cell design:
- **Pull-down path**: Access transistor + NMOS driver form 2-stack
- **Read stability**: Stack resistance limits discharge during read
- **Write margin**: Stack affects cell flip threshold voltage
- **Leakage**: Stacked configuration in unselected cells reduces leakage

## Simulation Files

### HSPICE Netlist Structure
```spice
* NMOS Stack Load-Line Analysis
.TITLE NMOS_Stack_Characterization

* Include technology files
.lib 'n16adfp_spice_model_v1d0_usage.l' TTMacro_MOS_MOSCAP

* Circuit definition
M1 vout va vss gnd nch_svt_mac nfin=1 L=16e-9
M2 vss  vb gnd gnd nch_svt_mac nfin=1 L=16e-9

* Voltage sources
VDD vdd 0 0.8
VA  va  0 [INPUT_A]
VB  vb  0 [INPUT_B]

* DC sweep for load-line
.DC V(vout) 0 0.8 0.005

* Measurements
.MEASURE DC I_M1 = par('i(M1)')
.MEASURE DC I_M2 = par('i(M2)')
.MEASURE DC Vss_node = v(vss)

.END
```

### Python Post-Processing

Equilibrium point extraction performed using numerical intersection finding:
```python
import numpy as np
import matplotlib.pyplot as plt

# Load HSPICE output data
vout = data['vout']
i_m1 = data['i_m1']
i_m2 = data['i_m2']

# Find intersection (equilibrium)
diff = np.abs(i_m1 - i_m2)
eq_idx = np.argmin(diff)
eq_vout = vout[eq_idx]
eq_current = (i_m1[eq_idx] + i_m2[eq_idx]) / 2

print(f"Equilibrium Vout: {eq_vout:.4f} V")
print(f"Equilibrium Current: {eq_current*1e6:.2f} µA")
```

## Project Structure

```
nmos-stack-loadline/
├── spice/
│   ├── nmos_stack_case1.sp        # A=1, B=1 simulation
│   ├── nmos_stack_case2.sp        # A=0, B=1 simulation
│   ├── nmos_stack_case3.sp        # A=1, B=0 simulation
│   └── nmos_stack_case4.sp        # A=0, B=0 simulation
├── analysis/
│   ├── loadline_analysis.py       # Python equilibrium extraction
│   └── plot_curves.py             # Load-line visualization
├── results/
│   ├── case1_loadline.png         # Load-line plots
│   ├── case2_loadline.png
│   ├── case3_loadline.png
│   └── case4_loadline.png
└── docs/
    ├── assignment4_report.pdf     # Detailed analysis report
    └── images/                    # Additional figures
```



## References

- TSMC 16nm FinFET Technology Documentation
- Seevinck, E., et al. "Static-Noise Margin Analysis of MOS SRAM Cells" *IEEE JSSC*, 1987
- Rabaey, J., Chandrakasan, A., & Nikolić, B. (2003). *Digital Integrated Circuits*
- Roy, K., & Prasad, S. (2000). *Low-Power CMOS VLSI Circuit Design*

## Course Context

**Course**: EE 8310 - Advanced Topics in VLSI  
**Assignment**: Assignment 4 - SRAM Noise Margin & Load Line Plots  
**Institution**: University of Minnesota  
**Instructor**: Prof. Chris Kim  
**Semester**: Fall 2025

## License

Educational project - University of Minnesota

---

**Author**: Nandini Kumawat  
**Date**: October 2025  
**Contact**: kumaw010@umn.edu
