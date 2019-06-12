import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

public class GA
{
    Random rand = new Random();
    Population pop = new Population();
    
    public void run()
    {
        //loop count
        int genCount = 0;

        //main logic

        genCount++;

        pop.crossover();

        if(rand.nextInt(40) == 1) pop.mutate();

        pop.addFittestOffspring();

        pop.calcAllFitness();

        //display & store this gen data
        System.out.println("Generation " + genCount + ": " + pop.getFittest().fitness);

    }
}
