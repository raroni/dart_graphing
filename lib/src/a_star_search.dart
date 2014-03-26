part of graphing;

class AStarSearch<NodeType extends Node> {
  Graph graph;
  Node sourceNode;
  Node targetNode;
  bool succeeded = false;
  
  List<Edge> spt;
  List<Edge> frontiers;
  List<double> realCosts;
  List<double> combinedCosts;
  
  AStarHeuristic heuristic;
  
  AStarSearch(Graph<NodeType> this.graph, AStarHeuristic this.heuristic, NodeType this.sourceNode, NodeType this.targetNode) {
    spt = new List<Edge>(this.graph.nodesCount);
    frontiers = new List<Edge>(this.graph.nodesCount);
    realCosts = new List<double>.filled(this.graph.nodesCount, 0.0);
    combinedCosts = new List<double>.filled(this.graph.nodesCount, 0.0);
        
    succeeded = execute();
  }
  
  bool execute() {
    var queue = new HeapPriorityQueue<int>(nodeIndexCompare);
    queue.add(sourceNode.index);
    
    while(queue.isNotEmpty) {
      var currentNodeIndex = queue.removeFirst();
      spt[currentNodeIndex] = frontiers[currentNodeIndex];
      
      if(currentNodeIndex == targetNode.index) {
        return true;
      }
      
      for(var edge in graph.getEdgesByNodeIndex(currentNodeIndex)) {
        var destinationNodeIndex = edge.destinationNodeIndex;
        num realCost = realCosts[currentNodeIndex] + edge.cost;
        num estimatedCost = heuristic.calculate(graph.nodes[currentNodeIndex], graph.nodes[destinationNodeIndex]);
        
        if(frontiers[destinationNodeIndex] == null) {
          updateNodeData(edge, realCost, estimatedCost);
          queue.add(destinationNodeIndex);
        }
        else if(spt[destinationNodeIndex] == null && realCost < realCosts[destinationNodeIndex]) {
          updateNodeData(edge, realCost, estimatedCost);
          queue.remove(destinationNodeIndex);
          queue.add(destinationNodeIndex);
        }
      }
    }
    
    return false;
  }
  
  void updateNodeData(Edge edge, num realCost, num estimatedCost) {
    var nodeIndex = edge.destinationNodeIndex;
    realCosts[nodeIndex]= realCost;
    combinedCosts[nodeIndex] = estimatedCost + realCost;
    frontiers[nodeIndex] = edge;
  }
  
  List<NodeType> get result {
    if(!succeeded) throw new StateError("Cannot path because search did not succeed.");
    var list = new List<NodeType>();
    var currentNode = targetNode;
    while(currentNode != sourceNode) {
      list.add(currentNode);
      currentNode = graph.nodes[spt[currentNode.index].originNodeIndex];
    }
    list.add(sourceNode);
    return new List.from(list.reversed);
  }
  
  int nodeIndexCompare(int nodeIndex1, int nodeIndex2) {
    return combinedCosts[nodeIndex1] < combinedCosts[nodeIndex2] ? -1 : 1;    
  }
}
