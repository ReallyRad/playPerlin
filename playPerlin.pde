
import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;
float noiseScale;
float par1, par2, par2next;
int lastTime;
int interval;
int resolution;
float space;
boolean save;

void setup() {
size (1366/2, 625, OPENGL);
par1 = 0;
par2 = 0;
par2next = 0;
lastTime=millis();
smooth();
colorMode(HSB,255);
rectMode(RADIUS);
cam = new PeasyCam(this, 100);
cam.setMinimumDistance(3);
cam.setMaximumDistance(10647);
save = false;
}


boolean sketchFullScreen(){
return false;
}
void draw() {  
  translate(-width/2*space,-height/2*space);
  rotate(radians(0.13*par1),0.51,1,0);  
  lights();
  background(79,16,253);
  noStroke();  
  //the following values are set here in order to be tweaked within tweak mode
  noiseScale=0.002;
  space=0.00;    
  interval = 2220;
  par1+=1.59;
  resolution = 8;  
    
  if (millis()-lastTime>interval) { //event to jump to a new value with a smoothed transition
    lastTime=millis();    
    interval=(int)random(1000,5000);
    par2next = random(par1, par1+ 900);
  println("next : " + par2next);  
  }

  par2 += 0.00*(par2next-par2); //the value we're going through the perlin noise with

  for (int x=-3; x < width; x+=resolution) {
    for (int y=6; y < height; y += resolution) {
    float noiseVal = noise((par1+x)*noiseScale, par2*noiseScale, y*noiseScale);
    stroke(noiseVal*821+-129, 3*pow(3.3/noiseVal,1.6), 446*noiseVal, 271);        
     
    rotate(radians(x),1,0,0);
    rotate(radians(y),0,1,0);
    float translate = pow(noiseVal*6.7,2.27);
    translate(translate, translate,translate);    
    strokeWeight(pow(2/noiseVal*1.6,1.17));    
    point(0,0,0);
    popMatrix();
    float pointSize = 15.01;       
    }    
  }
  if (save) saveFrame();  
}

void keyPressed() {
  if (key == 'r') save = !save;
}
