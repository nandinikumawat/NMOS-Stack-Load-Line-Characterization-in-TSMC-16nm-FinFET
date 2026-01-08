** ===================================================================
** NMOS Stack Load-Line Analysis
** Problem 2: Four input combinations
** ===================================================================
.TITLE NMOS Stack Load-Line Analysis
.TEMP 80
.OPTION POST=2 NOMOD ACCURATE

** ---- Technology Library ----
.lib /soft/ece_soft_2/TSMCHOME/Executable_Package/Collaterals/Tech/SPICE/N16ADFP_SPICE_MODEL/n16adfp_spice_model_v1d0_usage.l TTMacro_MOS_MOSCAP

** ---- Parameters ----
.param VDD=0.8
.param VAval=0.8  VBval=0.8    * Default case 1


** ---- Power Supplies ----
VVDD  vdd  0  'VDD'
VVSS  vss  0   0

** ---- Input Voltage Sources ----
VA    a    0  'VAval'
VB    b    0  'VBval'

** ---- NMOS Stack from your netlist ----
** M0: top device (drain=vdd, gate=a, source=vout)
** M1: bottom device (drain=vout, gate=b, source=vss)
m0 vdd  a vout vss nch_svt_mac l=16e-9 nfin=2 w=58e-9 multi=1 nf=1 sa=90e-9 sb=90e-9
m1 vout b vss  vss nch_svt_mac l=16e-9 nfin=2 w=58e-9 multi=1 nf=1 sa=90e-9 sb=90e-9

** ---- Voltage Clamp for Load-Line Sweep ----
VCLAMP vout 0 0

** ---- DC Sweep: Sweep vout from 0 to VDD ----
.DC VCLAMP 0 'VDD' 2m

** ---- Print Statements ----
** Basic voltages and currents
.PRINT DC V(vout) V(a) V(b) V(vdd)

** Total stack current (through clamp)
.PRINT DC I(VCLAMP)

** Individual device currents
.PRINT DC @m0[id] @m1[id]

** Vds for each device
.PRINT DC PAR('V(vdd)-V(vout)') PAR('V(vout)-V(vss)')

** Vgs for each device
.PRINT DC PAR('V(a)-V(vout)') PAR('V(b)-V(vss)')

** ---- Equilibrium Point Measurements ----
** Find equilibrium where clamp current = 0
.measure dc Vout_eq WHEN I(VCLAMP)=0 CROSS=1
.measure dc Ipd     FIND @m0[id] WHEN I(VCLAMP)=0 CROSS=1
.measure dc Vds_m0  FIND PAR('V(vdd)-V(vout)') WHEN I(VCLAMP)=0 CROSS=1
.measure dc Vds_m1  FIND PAR('V(vout)') WHEN I(VCLAMP)=0 CROSS=1

** ===================================================================
** Case 1: A=VDD, B=VDD (Both transistors ON)
** ===================================================================
.ALTER CASE1_A1_B1
.param VAval='VDD'  VBval='VDD'
.measure dc Vout_eq1 WHEN I(VCLAMP)=0 CROSS=1
.measure dc Ipd1     FIND @m0[id] WHEN I(VCLAMP)=0 CROSS=1

** ===================================================================
** Case 2: A=0, B=VDD (M0 OFF, M1 ON)
** ===================================================================
.ALTER CASE2_A0_B1
.param VAval=0      VBval='VDD'
.measure dc Vout_eq2 WHEN I(VCLAMP)=0 CROSS=1
.measure dc Ipd2     FIND @m0[id] WHEN I(VCLAMP)=0 CROSS=1

** ===================================================================
** Case 3: A=VDD, B=0 (M0 ON, M1 OFF)
** ===================================================================
.ALTER CASE3_A1_B0
.param VAval='VDD'  VBval=0
.measure dc Vout_eq3 WHEN I(VCLAMP)=0 CROSS=1
.measure dc Ipd3     FIND @m0[id] WHEN I(VCLAMP)=0 CROSS=1

** ===================================================================
** Case 4: A=0, B=0 (Both transistors OFF)
** ===================================================================
.ALTER CASE4_A0_B0
.param VAval=0      VBval=0
.measure dc Vout_eq4 WHEN I(VCLAMP)=0 CROSS=1
.measure dc Ipd4     FIND @m0[id] WHEN I(VCLAMP)=0 CROSS=1

.END

	

