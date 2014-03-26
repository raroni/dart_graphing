part of graphing;

class DijkstraSearch<NodeType extends Node> {
  Graph graph;
  Node sourceNode;
  Node targetNode;
  bool succeeded = false;
  
  List<Edge> spt;
  List<Edge> frontiers;
  List<double> costs;  
  
  DijkstraSearch(Graph<NodeType> this.graph, NodeType this.sourceNode, NodeType this.targetNode) {
    spt = new List<Edge>(this.graph.nodesCount);
    frontiers = new List<Edge>(this.graph.nodesCount);
    costs = new List<double>.filled(this.graph.nodesCount, 0.0);
        
    succeeded = execute();
  }
  
  bool execute() {
    var queue = new HeapPriorityQueue<int>(nodeIndexCompare);
    costs[sourceNode.index] = 0.0;
    queue.add(sourceNode.index);
    
    while(queue.isNotEmpty) {
      var currentNodeIndex = queue.removeFirst();
      spt[currentNodeIndex] = frontiers[currentNodeIndex];
      
      if(currentNodeIndex == targetNode.index) {
        return true;
      }
      
      for(var edge in graph.getEdgesByNodeIndex(currentNodeIndex)) {
        num totalCost = costs[currentNodeIndex] + edge.cost;
        
        if(frontiers[edge.destinationNodeIndex] == null) {
          costs[edge.destinationNodeIndex] = totalCost;
          queue.add(edge.destinationNodeIndex);
          frontiers[edge.destinationNodeIndex] = edge;
        }
        else if(spt[edge.destinationNodeIndex] == null && totalCost < costs[edge.destinationNodeIndex]) {
          costs[edge.destinationNodeIndex] = totalCost;
          queue.remove(edge.destinationNodeIndex);
          queue.add(edge.destinationNodeIndex);
          frontiers[edge.destinationNodeIndex] = edge;
        }
      }
    }
    
    return false;
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
    return costs[nodeIndex1] < costs[nodeIndex2] ? -1 : 1;    
  }
}
