/*
 * Hue Palette. Controlling a RGB led Strip. Work in progress
 * Firmware v1.0. Upload to arduino board.
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
 * Based PololuLedStrip library example.
 * 
 * Made(by)Frutos http://madebyfrutos.wordpress.com/
 * Ocero El Bierzo, Spain Dec'12
 */

#include <PololuLedStrip.h>
#define HEADER        '|'
#define MOUSE         'M'
#define MESSAGE_BYTES  5  // the total bytes in a message

// Create an ledStrip object on pin 12.
PololuLedStrip<13> ledStrip;

// Create a buffer for holding 60 colors.  Takes 180 bytes.
#define LED_COUNT 30
rgb_color colors[LED_COUNT];


void setup()
{
  Serial.begin(115200);
  delay(500);
 
}

void loop(){
 if ( Serial.available() >= MESSAGE_BYTES)
  {
      if( Serial.read() == HEADER)
          {
            int tag = Serial.read();
            
            if(tag<30 && tag> -1)
            {
             int reg = Serial.read(); // this was sent as a char      
             int grin = Serial.read() ;
             int blu = Serial.read() ;
             
             rgb_color color;             
              color.red = reg;
              color.green = grin;
              color.blue = blu;
              
             colors[tag] = color;
              
             ledStrip.write(colors, LED_COUNT);
              Serial.print(tag);
              Serial.print(":");
              Serial.print(reg);
              Serial.print(",");
              Serial.print(grin);
              Serial.print(",");
              Serial.println(blu);
            }
            else
            {
                    Serial.print("message with unknown format");
              Serial.println(tag);
            }
          }
  }
}

