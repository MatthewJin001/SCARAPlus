## SCARA+ System: Bin Picking System Of Revolution-Symmetry Objects
Jin, G., Yu, X., Chen, Y., Li, J. (2023), SCARA+ System: Bin Picking System Of Revolution-Symmetry Objects, IEEE Trans. Ind. Electron.

## Overview
Inspired by the fact that the DoF (degree of freedom) of the RS (revolution-symmetry) pose is exactly the same as adding one DoF to SCARA, we develop a SCARA+ configuration of a SCARA with an additional revolute joint, and explore the possibility of integrating it with a 3D camera to achieve the bin picking of RS objects. To this end, we first discuss the SCARA+ kinematics with the modified DH (Denavit-Hartenberg) parameters. Then, to calibrate the additional DH and the hand-eye parameters in the kinematics, we construct an axis-point model and provide an iterative solution without singularity. Finally, comprehensive experiments verify the superiority of the SCARA+ system. When compared to the state-of-the-art systems, our system achieves a significant efficiency improvement with relatively lower costs. It has also been successfully applied in the spinning industry for practical bobbin loading. This repository mainly contains the codes for simulations and experiments in the article.

<img src="pic/configuration.png" width="70%">

**_Figure_**: Configuration of SCARA+ system.


## Usage
### Setups
MATLAB R2020a without any dependencies.

### Main Instruction
To run the DH+ and hand-eye calibration, call
```
[R,tw,pw,thetap,rnti,k_num] = Alg(Ri,ti,ppi)
```
where
* ``Ri`` (3x3xn): the rotation matrix of SCARA pose (n is the measurement number),
* ``ti`` (3xn): the translation vector of SCARA pose,
* ``ppi`` (3xn): the detected position of the axis point,

* ``R`` (3x3): the rotation matrix of the hand-eye transformation,
* ``tw`` (3x1): the generalized translation vector of the hand-eye transforamtion (unit: mm),
* ``pw`` (2x1): the first two dimensional positions of the axis point (unit: mm), 
* ``thetap`` (1x1):  the joint angle of DH+ parameters (unit: degree),
* ``rnti`` (3x3): the runtime (unit: seconds).
* ``k_num`` (3x1): the iterative number.


### Simulations

* File ``simu1`` is the forward Kinematics simulation;
* File ``simu2`` is the inverse Kinematics simulation;
* File ``simu3`` is the calibration simulations for singular and non-singular models;
* File ``simu4`` is the calibration simulations for different measurement numbers and different noises;

### Experiments

* File ``exp1`` is the calibration experiment;
* File ``caliData`` is the raw data of the calibration experiment.

## Video
Video record for the  calibration and pick-up is on http://youtu.be/aI9nByyTc4Y.

<img src="pic/calibration.png" width="62%">

**_Figure_**: The calibration configuration.


<img src="pic/pick-up.png" width="60%">

**_Figure_**: Snaps of three trials for bobbin picking using SCARA+ system.

## Contact
Gumin Jin, Department of Automation, Shanghai Jiao Tong University, Shanghai, jingumin@sjtu.edu.cn
