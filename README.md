## SCARA+ System: Bin Picking System Of Revolution-Symmetry Objects
Jin, G., Yu, X., Chen, Y., Li, J. (2023), SCARA+ System: Bin Picking System Of Revolution-Symmetry Objects, submitted to IEEE Trans. Ind. Electron.

## Overview
Inspired by the fact that the DoF of the revolution-symmetry pose just matches that of an SCARA with an additional revolute joint, this article explores the possibility of adopting the configuration of an SCARA with an additional revolute joint and 3D camera to achieve the bin picking of lightweight revolution-symmetry objects. This configuration  is referred to as the ``SCARA plus system`` in the article. This repository mainly contains the codes for simulations and experiments in the articles.

<img src="pic/visualRepresentation.png" width="75%">

**_Figure_**: Visual representation of the hand-eye calibration of a single marker. (a) The eye-to-base case. (b) The eye-in-hand case.


## Usage
### Setups
MATLAB R2020a without any dependencies.

### Main Instruction
To run the single-marker calibration, call
```
[Rcf,tcf,pcf,Rit,tit,pit,rnticf,rntiit] = Alg(Ri,ti,ppi)
```
where
* ``Ri`` (3x3xn): the rotation matrix of robot pose (n is the measurement number),
* ``ti`` (3xn): the translation vector of robot pose,
* ``ppi`` (3xnxm): the 3D observation of a marker (m is the marker number),

* ``Rcf`` (3x3): the rotation matrix of the hand-eye parameter of closed-form solution,
* ``tcf`` (3x1): the translation vector of the hand-eye parameter of closed-form solution (unit: mm),
* ``pcf`` (3mx1): the marker position of closed-form solution (unit: mm), 
* ``rnticf`` (1x1):  the runtime of closed-form solution (unit: seconds),
* ``Rit`` (3x3): the rotation matrix of the hand-eye parameter of iterative solution,
* ``tit`` (3x1): the translation vector of the hand-eye parameter of iterative solution (unit: mm),
* ``pit`` (3mx1): the marker position of iterative solution (unit: mm), 
* ``rnticf`` (1x1):  the runtime of closed-form solution of iterative solution (unit: seconds).


### Simulations

Demo ``mainSingle`` contains the calibration and evaluation of single-marker methods. run ``mainSingle.m``, and the results for eye-in-hand calibration are as follows
```
Measurement number:30
 
Calibration results of the closed-form solution:
Euler angles(degree):-39.3942,-2.9623,-62.7325
translation (mm):-44.9947,6.2389,57.2844
marker position(mm):6.1064,-482.1404,10.277
RMSE(mm):1.7213
Runtime(s):0.0010371
--------------------------------------------------------------------
 
Calibration results of the iterative solution:
Euler angles(degree):-39.6224,-2.9328,-62.7816
translation (mm):-46.4082,7.5472,57.6744
marker position(mm):6.1807,-482.1297,10.2421
RMSE(mm):1.6757
Runtime(s):0.0014392
--------------------------------------------------------------------
Measurement number:50
 
Calibration results of the closed-form solution:
Euler angles(degree):-39.3794,-3.0738,-62.7562
translation (mm):-44.3712,7.3289,57.5741
marker position(mm):6.6562,-481.7926,9.1926
RMSE(mm):2.0093
Runtime(s):0.0045665
--------------------------------------------------------------------
 
Calibration results of the iterative solution:
Euler angles(degree):-39.6185,-3.049,-62.7731
translation (mm):-45.6604,8.666,57.8175
marker position(mm):6.5507,-481.832,9.0897
RMSE(mm):1.9666
Runtime(s):0.0059281
--------------------------------------------------------------------
Measurement number:70
 
Calibration results of the closed-form solution:
Euler angles(degree):-39.4001,-3.1151,-62.8463
translation (mm):-43.8228,7.8471,58.3511
marker position(mm):6.6675,-481.3842,8.3375
RMSE(mm):1.9946
Runtime(s):0.0008625
--------------------------------------------------------------------
```

### Experiments

Demo ``mainSingle`` contains the calibration and evaluation of single-marker methods. run ``mainSingle.m``, and the results for eye-in-hand calibration are as follows



## Video
Video record for the  calibration and pick-up is on https://www.youtube.com/watch?v=aI9nByyTc4Y
<img src="caliConfig.png" width="75%">


<img src="zhalie.png" width="55%">



**_Figure_**: Experimental configuration.

## Reference
* Sarabandi S, Porta J M, Thomas F. Hand-eye calibration made easy through a closed-form two-stage method[J]. IEEE Robotics and Automation Letters, 2022, 7(2): 3679-3686, https://github.com/MatthewJin001/Hand-Eye-Calibration
* Wu J, Sun Y, Wang M, et al. Hand-eye calibration: 4-D procrustes analysis approach[J]. IEEE Transactions on Instrumentation and Measurement, 2019, 69(6): 2966-2981, https://github.com/MatthewJin001/hand_eye_SO4
* Tabb A, Ahmad Yousef K M. Solving the robot-world hand-eye (s) calibration problem with iterative methods[J]. Machine Vision and Applications, 2017, 28(5-6): 569-590, https://github.com/MatthewJin001/RWHEC-Tabb-AhmadYousef
* Ali I, Suominen O, Gotchev A, et al. Methods for simultaneous robot-world-hand–eye calibration: A comparative study[J]. Sensors, 2019, 19(12): 2837, https://github.com/MatthewJin001/RWHE-Calib


## Contact
Gumin Jin, Department of Automation, Shanghai Jiao Tong University, Shanghai, jingumin@sjtu.edu.cn
