part of graphing;

class Edge {
  final int originNodeIndex;
  final int destinationNodeIndex;
  num cost;
  
  Edge(int this.originNodeIndex, int this.destinationNodeIndex, num this.cost);
}
