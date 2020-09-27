import java.util.*;

public class Dijkstra {
    private Graph graph;
    public Dijkstra(Graph graph){
        this.graph=graph;
    }

    public void dijkstra(int sourceId, int destinationId){

        PriorityQueue<Node> priorityQueue = new PriorityQueue<>(graph.getNodes().size(), new Comparator<Node>() {
            @Override
            public int compare(Node o1, Node o2) {
                if(o1.getDistance()<o2.getDistance()){
                    return -1;
                }else if(o1.getDistance() == o2.getDistance()){
                    return 0;
                }else{
                    return 1;
                }
            }
        });
        HashSet<Node> nodesWithDistanceKnown = new HashSet<>();

        for(Node node : graph.getNodes()){
            if(node.getId()==sourceId){
                node.setDistance(0);
                priorityQueue.add(node);
                nodesWithDistanceKnown.add(node);
            }else{
                node.setDistance(Integer.MAX_VALUE);
                priorityQueue.add(node);
            }
        }

        while(!(priorityQueue.isEmpty())){
            Node node = priorityQueue.poll();
            nodesWithDistanceKnown.add(node);
            if(node.getId()==destinationId){
                break;
            }
            for (int i=0; i<node.getAdjacentNodes().size();i++){
                Node destinationNode = node.getAdjacentNodes().get(i);
                if(nodesWithDistanceKnown.contains(destinationNode)){
                    continue;
                }else{
                    relax(node,destinationNode,i);
                    priorityQueue.remove(destinationNode);
                    priorityQueue.add(destinationNode);
                }
            }
        }

    }

    private void relax(Node sourceNode, Node destinationNode, int index){
        if(destinationNode.getDistance()> sourceNode.getDistance()+sourceNode.getWeights().get(index)){
            destinationNode.setDistance(sourceNode.getDistance()+sourceNode.getWeights().get(index));
            destinationNode.setParent(sourceNode);

        }
    }

    public static void main(String[] args) {
        Node node1 = new Node(1);
        Node node2 = new Node(2);
        Node node3 = new Node(3);
        Node node4 = new Node(4);
        Node node5 = new Node(5);
        Node node6 = new Node(6);

        ArrayList<Node> node1AdjacentNodes = new ArrayList<>();
        node1AdjacentNodes.add(node2);
        node1AdjacentNodes.add(node4);
        node1AdjacentNodes.add(node5);
        node1.setAdjacentNodes(node1AdjacentNodes);

        ArrayList<Integer> weightsNode1 = new ArrayList<>();
        weightsNode1.add(7);
        weightsNode1.add(3);
        weightsNode1.add(1);
        node1.setWeights(weightsNode1);

        ArrayList<Node> node2AdjacentNodes = new ArrayList<>();
        node2AdjacentNodes.add(node5);
        node2AdjacentNodes.add(node6);
        node2.setAdjacentNodes(node2AdjacentNodes);
        ArrayList<Integer> weightsNode2 = new ArrayList<>();
        weightsNode2.add(1);
        weightsNode2.add(5);
        node2.setWeights(weightsNode2);

        ArrayList<Node> node3AdjacentNodes = new ArrayList<>();
        node3AdjacentNodes.add(node2);
        node3AdjacentNodes.add(node6);
        node3.setAdjacentNodes(node3AdjacentNodes);
        ArrayList<Integer> weightsNode3 = new ArrayList<>();
        weightsNode3.add(4);
        weightsNode3.add(1);
        node3.setWeights(weightsNode3);

        node4.setAdjacentNodes(new ArrayList<Node>());

        ArrayList<Node> node5AdjacentNodes = new ArrayList<>();
        node5AdjacentNodes.add(node2);
        node5AdjacentNodes.add(node6);
        node5.setAdjacentNodes(node5AdjacentNodes);
        ArrayList<Integer> weightsNode5 = new ArrayList<>();
        weightsNode5.add(2);
        weightsNode5.add(108);
        node5.setWeights(weightsNode5);

        ArrayList<Node> node6AdjacentNodes = new ArrayList<>();
        node6AdjacentNodes.add(node6);
        node6.setAdjacentNodes(node6AdjacentNodes);
        ArrayList<Integer> weightsNode6 = new ArrayList<>();
        weightsNode6.add(0);
        node6.setWeights(weightsNode6);

        HashSet<Node> set = new HashSet<>();
        set.add(node1);
        set.add(node2);
        set.add(node3);
        set.add(node4);
        set.add(node5);
        set.add(node6);
        Graph graph = new Graph(set);

        Dijkstra dijkstra = new Dijkstra(graph);
        dijkstra.dijkstra(5,6);

        System.out.println(node6.getDistance());
        System.out.println("---------------");
        Node parent = node6.getParent();
        Stack<Integer> stack = new Stack<>();
        while(parent!=null){
            stack.add(parent.getId());
            parent = parent.getParent();
        }
        while(!(stack.empty())){
            Integer id =stack.pop();
            System.out.println(id);
        }
        System.out.println(node6.getId());


    }


}
