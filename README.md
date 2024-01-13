# column-and-constraint-generation-method
This repo contains the implementation of the code for paper: [Solving two-stage robust optimization problems using a column-and-constraint generation method](https://www.sciencedirect.com/science/article/abs/pii/S0167637713000618) from Bo Zeng. You will get the same results as shown in the paper (toy example). 

We applied this method to consider multiple uncertainty sources (i.e., demand and node failures) in the edge service placement and resource allocation problem in [Resilient Edge Service Placement under Demand and Node Failure Uncertainties](https://ieeexplore.ieee.org/abstract/document/10167783?casa_token=_vuz5dB52fQAAAAA:UIhkQsUAfWGxBFcX2zOnfwhgUbIXk1ZVncskwtH5hjPtYkNcc_qcBr1UD4Wv6SrVert4Thr6):

## Get started
### Prerequisites
- CVX: Matlab Software for Disciplined Convex Programming: [CXV](http://cvxr.com/cvx/)
- Gurobi solver (Free license for academic students): [Gurobi solver](https://www.gurobi.com/academia/academic-program-and-licenses/)
- Mosek solver (Free license for academic students):  [Mosek solver](https://www.mosek.com/)
### File
- transportation.m (Main file): This file contains all parameter setting and flow of CCG algorithm. You will get the same results as shown in the paper (toy example).
- D_max.m: create a temporal extreme points by maximizing the total demand. The resulting **d** must be within the feasible region of uncertainty set.
- MP0.m: At iteration 1, we will input the d_opt from D_max.m. (For first iteration only)
- MP2.m: Master problem that provides the lower bound to the robust solution based on the newly updated optimality cut (after iteration 1)
- SP.m: Subproblem (use KKT conditions)

  
### Results
Please refer to convergence analysis in the following figure:
[Convergence analysis](Convergence.jpg)


## Citation and Acknowledgements
**Bibtex.**
If you find our code useful for your research, you can refer to our paper that considers multiple uncertainties in the problem [paper](https://ieeexplore.ieee.org/abstract/document/10167783?casa_token=_vuz5dB52fQAAAAA:UIhkQsUAfWGxBFcX2zOnfwhgUbIXk1ZVncskwtH5hjPtYkNcc_qcBr1UD4Wv6SrVert4Thr6):
```bibtex
@article{cheng2023resilient,
  title={Resilient edge service placement under demand and node failure uncertainties},
  author={Cheng, Jiaming and Nguyen, Duong Tung and Bhargava, Vijay K},
  journal={IEEE Transactions on Network and Service Management},
  year={2023},
  publisher={IEEE}
}
```

## Contact
Please submit a GitHub issue or contact [jiaming@ece.ubc.ca](mailto:jiaming@ece.ubc.ca) if you have any questions or find any bugs.
