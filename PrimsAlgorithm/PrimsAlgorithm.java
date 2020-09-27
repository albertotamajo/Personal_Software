import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.PriorityQueue;

public class PrimsAlgorithm {

    public static HashMap<Integer,Integer> primsMSt(GraphWithMatrix graph){

        HashMap<Integer, Integer> parent = new HashMap<>();
        HashMap<Integer,Integer> distanceFromCut = new HashMap<>();

        PriorityQueue<Integer> queue = new PriorityQueue<>(graph.getAdjMatrix().length, new Comparator<Integer>() {
            @Override
            public int compare(Integer o1, Integer o2) {
                if(distanceFromCut.get(o1) < distanceFromCut.get(o2)){
                    return -1;
                }
                else if(distanceFromCut.get(o1) == distanceFromCut.get(o2)){
                    return 0;
                }else{
                    return 1;
                }
            }
        });

        distanceFromCut.put(0,0);
        queue.add(0);
        parent.put(0,null);
        for(int i=1; i<graph.getAdjMatrix().length; i++){

            distanceFromCut.put(i,Integer.MAX_VALUE);
            queue.add(i);
        }

        while(!(queue.isEmpty())){
            int currentNode=queue.poll();

            for(int i=0; i<graph.getAdjMatrix().length; i++){
                if((queue.contains(i)) && (graph.getAdjMatrix()[currentNode][i]!=0) &&(graph.getAdjMatrix()[currentNode][i]<distanceFromCut.get(i))){
                    distanceFromCut.put(i,graph.getAdjMatrix()[currentNode][i]);
                    parent.put(i,currentNode);
                    queue.remove(i);
                    queue.add(i);
                }
            }
        }
        return parent;

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

        HashMap<Integer,Integer> nodes = PrimsAlgorithm.primsMSt(graph);
        for(Integer key : nodes.keySet()){
            System.out.println(key + " -> " + nodes.get(key));
        }

    }
}
