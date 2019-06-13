Flock flock;
ArrayList<Pipe> pipes = new ArrayList();
PImage img;

void setup() {
  img = loadImage("flappy.png");
  size(600, 600);
  background(255);
  frameRate(30);
  
  flock = new Flock(); 
  pipes.add(new Pipe());
}

void draw() {
  background(255);
  
  //birds
  for(Bird bird : flock.birds) {
    if(!bird.dead) {
      bird.show(img);
      bird.update();
      if(bird.y > height) { 
        bird.dead = true;
      }
    }
  }
  
  //new pipes
  if(frameCount % 100 == 0) {
    pipes.add(new Pipe());
  }
  
  //all pipes
  for(int i = 0; i < pipes.size(); i++) {
    
    Pipe p = pipes.get(i);
    
    p.show();
    p.update();
    
    if(p.x < -p.w) {
      pipes.remove(i);
      i--; //avoid arraylist skip
    }
    
    if(p.x < flock.birds[0].x) p.behindBird = true;
    
    for(Bird bird : flock.birds) { 
      if(bird.collidedWith(p)) bird.dead = true;
    }
    
  }
  
  //check which pipe is closer and feed that to
  //the neural networks
  if(!pipes.get(0).behindBird) {
    Pipe p = pipes.get(0);
    for(Bird bird : flock.birds)
      bird.decide(p.x, p.y); 
  }
  else {
    Pipe p = pipes.get(1);
    for(Bird bird : flock.birds)
      bird.decide(p.x, p.y); 
  }
  
  //checking if all dead
  boolean allDead = true;
  for(Bird bird : flock.birds) {
    if(!bird.dead) {
      allDead = false;
      break;
    }
  }
  if(allDead) {
    flock.runGA();
    reset();
  }
}

//void keyPressed() {
  
//    if(key == ' ') 
//    {
//      bird.up();
//    }
//}

void reset() {
  println("resetting");
  for(Bird bird : flock.birds)
    bird.reset();
  pipes.clear();
  frameCount = 1;
  pipes.add(new Pipe());
}
