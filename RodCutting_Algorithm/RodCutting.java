import java.util.ArrayList;

public class RodCutting {

    private ArrayList<Integer> prices;
    private ArrayList<Integer> maxRevenueForEachCutPosition;
    private ArrayList<Integer> parentPointers;

    public RodCutting(int size) {

        maxRevenueForEachCutPosition = new ArrayList<Integer>();
        for (int i = 0; i <= size + 1; i++) {
            maxRevenueForEachCutPosition.add(Integer.MIN_VALUE);
        }
        
        parentPointers = new ArrayList<>();
        for (int i = 0; i <= size + 1; i++) {
            parentPointers.add(null);
        }

    }

    public int computeMaxRevenue(int startingPosition) {

        if (startingPosition == 0) {
            return 0;
        }

        if (maxRevenueForEachCutPosition.get(startingPosition) != Integer.MIN_VALUE) {
            return maxRevenueForEachCutPosition.get(startingPosition);
        }

        for (int i = 0; i <= startingPosition - 1; i++) {
            int revenue=prices.get(startingPosition - i) + computeMaxRevenue(i);
            if (revenue > maxRevenueForEachCutPosition.get(startingPosition)) {
                maxRevenueForEachCutPosition.set(startingPosition,revenue);
                parentPointers.set(startingPosition, i);
            }
        }
        return maxRevenueForEachCutPosition.get(startingPosition);

    }

    public void computeMaxRevenue() {

        System.out.println("The max revenue obtainable is :" + computeMaxRevenue(prices.size() - 1));
        System.out.println("These are the cut positions required to have the max revenue:");
        int position = prices.size() - 1;
        while (position != 0) {
            System.out.println(parentPointers.get(position));
            position = parentPointers.get(position);
        }
    }

    public void setPrices(ArrayList<Integer> prices) {
        this.prices = prices;
    }

    public static void main(String[] args) {

        RodCutting rodCutting = new RodCutting(10);
        ArrayList<Integer> prices = new ArrayList<>();
        prices.add(0);
        prices.add(1);
        prices.add(5);
        prices.add(8);
        prices.add(9);
        prices.add(10);
        prices.add(17);
        prices.add(17);
        prices.add(20);
        prices.add(24);
        prices.add(25);
        rodCutting.setPrices(prices);
        rodCutting.computeMaxRevenue();
    }

}
