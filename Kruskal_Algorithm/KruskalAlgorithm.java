import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.PriorityQueue;

public class KruskalAlgorithm {


    public static HashSet<Edge> kruskalMST(GraphWithMatrix graph){


        WeigtedQuickUnion weigtedQuickUnion = new WeigtedQuickUnion(graph.getAdjMatrix().length);
        HashSet<Edge> edges = new HashSet<>();
        PriorityQueue<Edge> queue = new PriorityQueue<>(graph.getAdjMatrix().length, new Comparator<Edge>() {
            @Override
            public int compare(Edge o1, Edge o2) {
                if(o1.weight<o2.weight){
                    return -1;
                }else if(o1.weight==o2.weight){
                    return 0;
                }else{
                    return 1;
                }
            }
        });
        for(int i=0; i<graph.getAdjMatrix().length; i++){
            for(int j=i; j<graph.getAdjMatrix().length; j++){
                if(graph.getAdjMatrix()[i][j]==0){
                    continue;
                }
                Edge edge = new Edge(i,j,graph.getAdjMatrix()[i][j]);
                queue.add(edge);
            }
        }

        while(!(queue.isEmpty())){
            Edge edge = queue.poll();
            if(!(weigtedQuickUnion.connected(edge.node1,edge.node2))){
                edges.add(edge);
                weigtedQuickUnion.union(edge.node1,edge.node2);
            }
        }

        return edges;

    }

    public static void main(String[] args) {
        GraphWithMatrix graph = new GraphWithMatrix(5);

        graph.setAdjValue(0,4,8);
        graph.setAdjValue(0,3,7);
        graph.setAdjValue(0,1,3);
        graph.setAdjValue(4,3,3);
        graph.setAdjValue(4,3,3);
        graph.setAdjValue(3,1,4);
        graph.setAdjValue(3,2,2);
        graph.setAdjValue(1,2,1);

        HashSet<Edge> edges = KruskalAlgorithm.kruskalMST(graph);
        for(Edge edge : edges){
            System.out.println(edge.node1 + " -> " + edge.node2);
        }
    }
}
