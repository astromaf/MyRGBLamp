/*
 * Hue Palette. Controlling a RGB led Strip. Work in progress
 *  
 * Hue is the color reflected from or transmitted through an object 
 * and is typically referred to as the name of the color (red, blue, yellow, etc.) 
 * Move the cursor vertically over each bar to alter its hue. 
 *
 * Shows the operation of an RGB light using a digital LED strip. 
 * After activating the bluetooth, open the apliacación to control the lamp.
 * The program shows a hue palette divided into 30 rods: one for each LED from the strip.
 * Click and drag the mouse cursor to make your own patterns. 
 * Clicking on a rod while the spacebar is pressed removes the color (switch off this led).
 *
 * Based on Processing color example.
 * 
 * Made(by)Frutos http://madebyfrutos.wordpress.com/
 * Ocero El Bierzo, Spain Dec'12
 */
 
import processing.serial.*; 
  // The serial port:
Serial myPort;
public static final char HEADER = '|';
public static final char MOUSE  = 'M';

int barWidth = 21;
int lastBar = -1;
color c1;
int r,g,b;
int whichBar;



void setup() 
{
  size(630,630);
  colorMode(HSB, height, height, height);  
  noStroke();
  background(0);
  // List all the available serial ports:
  println(Serial.list());

  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[8],115200);

}
void draw(){}


void mouseDragged(){  
  
 whichBar  = mouseX / barWidth;
  
  if (whichBar != lastBar) {
    int barX = whichBar * barWidth;
     
     c1=color(mouseY, height, height);
      
    fill(c1);
    
    rect(barX, 0, barWidth, height);
    lastBar = whichBar;
    
    r = c1 >> 16 & 0xFF;
    g= c1 >> 8 & 0xFF;
    b = c1 & 0xFF;
   sendMessage(whichBar,r,g,b);
     
  }// end if
}// end mouseDragged

void mouseClicked(){  
  
 whichBar  = mouseX / barWidth;
  
  //if (whichBar != lastBar) {
    int barX = whichBar * barWidth;
    
    if (keyPressed == true) {
   c1=0;
  }else{
     
     c1=color(mouseY, height, height);
        
  }
  
  fill(c1);
    
    rect(barX, 0, barWidth, height);
    lastBar = whichBar;
    
    r = c1 >> 16 & 0xFF;
    g= c1 >> 8 & 0xFF;
    b = c1 & 0xFF;
   sendMessage(whichBar,r,g,b);
     
  //}// end if
} //end clicked



void sendMessage(int tag,int reg,int grin,int blu){
  // send the given tag and value to the serial port
  myPort.write(HEADER);
  myPort.write(tag);
  myPort.write(reg);
  myPort.write(grin);
  myPort.write(blu);
}

