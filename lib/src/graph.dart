part of graphing;

class Graph<NodeType extends Node> {
  List<NodeType> nodes = new List<NodeType>();
  List<List<Edge>> _edgeLists = new List<List<Edge>>();
  int nextUnusedIndex = 0;
  
  void addNode(NodeType node) {
    node.index = nextUnusedIndex++;
    nodes.add(node);
    _edgeLists.add(new List<Edge>());
  }
  
  num get nodesCount => nodes.length;
  
  void addEdge(Edge edge) {
    _edgeLists[edge.originNodeIndex].add(edge);
  }
  
  void removeEdge(Edge edge) {
    _edgeLists[edge.originNodeIndex].remove(edge);
  }
  
  List<Edge> getEdgesByNodeIndex(int nodeIndex) {
    return _edgeLists[nodeIndex];
  }
  
  List<Edge> getEdgesByNode(Node node) {
    return getEdgesByNodeIndex(node.index);
  }
}
