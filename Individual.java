import java.util.Random;
//import basic_neural_network.*;

public class Individual implements Comparable<Individual> {
    Random rand = new Random();

    int geneLength = 10;

    //key info
    int[] genes = new int[geneLength];
    int fitness = 0;
    int aliveCount;

    public Individual() {
        for (int i = 0; i < geneLength; i++)
            genes[i] = rand.nextInt(2);
    }

    public Individual(int[] genes) {
        this.genes = genes;
    }

    public int calcFitness() {
        fitness = 0;
        for(int i = 0; i < geneLength; i++) {
            if(genes[i] == 1) fitness++;
        }
        return fitness;
    }

    public int compareTo(Individual ind) {
        if(this.fitness == ind.fitness) return 0;
        if(this.fitness > ind.fitness) return 1;
        return -1;
    }

    public String toString() {
        String str = "";
        for(int i : genes)
            str += i;
        return str;
    }
}
