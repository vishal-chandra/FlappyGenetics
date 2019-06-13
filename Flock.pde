class Flock {
  
  int flockSize = 100;
  Bird[] birds;
  
  Flock() {
    
    birds = new Bird[flockSize];
    for(int i = 0; i < flockSize; i++) {
      birds[i] = new Bird();
    }
  }
}
