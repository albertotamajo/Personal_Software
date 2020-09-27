public class WeigtedQuickUnion {

    int[] arrayNodes;
    int countComponents;
    int[] sizeComponentForRoot;

    public WeigtedQuickUnion(int initialNumbercomponents){

        this.arrayNodes = new int[initialNumbercomponents];
        this.sizeComponentForRoot= new int[initialNumbercomponents];

        for(int i=0; i<initialNumbercomponents; i++){
            arrayNodes[i]=i;
        }

        for(int i=0; i<initialNumbercomponents; i++){
            sizeComponentForRoot[i]=1;
        }

        this.countComponents=initialNumbercomponents;

    }

    private int find(int node){

        while(arrayNodes[node]!=node){
            node= arrayNodes[node];
        }
        return node;
    }

    public int getCountComponents(){
        return countComponents;
    }

    public boolean connected(int a, int b){
        return find(a)==find(b);
    }

    public void union(int a, int b){


        int rootNodeA=find(a);
        int rootNodeB=find(b);
        if(rootNodeA==rootNodeB){
            return;
        }

        if(sizeComponentForRoot[rootNodeA] < sizeComponentForRoot[rootNodeB]){
            arrayNodes[rootNodeA]=rootNodeB;
            sizeComponentForRoot[rootNodeB]+=sizeComponentForRoot[rootNodeA];
        }else{
            arrayNodes[rootNodeB]=rootNodeA;
            sizeComponentForRoot[rootNodeA]+=sizeComponentForRoot[rootNodeB];
        }

        countComponents--;

    }

    public static void main(String[] args) {
        WeigtedQuickUnion weightedQuickUnion= new WeigtedQuickUnion(256);

        for(int i=0; i<=254; i+=2){
            weightedQuickUnion.union(i,i+1);
        }

        for(int i=0; i<=200; i+=3){
            weightedQuickUnion.union(i,i+3);
        }

        System.out.println("Number components: " + weightedQuickUnion.getCountComponents());
        System.out.println("Find 19: " + weightedQuickUnion.find(19));
        System.out.println("Find 112: " + weightedQuickUnion.find(112));
    }
}
