int flockSize = 10;
Bird[] flock = new Bird[flockSize];

class Flock {
  
  Flock() {
    for(int i = 0; i < flockSize; i++) {
      flock[i] = new Bird();
    }
  }
  
}
