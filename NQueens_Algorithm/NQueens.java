public class NQueens {

    private int size;
    private Integer[] queens;

    public NQueens(int size){
        this.size=size;
        this.queens=new Integer[size];
        for(int i=0; i<size; i++){
            this.queens[i]=null;
        }
    }

    public boolean resolveNQueens(int queenPosition){

        if(queenPosition==size){
            return chechCorrectness();
        }

        for(int i=0; i<size; i++){

            queens[queenPosition]=i;
            if(chechCorrectness() && resolveNQueens(queenPosition+1)){
                return true;
            }

        }
        queens[queenPosition]=null;
        return false;
    }
    public boolean resolveNQueens(){
        return resolveNQueens(0);
    }

    private boolean chechCorrectness(){

        for(int i=0; i<size; i++){

            for(int j=i+1; j<size; j++){

                if(queens[j]==null){
                    continue;
                }
                if(queens[j]==queens[i] || Math.abs(queens[j]-queens[i])==Math.abs((j-i)) ){
                    return false;
                }
            }
        }
        return true;
    }

    public static void main(String[] args) {
        NQueens nqueens = new NQueens(10);
        System.out.println(nqueens.resolveNQueens());
        for(Integer i=0; i<nqueens.size; i++){
            System.out.println("Row "+ i + "-> "+ nqueens.queens[i]);
        }
    }

}
