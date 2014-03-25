part of graphing;

class Edge {
  final int originNodeIndex;
  final int destinationNodeIndex;
  final num cost;
  
  const Edge(int this.originNodeIndex, int this.destinationNodeIndex, num this.cost);
}
