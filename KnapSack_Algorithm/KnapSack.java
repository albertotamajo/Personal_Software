public class KnapSack {

    private class Parent {
        private Integer i = null;
        private Integer j = null;
        private boolean isTaken;
    }

    private int sizeKnapSack;
    private Object[] objects;
    private int maxValue[][];
    private Parent[][] parentPointers;

    public KnapSack(int sizeKnapSack,Object[] objects) {

        this.sizeKnapSack = sizeKnapSack;
        this.objects=objects;
        this.maxValue = new int[objects.length][sizeKnapSack + 1];

        for (int i = 0; i < objects.length; i++) {
            for (int j = 0; j < sizeKnapSack + 1; j++) {
                maxValue[i][j] = Integer.MIN_VALUE;
            }
        }
        this.parentPointers = new Parent[objects.length + 1][sizeKnapSack + 1];
        for (int i = 0; i < objects.length + 1; i++) {
            for (int j = 0; j < sizeKnapSack + 1; j++) {
                parentPointers[i][j] = new Parent();
            }
        }
    }

    public int computeMaxValueKnapSack(int objectIndex, int remainingSizeKnapSack) {

        if (remainingSizeKnapSack < 0) {
            return Integer.MIN_VALUE;
        }
        if (objectIndex == objects.length) {
            return 0;
        }
        if (maxValue[objectIndex][remainingSizeKnapSack] != Integer.MIN_VALUE) {
            return maxValue[objectIndex][remainingSizeKnapSack];
        }

        int bestValue = Integer.MIN_VALUE;
        for (int i = 0; i < 2; i++) {
            int value;
            if (i == 0) {
                value = objects[objectIndex].value + computeMaxValueKnapSack(objectIndex + 1, remainingSizeKnapSack - objects[objectIndex].size);
                if (value > bestValue) {
                    bestValue = value;
                    maxValue[objectIndex][remainingSizeKnapSack] = bestValue;
                    parentPointers[objectIndex][remainingSizeKnapSack].i = objectIndex + 1;
                    parentPointers[objectIndex][remainingSizeKnapSack].j = remainingSizeKnapSack - objects[objectIndex].size;
                    parentPointers[objectIndex][remainingSizeKnapSack].isTaken=true;
                }
            } else {
                value = computeMaxValueKnapSack(objectIndex + 1, remainingSizeKnapSack);

                if (value > bestValue) {
                    bestValue = value;
                    maxValue[objectIndex][remainingSizeKnapSack] = bestValue;
                    parentPointers[objectIndex][remainingSizeKnapSack].i = objectIndex + 1;
                    parentPointers[objectIndex][remainingSizeKnapSack].j = remainingSizeKnapSack;
                    parentPointers[objectIndex][remainingSizeKnapSack].isTaken=false;
                }
            }


        }
        return bestValue;
    }

    public void computeMaxKnapSack(){
        int maxValue=computeMaxValueKnapSack(0,sizeKnapSack);
        System.out.println("The max value is: "+maxValue);
    }

    public void followParents(){
        Parent parent = parentPointers[0][sizeKnapSack];
        while(parent.i!=null && parent.j!=null){

            if(parent.isTaken){
                System.out.println("Take item");
            }else{
                System.out.println("Leave item");
            }

            parent=parentPointers[parent.i][parent.j];
        }
    }

    public static void main(String[] args) {
        Object o=new Object(12,10);
        Object a = new Object(5,8);
        Object c = new Object(1,12);

        Object[] objects = new Object[]{o,a,c,new Object(27

                ,50),new Object(2,40)};
        for(Object x : objects){
            System.out.println(x.size);
        }
        KnapSack knapSack = new KnapSack(30,objects);
        knapSack.computeMaxKnapSack();
        knapSack.followParents();


    }





}

