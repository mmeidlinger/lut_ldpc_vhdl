Here we put we specify the structure of the decision trees. The convention will be
<Type of Node>_<node-degree>_ID, where the ID for the brute based nodes should 
be 0.

<Type of Node> \in {VNode,CNode,VNdec}

EXAMPLE
For a (6-32) code we would store the brute tree for the Variable node as VNode_06_00, some other arbitrary tree structure for the same setting would be, for example, VNode_06_03. For the same code, the decision node could be stored as VNdec_06_02, i.e. the IDs of the decision node and the other nodes do not have to match.