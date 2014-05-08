part of graphing;

class Graph<NodeType extends Node> {
  List<NodeType> nodes = new List<NodeType>();
  List<List<Edge>> _originEdgeLists = new List<List<Edge>>();
  List<List<Edge>> _destinationEdgeLists = new List<List<Edge>>();
  int nextUnusedIndex = 0;
  List<int> freedIndices = new List<int>();
  
  void addNode(NodeType node) {
    if(freedIndices.isEmpty) {
      node.index = nextUnusedIndex++;
      nodes.add(node);
      _originEdgeLists.add(new List<Edge>());
      _destinationEdgeLists.add(new List<Edge>());
    } else {
      node.index = freedIndices.removeLast();
      nodes[node.index] = node;
      _originEdgeLists[node.index] = new List<Edge>(); 
      _destinationEdgeLists[node.index] = new List<Edge>(); 
    }
  }
  
  void removeNode(node) {
    nodes[node.index] = null;
    for(var edge in _originEdgeLists[node.index]) {
      _destinationEdgeLists[edge.destinationNodeIndex].remove(edge);
    }
    _originEdgeLists[node.index] = null;
    
    for(var edge in _destinationEdgeLists[node.index]) {
      _originEdgeLists[edge.originNodeIndex].remove(edge);
    }
    _destinationEdgeLists[node.index] = null;
    freedIndices.add(node.index);
  }
  
  int get nodesCount => nodes.length;
  
  void addEdge(Edge edge) {
    _originEdgeLists[edge.originNodeIndex].add(edge);
    _destinationEdgeLists[edge.destinationNodeIndex].add(edge);
  }
  
  List<Edge> getEdgesByNodeIndex(int nodeIndex) {
    return _originEdgeLists[nodeIndex];
  }
  
  List<Edge> getEdgesByNode(Node node) {
    return getEdgesByNodeIndex(node.index);
  }
}
