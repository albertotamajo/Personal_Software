import java.util.ArrayList;

public class Node {

    private ArrayList<Node> adjacentNodes;
    private ArrayList<Integer> weights;
    private int distance;
    private Node parent;
    private int id;

    public Node(int id){
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public ArrayList<Node> getAdjacentNodes() {
        return adjacentNodes;
    }

    public ArrayList<Integer> getWeights() {
        return weights;
    }

    public void setAdjacentNodes(ArrayList<Node> adjacentNodes) {
        this.adjacentNodes = adjacentNodes;
    }

    public void setWeights(ArrayList<Integer> weights) {
        this.weights = weights;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public int getDistance() {
        return distance;
    }

    public Node getParent() {
        return parent;
    }

    public void setParent(Node parent) {
        this.parent = parent;
    }
}
