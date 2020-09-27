import java.util.Scanner;

public class EditDistance {

    public class Parent{

        private Integer i;
        private Integer j;
        private String operation;
        public Parent(Integer i, Integer j, String operation){
            this.i=i;
            this.j=j;
            this.operation=operation;
        }

        public void setI(int i) {
            this.i = i;
        }

        public void setJ(int j) {
            this.j = j;
        }

        public void setOperation(String operation) {
            this.operation = operation;
        }
    }
    private String string1;
    private String string2;
    private int[][] minDistance;
    private Parent[][] parentPointers;

    public EditDistance(String string1, String string2){
        this.string1=string1;
        this.string2=string2;
        this.minDistance=new int[string1.length()+1][string2.length()+1];
        for(int i=0; i<string1.length()+1; i++){

            for(int j=0; j<string2.length()+1; j++){
                minDistance[i][j]=Integer.MAX_VALUE;
            }
        }
        this.parentPointers=new Parent[string1.length()+1][string2.length()+1];
        for(int i=0; i<string1.length()+1; i++){

            for(int j=0; j<string2.length()+1; j++){
                parentPointers[i][j]=new Parent(null,null,null);
            }
        }
    }

    public int computeDistance(int string1Position, int string2Position){

        if(string1Position==string1.length() && string2Position==string2.length()){
            return 0;
        }
        if(string1Position== string1.length()){
            parentPointers[string1Position][string2Position].setOperation("Add all chars of string 2 from index "+ string2Position +"onward");
            return string2.length()-string2Position;
        }
        if(string2Position==string2.length()){
            parentPointers[string1Position][string2Position].setOperation("Delete all chars of string 1 from  index "+string1Position+" onward");
            return string1.length()-string1Position;
        }
        if(minDistance[string1Position][string2Position]!=Integer.MAX_VALUE){
            return minDistance[string1Position][string2Position];
        }
        int bestValue=Integer.MAX_VALUE;

        if(string1.charAt(string1Position)==string2.charAt(string2Position)){

            int value=computeDistance(string1Position+1,string2Position+1);
            if(value<bestValue){
                bestValue=value;
                minDistance[string1Position][string2Position]=bestValue;
                parentPointers[string1Position][string2Position].setI(string1Position+1);
                parentPointers[string1Position][string2Position].setJ(string2Position+1);
                parentPointers[string1Position][string2Position].setOperation("Leave char at index "+string1Position);
            }
        }

        //Delete Opearation
        for(int i=0; i<2; i++){
            int value;
            //Delete Operation
            if (i==0){
                value=1+computeDistance(string1Position+1,string2Position);
                if(value<bestValue){
                    bestValue=value;
                    minDistance[string1Position][string2Position]=bestValue;
                    parentPointers[string1Position][string2Position].setI(string1Position+1);
                    parentPointers[string1Position][string2Position].setJ(string2Position);
                    parentPointers[string1Position][string2Position].setOperation("Delete char at index "+string1Position);

                }
            }else{  //Insert operation
                value=1+computeDistance(string1Position,string2Position+1);
                if(value<bestValue){
                    bestValue=value;
                    minDistance[string1Position][string2Position]=bestValue;
                    parentPointers[string1Position][string2Position].setI(string1Position);
                    parentPointers[string1Position][string2Position].setJ(string2Position+1);
                    parentPointers[string1Position][string2Position].setOperation("Insert char " +string2.charAt(string2Position) +" at index "+string2Position);
                }
            }

        }
        return bestValue;

    }

    public int computeDistance(){
        return computeDistance(0,0);



    }

    public void printActionSequence(){
        Parent parent = parentPointers[0][0];

        while(true){
            System.out.println(parent.operation);
            if(parent.i==null && parent.j==null){
                break;
            }
            parent=parentPointers[parent.i][parent.j];
        }

    }

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        String string1= scan.nextLine();
        System.out.println("\n");
        String string2 = scan.nextLine();
        System.out.println();
        EditDistance editDistance= new EditDistance(string1, string2);
        System.out.println(editDistance.computeDistance());
        editDistance.printActionSequence();
    }


}
