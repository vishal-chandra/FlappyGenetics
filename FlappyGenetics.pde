GA alg;
Bird bird;
ArrayList<Pipe> pipes = new ArrayList();

void setup() {
  alg = new GA();
  alg.run();
  
  size(600, 600);
  background(255);
  frameRate(30);
  
  bird = new Bird();
}

void draw() {
  background(255);
  
  bird.show();
  bird.update();
  
  if(frameCount % 100 == 0) {
    pipes.add(new Pipe());
  }
  
  for(int i = 0; i < pipes.size(); i++) {
    
    Pipe p = pipes.get(i);
    
    p.show();
    
    p.update();
    
    if(p.x < -p.w) {
      pipes.remove(i);
      i--; //avoid arraylist skip
    }
    
    if(bird.collidedWith(p)) {
      pipes.clear();
      bird.reset();
    }
    
  }
  
  for(Individual ind : alg.pop.population){
    ind.aliveCount++;
  }
  
}

void keyPressed() {
  
    if(key == ' ') 
    {
      bird.up();
    }
}
