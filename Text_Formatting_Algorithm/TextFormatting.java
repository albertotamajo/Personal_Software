
public class TextFormatting {

    private String[] text;
    private int maxLengthLine;
    private int[] bestJustifiedTextValue;
    private Integer[] parentPointers;

    public TextFormatting(String text, int maxLengthLine){
        this.text=text.split(" ");
        this.maxLengthLine=maxLengthLine;
        bestJustifiedTextValue= new int[this.text.length];
        for(int i=0; i<this.text.length; i++){
            bestJustifiedTextValue[i]=Integer.MAX_VALUE;
        }
        parentPointers=new Integer[this.text.length];
        for(int i=0; i<this.text.length; i++){
            parentPointers[i]=null;
        }
    }

    private int badness(int startingWordIndex, int endingWordIndex){
        int lengthLine=0;
        for(int i=startingWordIndex; i<=endingWordIndex-1; i++){

            if(i==endingWordIndex-1){
                lengthLine+=text[i].length();
            }else{
                lengthLine+=text[i].length()+1;
            }

        }
        if(lengthLine > maxLengthLine){
            return Integer.MAX_VALUE;
        }else{
            return (int)Math.pow((maxLengthLine-lengthLine),3);
        }
    }

    private int computeBestJustifiedText(int indexWord){

        if(bestJustifiedTextValue[indexWord]!=Integer.MAX_VALUE){
            return bestJustifiedTextValue[indexWord];
        }

        if(indexWord==text.length-1){
            int badness=badness(indexWord,indexWord+1);
            bestJustifiedTextValue[indexWord]=badness;
            return  badness;
        }


        int bestValue=Integer.MAX_VALUE;
        int nextStartingWordIndex=indexWord+1;
        while(nextStartingWordIndex!=(text.length+1)){
            int value=Integer.MAX_VALUE;
            if(nextStartingWordIndex==text.length){
                value=badness(indexWord,nextStartingWordIndex);
            }else{
                value=computeBestJustifiedText(nextStartingWordIndex)+badness(indexWord,nextStartingWordIndex);
            }
            if(value < 0){
                value=Integer.MAX_VALUE;
            }

            if(value<bestValue){

                bestValue=value;
                bestJustifiedTextValue[indexWord]=bestValue;

                if(nextStartingWordIndex==text.length){
                    parentPointers[indexWord]=null;
                }else{
                    parentPointers[indexWord]=nextStartingWordIndex;
                }

            }

            nextStartingWordIndex+=1;
        }
        return bestValue;

    }


    public void justifyText(){
        int value=computeBestJustifiedText(0);
        System.out.println("The best justified text has the following value: "+value);
        Integer parent=parentPointers[0];


    }

    private void printOutJustifiedText(){

        Integer nextStartingWordIndex=parentPointers[0];

        for(Integer i=0; i<text.length; i++){

            if(i==text.length-1){
                if(i==nextStartingWordIndex){
                    System.out.println("\n"+text[i]);
                }else{
                    System.out.print(text[i]);
                }

            }else{
                if(i==nextStartingWordIndex){
                    System.out.print("\n"+text[i] + " ");

                    if(parentPointers[nextStartingWordIndex]!=null){
                        nextStartingWordIndex=parentPointers[nextStartingWordIndex];
                    }

                }else{
                    System.out.print(text[i]+" ");
                }
            }

        }
    }

    public static void main(String[] args) {
        String text = "Isa is beautiful and very sexy. I love her.";
        TextFormatting textFormatting = new TextFormatting(text,25);
        textFormatting.justifyText();
        textFormatting.printOutJustifiedText();
    }


}
