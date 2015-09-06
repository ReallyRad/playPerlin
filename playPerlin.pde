
import oscP5.*;
import netP5.*;  
OscP5 oscP5;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import ddf.minim.*;

Minim minim;
AudioInput in;
AudioPlayer player;

PeasyCam cam;
float noiseScale;
float par1, par2, par2next;
int lastTime;
int interval;
int resolution;
float space;
float LoFollower, MidFollower, HiFollower;
boolean save;
ArrayList<PVector> points;

void setup() {
  size (400, 400, OPENGL);
  par1 = 0;
  par2 = 0;
  par2next = 0;
  lastTime=millis();
  smooth();
  colorMode(HSB, 255);
  rectMode(RADIUS);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(3);
  cam.setMaximumDistance(10000647);
  save = false;
  
   minim = new Minim(this);
  oscP5 = new OscP5(this,1337);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  
  player = minim.loadFile("u.aif");
  player.play();
}


boolean sketchFullScreen() {
  return false;
}
void draw() {  
  translate(-width/2*space, -height/2*space);
  rotate(radians(0.13*par1), 0.51, 1, 0);  
  lights();
  background(79, 16, 253);
  background(1, 1, 1);
  noStroke();  
  //the following values are set here in order to be tweaked within tweak mode
  noiseScale=0.002;
  space=0.00;    
  interval = 2220;
  par1+=1.59;
  resolution = 35;  

  if (millis()-lastTime>interval) { //event to jump to a new value with a smoothed transition
    lastTime=millis();    
    interval=(int)random(5000, 15000);
    par2next = random(par1, par1+ 900);
    println("next : " + par2next);
  }

  par2 += 0.000*(par2next-par2); //the value we're going through the perlin noise with
  beginShape();
  for (int x=-0; x < in.bufferSize(); x+=resolution) {
    for (int y=0; y < in.bufferSize(); y += resolution) {
      //float noiseVal = in.left.get(x)*50; 
      float noiseVal = player.left.get(x+)*5;
      //noise((par1+x)*noiseScale, par2*noiseScale, y*noiseScale);
      stroke((noiseVal*821+par1)%255, 3*pow(3.3/noiseVal, 2.1), 446*noiseVal, 271);        
      pushMatrix();
      rotate(radians(x), 1, 0, 0);
      rotate(radians(y), 0, 1, 0);
      float translate = pow(noiseVal*6.7, 2.27);
      translate(translate, translate, translate);    
      strokeWeight(pow(2/noiseVal*1.6,1.17));
          
      point(0,0,0);
      vertex(0,0,0);
      //sphere(pow(2/noiseVal*1.6, 1.17));
      //points.add(new PVector
     popMatrix();
      float pointSize = 15.01;
    }
  }
  if (save) saveFrame();
  endShape(CLOSE);
  stroke(255);
  /*println("LoFollower : ", 100*LoFollower);
  println("MidFollower : ", 100*MidFollower);
  println("HiFollower : ", 100*HiFollower);*/ 
}

void keyPressed() {
  if (key == 'r') save = !save;
}

void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/benjour/HiFollower")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("ifs")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      HiFollower = theOscMessage.get(0).intValue();           
      return;
    }  
  }

 if(theOscMessage.checkAddrPattern("/benjour/MidFollower")==true) {
    /* check if the typetag is the right one. */
    //if(theOscMessage.checkTypetag("ifs")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      MidFollower = theOscMessage.get(0).intValue();
      println("hi");      
      return;
    //}  
  }   

 if(theOscMessage.checkAddrPattern("/benjour/LoFollower")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("ifs")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      LoFollower = theOscMessage.get(0).intValue();
            
      return;
    }  
  }     
}
