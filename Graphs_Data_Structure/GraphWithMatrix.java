public class GraphWithMatrix {

    private Integer[][] adjMatrix;
    private int numberNodes;

    public GraphWithMatrix(int numberNodes){

        adjMatrix = new Integer[numberNodes][numberNodes];
        for(int i=0; i<numberNodes; i++){
            for(int k=0; k<numberNodes; k++){
                adjMatrix[i][k]=0;
            }
        }
        this.numberNodes=numberNodes;
    }

    public Integer[][] getAdjMatrix() {
        return adjMatrix;
    }

    public int getNumberNodes() {
        return numberNodes;
    }

    public boolean decreaseAdjacencyValue(int node1, int node2, int value){

        if(value-adjMatrix[node1][node2] >=0){
            adjMatrix[node1][node2]-=value;
            adjMatrix[node2][node1]-=value;
            if(ifRowAllZeros(node1)){
                numberNodes--;
            }
            if(ifRowAllZeros(node2)){
                numberNodes--;
            }
            return true;
        }else{
            return false;
        }
    }
    public boolean ifRowAllZeros(int node){

        for(int i=0; i<adjMatrix.length; i++){
            if(adjMatrix[node][i]>0){
                return false;
            }
        }

        return true;
    }

    public boolean increaseAdjacencyValue(int node1, int node2, int value){
        if(ifRowAllZeros(node1)){
            numberNodes++;
        }
        if(ifRowAllZeros(node2)){
            numberNodes++;
        }
        adjMatrix[node1][node2]+=value;
        adjMatrix[node2][node1]+=value;
        return true;
    }

    public void setAdjValue(int i, int k, int value){
        adjMatrix[i][k]=value;
        adjMatrix[k][i]=value;
    }


}
