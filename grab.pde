import java.util.Arrays;

float recVoltageMax;
float recTimeMax;
float voltageMax; //電圧の最大値
float timeMax; //電圧が最大値だったときの時間
int start;
int goal;
int[] vr = new int[4];
int[] vl = new int[4];
boolean vanishflag = false;
boolean bottleflag = false;
int count = 0;

BallSystem bs;

void setup() {
  //画面サイズ
  size(800, 600);
  colorMode(RGB, 255, 255, 255, 100);
  background(0, 0, 0, 100);
  bs = new BallSystem(new PVector(width/2, height/2));
  init();
  // ポートを設定
  // PortSelected=5; 
  // シリアルポートを初期化
  // SerialPortSetup();
}

void draw() {
  background(0, 0, 0, 100);
  
  if(mousePressed==true){
    if(count%5==0 && count<50) {
      for(int i=0; i<vr.length; i++) vr[i] = vr[i] + (int)random(-10, -1);
        for(int i=0; i<vl.length; i++) vl[i] = vl[i] + (int)random(1, 10);
      }
    bs.addParticle();
    bs.run();
    count++;
  }
  if(vanishflag==true){
    count = 0;
    init();
    bs.vanishBalls();
  }

  bottle();
}

void init(){
  Arrays.fill(vr, 80);
  Arrays.fill(vl, -80);
}

void bottle(){
  pushMatrix();
  translate(width/2, height/2);
  fill(255, 0, 0, 100);
  beginShape();
  vertex(-80, -80);
  vertex(80, -80);
  vertex(vr[0], -34);
  vertex(vr[1], 12);
  vertex(vr[2], 58);
  vertex(vr[3], 104);
  vertex(80, 150);
  vertex(-80, 150);
  vertex(vl[0], 104);
  vertex(vl[1], 58);    
  vertex(vl[2], 12);
  vertex(vl[3], -34);
  endShape(CLOSE);
  popMatrix();
}

//マウスをクリック
void mouseReleased() {
  vanishflag = true;
  //現在の最大値を記録
  //recVoltageMax = voltageMax;
  //recTimeMax = timeMax;
}

void stop() {
  //myPort.stop();
  //super.stop();
}

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class BallSystem {
  ArrayList<Ball> balls;
  PVector origin;

  BallSystem(PVector position) {
    origin = position.copy();
    balls = new ArrayList<Ball>();
  }

  void addParticle() {
    balls.add(new Ball(origin));
  }

  void vanishBalls(){
    if(balls.size() <= 0) vanishflag = false;
    else{
      for (int i = balls.size()-1; i >= 0; i--) {
        Ball p = balls.get(i);
        p.vanish();

        if (p.isDead()) {
          balls.remove(i);
        }
      }
    }
  }

  void run() {
    for (int i = balls.size()-1; i >= 0; i--) {
      Ball p = balls.get(i);
      p.run();
      if (p.isDead()) {
        balls.remove(i);
      }
    }
  }

  void delete(){
    balls.clear();
  }
}


// A simple Ball class

class Ball {
  int x;
  int y;
  int speedX;
  int speedY;
  int lifespan;

  Ball(PVector origin){
    x = (int)origin.x;
    y = (int)origin.y;

    speedX = (int)random(-10, 10);
    speedY = (int)random(-10, -1);

    while(speedX == 0){
      speedX = (int)random(-10, 10);
    }
    lifespan = 255;
  }

  void run(){
    update();
    display();
  }

  void update(){
    x += speedX;
    y += speedY;

    if(x < 0 || x > width){
      speedX *= -1;
    }
    if(y < 0 || y > height){
      speedY *= -1;
    }
  }
  void vanish(){
    display();
  }

  void display(){
    fill(255,  0, 0, lifespan--);
    ellipse(x, y, 20, 20);
  }

  boolean isDead(){
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}