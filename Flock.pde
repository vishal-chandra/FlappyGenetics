import java.util.Arrays;

class Flock {
  
  int flockSize = 300;
  Bird[] birds;
  
  Bird[] leaders, losers; //leaders will have 24 birds since 24 + 24C2 = 300
  
  Flock() {
    
    birds = new Bird[flockSize];
    for(int i = 0; i < flockSize; i++) {
      birds[i] = new Bird();
    }  
  }
  
  void sortBirds() {
    Arrays.sort(birds);
  }
  
  void selection() {
    leaders = (Bird[])(subset(birds, 275)); //top 24
    losers = new Bird[276];
  }
  
  void crossover() {
    
    int a = 0; //array index counter
    //this block will produce all the possibilites of
    //crossing over two randomly selected leaders
    for(int i = 0; i < leaders.length - 1; i++)
      for(int j = i+1; j < leaders.length; j++) {
        
      }  
  }
  
  
  
  
  
  
  
  
}
