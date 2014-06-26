part of graphing;

class Graph<NodeType extends Node> {
  List<NodeType> nodes = new List<NodeType>();
  List<List<Edge>> _originEdgeLists = new List<List<Edge>>();
  int nextUnusedIndex = 0;
  List<int> freedIndices = new List<int>();
  
  void addNode(NodeType node) {
    if(freedIndices.isEmpty) {
      node.index = nextUnusedIndex++;
      nodes.add(node);
      _originEdgeLists.add(new List<Edge>());
    } else {
      node.index = freedIndices.removeLast();
      nodes[node.index] = node;
      _originEdgeLists[node.index] = new List<Edge>();  
    }
  }
  
  void removeNode(node) {
    nodes[node.index] = null;
    _originEdgeLists[node.index] = null;
    freedIndices.add(node.index);
  }
  
  int get nodesCount => nodes.length;
  
  void addEdge(Edge edge) {
    _originEdgeLists[edge.originNodeIndex].add(edge);
  }
  
  void removeEdge(Edge edge) {
    _originEdgeLists[edge.originNodeIndex].remove(edge);    
  }
  
  List<Edge> getEdgesByNodeIndex(int nodeIndex) {
    return _originEdgeLists[nodeIndex];
  }
  
  List<Edge> getEdgesByNode(Node node) {
    return getEdgesByNodeIndex(node.index);
  }
}
