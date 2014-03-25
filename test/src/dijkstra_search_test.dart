library dijkstra_search_test;

import 'package:unittest/unittest.dart';
import 'package:graphing/graphing.dart';

main() {
  test("simple search", () {
    var graph = new Graph();
    
    var node1 = new Node();
    var node2 = new Node();
    var node3 = new Node();
    var node4 = new Node();
    var node5 = new Node();
    var node6 = new Node();
    
    graph.addNode(node1);
    graph.addNode(node2);
    graph.addNode(node3);
    graph.addNode(node4);
    graph.addNode(node5);
    graph.addNode(node6);
    
    graph.addEdge(new Edge(node1.index, node5.index, 2.9));
    graph.addEdge(new Edge(node5.index, node2.index, 1.9));
    graph.addEdge(new Edge(node2.index, node3.index, 3.1));
    graph.addEdge(new Edge(node4.index, node3.index, 3.7));
    graph.addEdge(new Edge(node6.index, node4.index, 1.1));
    graph.addEdge(new Edge(node1.index, node6.index, 1));
    graph.addEdge(new Edge(node5.index, node6.index, 3));
    
    var search = new DijkstraSearch(graph, node1, node3);
    expect(search.succeeded, equals(true));
    
    var path = search.result;
    expect(path.length, equals(4));
    expect(path[0], node1);
    expect(path[1], node6);
    expect(path[2], node4);
    expect(path[3], node3);
  });
}
