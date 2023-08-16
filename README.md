# Design-of-controllers
The codes in this repository demonstrate controllability and PBH test, Full State Feedback (FSFB) controller design, implementation issues associated with FSFB, LQR controller design using MATLAB and SIMULINK.
1. Controllability_of_a_Linear_System code file demonstrates whether a particular (A, B) pair constitute a controllable system or not.
2. PBH_Test code file shows the criteria needed to be satisfied to choose B so that a particular (A, B) pair constitute a controllable system.
3. Full_State_Feedback_Control_Design code file demonstrates how to design a Full state feedback controller that will place the open loop eigen values to any arbitrary closed loop eigen values.
4. Implementation_Issues_with_a_FSFB and Full_state_feeback_control_model
   The code file and Simulink model demonstrate the issue of control saturation and the inability to measure states associated with FSFB controller.
6. LQR_control and LQR_control_simulation
   The code file and Simulink model does a LQR design for a mass/damper system.
