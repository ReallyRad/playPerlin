
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
  //fill(146,275);
  lights();
  background(79,16,253);
  noStroke();  
  noiseScale=0.002;
  space=0.00;
  //rect(0,0,width,height);  
  interval = 2220;
  par1+=1.59;
  resolution = 8+0;
  //par2+=0.16;
  
  
  if (millis()-lastTime>interval) {
    lastTime=millis();    
    interval=(int)random(1000,5000);
    par2next = random(par1, par1+ 900);
  println("next : " + par2next);  
  }
//  println("par2 : " + par2);
  par2 += 0.00*(par2next-par2);
  
  //selected = int((selected + 0.12*(sel-selected)));
  
  //strokeWeight(4.0);
  
  fill(221);/*
  int s = 18;
  beginShape(TRIANGLE_STRIP);
  vertex(s,0,0);
  vertex(0,s,0);
  vertex(0,0,s);  
  endShape(CLOSE);*/
  for (int x=-3; x < width; x+=resolution) {
    for (int y=6; y < height; y += resolution) {
    float noiseVal = noise((par1+x)*noiseScale, par2*noiseScale, y*noiseScale);
    stroke(noiseVal*821+-129, 3*pow(3.3/noiseVal,1.6), 446*noiseVal, 271);    
    //fill(pow(1/noiseVal,4));
    //noStroke();
    //fill(noiseVal*297);    
    //fill(noiseVal*259);
    //point(x*space,y*space, -62/noiseVal);
    pushMatrix();
    
    //translate(x*space*pow(1.0/noiseVal,1.0),y*space*pow(1.0/noiseVal,1.0),pow(1.0/noiseVal,1.0));
    rotate(radians(x),1,0,0);
    rotate(radians(y),0,1,0);
    float translate = pow(noiseVal*6.7,2.27);
    translate(translate, translate,translate);
    //sphere(pow(1.7/noiseVal,1));
    //ellipse(1.6/noiseVal, 1.6/noiseVal,0,0);
    strokeWeight(pow(2/noiseVal*1.6,1.17));
    //vertex(0,0,0);
    point(0,0,0);
    popMatrix();
    float pointSize = 15.01;
    //rect(x,y, noiseVal*pointSize, noiseVal*pointSize);    
    }    
  }
  if (save) saveFrame();  
}

void keyPressed() {
  if (key == 'r') save = !save;
}
