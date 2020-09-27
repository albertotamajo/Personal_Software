import java.util.HashSet;

public class Graph {
    private HashSet<Node> nodes;

    public Graph(HashSet<Node> nodes){
        this.nodes = nodes;
    }

    public HashSet<Node> getNodes() {
        return nodes;
    }

}
