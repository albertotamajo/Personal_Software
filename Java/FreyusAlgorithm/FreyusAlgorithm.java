import java.util.ArrayList;

public class FreyusAlgorithm {

    //Only euleur paths where all nodes have even degree
    public static ArrayList<Integer> freyusAlgo(GraphWithMatrix graph){

        ArrayList<Integer> euleurPath = new ArrayList<>();
        int node=0;
        euleurPath.add(0);
        while (!(graph.ifRowAllZeros(node))){

            for(int i=0; i<graph.getAdjMatrix().length; i++){

                if(graph.getAdjMatrix()[node][i]!=0){

                    graph.decreaseAdjacencyValue(node,i,1);

                    if((BreadthFirstSearch.bfsWithMatrix(i,null,graph)==graph.getNumberNodes()-1 && graph.getNumberNodes()>0) || (graph.getNumberNodes()==0 && BreadthFirstSearch.bfsWithMatrix(i,null,graph)==0)){
                        euleurPath.add(i);
                        node=i;
                        break;
                    }else{
                        graph.increaseAdjacencyValue(node,1,1);
                    }
                }
            }
        }
        return euleurPath;

    }

    public static void main(String[] args) {
        GraphWithMatrix graph = new GraphWithMatrix(5);
//        graph.setAdjValue(0,0,0);
//        graph.setAdjValue(0,1,1);
//        graph.setAdjValue(0,2,1);
//        graph.setAdjValue(1,1,0);
//        graph.setAdjValue(1,2,1);
//        graph.setAdjValue(2,3,1);
//        graph.setAdjValue(2,2,0);
//        graph.setAdjValue(2,4,1);
//        graph.setAdjValue(3,4,1);
//        graph.setAdjValue(3,3,0);
//        graph.setAdjValue(4,4,0);
        graph.setAdjValue(0,1,1);
        graph.setAdjValue(0,2,1);
        graph.setAdjValue(0,3,1);
        graph.setAdjValue(0,4,1);
        graph.setAdjValue(1,2,1);
        graph.setAdjValue(3,4,1
        );
        ArrayList<Integer> euleurPath = FreyusAlgorithm.freyusAlgo(graph);
        for(int i : euleurPath){
            System.out.println(i);
        }

    }



}
