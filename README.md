# windfarm_layout
CEE305 final project on fluid flow in a wind farm. This repository contains all files for execution and analysis of turbine position, wind angle, and rotor radius on power production. 

# MATLAB

windfarm.m: simulate wind farm based on turbine layout, wind direction, rotor radius, and various other input parameters (inflow wind speed, thrust coefficient, wake decay coefficient, rotor radius, capacity factor, conversion efficiency). Produces plot of turbine layout, and tables containing inputs, layout, and outputs (xij, Vij, Rij, dij, Aij, Mijk, Pi). 

wf_analysis.m: plots results from simulated wind farms.

# Excel

WF0.xlsx: control scenario inputs, layout, outputs

change_xdist:

  WF1.xlsx, WF2.xlsx, WF3.xlsx, WF4.xlsx: scenarios for changing downwind distance between turbines inputs, layout, outputs


change_ydist:

  WF5.xlsx, WF6.xlsx, WF7.xlsx, WF8.xlsx: scenarios for changing crosswind distance between turbines inputs, layout, outputs


change_Rr:

  WF9.xlsx, WF10.xlsx, WF11.xlsx, WF12.xlsx: scenarios for changing rotor radius inputs, layout, outputs


change_th:

  WF13.xlsx, WF14.xlsx, WF15.xlsx, WF16.xlsx: scenarios for changing wind angle inputs, layout, outputs
