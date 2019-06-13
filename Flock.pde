import java.util.Arrays;

class Flock {
  
  int flockSize = 300;
  Bird[] birds;
  
  Bird[] fittest, offspring; //leaders will have 24 birds since 24 + 24C2 = 300
  
  Flock() {
    
    birds = new Bird[flockSize];
    for(int i = 0; i < flockSize; i++) {
      birds[i] = new Bird();
    }  
  }
  
  void runGA() {
    sortBirds();
    selection();
    crossover();
    mutate();
    newPopulation();
    resetAll(); 
  }
  
  void sortBirds() {
    Arrays.sort(birds);
  }
  
  void selection() {
    fittest = (Bird[])(subset(birds, 276)); //top 24
    offspring = new Bird[276]; //the rest
  }
  
  void crossover() {
    
    int a = 0; //array index counter
    //this block will produce all the possibilites of
    //crossing over two randomly selected leaders
    for(int i = 0; i < fittest.length - 1; i++)
      for(int j = i+1; j < fittest.length; j++) {
        offspring[a] = new Bird(fittest[i].brain.merge(fittest[j].brain));
        a++;
      }  
  }
  
  void mutate() {
    for(Bird child : offspring)
      child.brain.mutate(0.05);
  }
  
  void newPopulation() {
    birds = (Bird[])(concat(offspring, fittest));
  }
  
  void resetAll() {
    for(Bird bird : birds)
      bird.reset();
  }
  
  
}
