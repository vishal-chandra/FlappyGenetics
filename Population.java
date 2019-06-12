import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Random;

public class Population {

    Random rand = new Random();

    //settings
    int size = 10;
    int geneLength = 10;

    //holds all gene sequences
    Individual[] population = new Individual[size];

    //used for crossing over and mutation
    int[] offspring1genes = new int[geneLength];
    int[] offspring2genes = new int[geneLength];

    /**
     * Constructor. Creates a random intial population.
     */
    public Population() {
        for(int i = 0; i < size; i++) {
            population[i] = new Individual();
        }
    }

    /**
     * Fitness evaluation function. Calculates the fitness
     * of each individual
     */
    public void calcAllFitness() {
        for(int i = 0; i < population.length; i++)
            population[i].calcFitness();
    }

    /**
     * Finds the fittest individual.
     * @return An object of type Individual with the highest fitness value
     */
    public Individual getFittest() {
        calcAllFitness();

        ArrayList<Individual> arr = new ArrayList<Individual>();
        for (int i = 0; i < size; i++) {
            arr.add(population[i]);
        }
        Collections.sort(arr);

        return arr.get(size - 1); //last one
    }

    /**
     * Finds the second fittest individual
     * @return An object of type Individual with the second highest fitness value
     */
    public Individual getSecondFittest() {
        calcAllFitness();

        ArrayList<Individual> arr = new ArrayList<Individual>();
        for (int i = 0; i < size; i++) {
            arr.add(population[i]);
        }
        Collections.sort(arr);
        return arr.get(size - 1 - 1); //one less than the last one
    }

    /**
     * Finds the index at which the individual with the lowest fitness
     * value is located. Offspring will be inserted at the index returned
     * by this function.
     * @return int index
     */
    public int getLeastFitIndex() {
        calcAllFitness();

        int index = 0;
        for(int i = 0; i < size; i++) {
            if(population[i].fitness < population[index].fitness) index = i;
        }
        return index;
    }

    /**
     * Takes the two individuals with the highest fitness values and cross their
     * genes to create new offspring
     */
    public void crossover() {

        int xpt = rand.nextInt(geneLength);

        //logging
        System.out.println("Crossing over: " + Arrays.toString(offspring1genes) + " and "
                + Arrays.toString(offspring2genes) + " at " + xpt);

        //offspring 1
        for(int i = 0; i <= xpt; i++) {
            offspring1genes[i] = getFittest().genes[i];
        }
        for(int i = xpt + 1; i < geneLength; i++) {
            offspring1genes[i] = getSecondFittest().genes[i];
        }

        //offspring 2
        for(int i = 0; i <= xpt; i++) {
            offspring2genes[i] = getSecondFittest().genes[i];
        }
        for(int i = xpt + 1; i < geneLength; i++) {
            offspring2genes[i] = getFittest().genes[i];
        }
    }

    /**
     * Very rarely called. Randomly flips a bit in each of the two offspring/
     */
    public void mutate() {
        System.out.println("Mutated");
        int mpt = rand.nextInt(geneLength);
        offspring1genes[mpt] = offspring1genes[mpt] == 1 ? 0 : 1;
        mpt = rand.nextInt(geneLength);
        offspring2genes[mpt] = offspring2genes[mpt] == 1 ? 0 : 1;
    }

    /**
     * Replaces the individual with the lowest fitness value with the most fit offspring
     */
    void addFittestOffspring() {
        int fitness1 = calcGeneFitness(offspring1genes);
        int fitness2 = calcGeneFitness(offspring2genes);
        int[] finalOffspringGenes = fitness1 > fitness2 ? offspring1genes : offspring2genes;
        population[getLeastFitIndex()] = new Individual(finalOffspringGenes);
    }

    /**
     * A helper method which calculates the fitness of a certain gene sequence.
     * @param genes the gene sequence to evaluate
     * @return the fitness of the provided gene sequence.
     */
    private int calcGeneFitness(int[] genes) {
        Individual temp = new Individual(genes); //did it this way so that this
                                                // updates when fitness func is updated
        return temp.calcFitness();
    }


}
