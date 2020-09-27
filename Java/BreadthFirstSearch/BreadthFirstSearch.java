import java.util.HashMap;
import java.util.HashSet;

public class BreadthFirstSearch {

    public static int bfs(Node startingNode, Node endingNode){

        int numberNodesReached=0;
        HashMap<Node,Integer> level= new HashMap<>();
        HashMap<Node,Node> parent = new HashMap<>();
        int i=1;
        HashSet<Node> frontier = new HashSet<>();
        frontier.add(startingNode);

        while (!frontier.isEmpty()){
            HashSet<Node> nextLevel= new HashSet<>();
            for(Node node : frontier){

                for(Node adjNode : node.getAdjacentNodes()){

                    if(!(level.containsKey(adjNode))){
                        level.put(adjNode,i);
                        parent.put(adjNode,node);
                        nextLevel.add(adjNode);
                        numberNodesReached++;
                    }
                    if(adjNode==endingNode){
                        return numberNodesReached;
                    }
                }
            }
            frontier=nextLevel;
            i++;
        }
        return numberNodesReached;
    }

    public static int bfsWithMatrix(Integer startingNode, Integer endingNode, GraphWithMatrix graph){

        int numberNodesReached=0;
        HashMap<Integer,Integer> level= new HashMap<>();
        HashMap<Integer,Integer> parent = new HashMap<>();
        level.put(startingNode,0);
        parent.put(startingNode,null);
        int i=1;
        HashSet<Integer> frontier = new HashSet<>();
        frontier.add(startingNode);

        while (!frontier.isEmpty()){
            HashSet<Integer> nextLevel= new HashSet<>();

            for(Integer node : frontier){

                for(Integer x=0; x < graph.getAdjMatrix().length; x++){

                    if(graph.getAdjMatrix()[node][x] >= 1){

                        if(!(level.containsKey(x))){
                            level.put(x,i);
                            parent.put(x,node);
                            nextLevel.add(x);
                            numberNodesReached++;
                        }
                        if(x==endingNode){
                            return numberNodesReached;
                        }
                    }

                }
            }
            frontier=nextLevel;
            i++;
        }
        return numberNodesReached;
    }




}
