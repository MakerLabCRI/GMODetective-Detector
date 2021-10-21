/*
This file creates a 3D printed version of the acrylic GMOdetective device  developed by Guy Aidelberg 

All this code is licensed under the Creative Commons - Attribution  (CC BY 3.0)
Fernán Federici 2020

Modified for UROŠ - Ubiquitous Rural Open Science Hardware
- modded slits for the filters to hold better
dusjagr Okt 2021

*/
         
//--------------------------parameter to play with
wd=6.85;//internal tube diameter    
xplate=127.6;
yplate=85.75;  
zplate=14.3;    
$fn=60;

dbw=9;//distance between center of tubes
sw=2;//support width
yborder_d=11.36;//distance between yborder and center first well
xborder_d=14.3;//distance between xborder and center first well
ext=10;

filterSlit_thickness=0.8; // for flexible filters to squeeze them in

PCB_x=100+1.5; //this is the more important parameter, you change here and everything will scale accordingly

corr=0.2;// used for printing imperfections

PCB_y=20;
PCB_z=1.25;
notch_x=4;
notch_y=4.5;
wall=3;
front=PCB_x+wall*2;
equi_side=32;
front_height=42+ext;
depth=38+ext;
window_x=71.5;
window_h=11.8+ext/2;
    
depth_sq=PCB_y+wall;
dist_centerLEDs=12;//distance of center of LEDs and front of PCB
LED_h=10;
cover=15;//to cover blue light coming from top part of tubes
win_location_h=front_height-window_h-4;
    
    
//GMO3D_square_open();



color("DeepPink",0.5) rotate([ -90, 0, 0 ]) GMO3D();



module UROS_logo(){
    linear_extrude(height = 1, center = false, convexity = 10) import(file = "UROS_logo.dxf", layer = "uros_logo");   
    linear_extrude(height = 1, center = false, convexity = 10) import(file = "UROS_logo.dxf", layer = "GMO_detective");  
    
}


module GMO3D(){
  rotate([ -45, 0, 0 ]) translate([ 0, -wall, 0]) difference(){
        // front plate
        cube([front, wall, front_height ]);
      
        // emboss logos
        #rotate([ 90, 0, 0 ]) translate([ 0,0, -0.5]) UROS_logo();
        //window
        translate([ (front-window_x)/2, -1, front_height-window_h-4 ]) cube([window_x, depth-wall+1, window_h ]);
      //orange filter slit
      rotate([ 90, 0, 0 ]) translate([ 0,equi_side+wall-window_h/2, -wall]) cube([front, depth/2, filterSlit_thickness ]);
      rotate([ 90, 0, 0 ]) translate([-1,equi_side+wall-window_h/2+8, -wall+filterSlit_thickness]) cube([front+2, depth/5, filterSlit_thickness ]);
      }

//orange filter slit holder
rotate([ -45, 0, 0 ]) translate([ 0, -wall, 0]) difference(){     
    rotate([ 90, 0, 0 ]) translate([0,equi_side+wall-window_h/2+10, -wall]) cube([front, depth/8, filterSlit_thickness]);    
    translate([ (front-window_x)/2, 0, front_height-window_h-4 ]) cube([window_x, depth-wall, window_h ]);
}
        
difference(){
    rotate([ -45, 0, 0 ]) difference(){
        cube([front, depth, front_height ]);
              
        //internal
        translate([ wall*3, wall, 0 ]) cube([PCB_x-wall*4, depth-wall, front_height-wall ]);
        //window
        translate([ (front-window_x)/2, 0
        -1, front_height-window_h-4 ]) cube([window_x, depth-wall, window_h ]);
        //tubes
        translate([(front-window_x)/2-dbw/2,wall+dbw/2,front_height-wall]) neg_tubes();
        // cut bottom
        rotate([ 45, 0, 0 ])  translate([ -0.5, 0, -front_height ]) cube([1+front+corr, front+corr, front_height ]);
        
        translate([ -0.5, depth+dbw*2, 2]) rotate([ 45, 0, 0 ]) cube([1+front+corr, front+corr, front_height*2 ]);

        //translate([ wall, 2+wall+dbw+wall/2, 0 ]) cube([front-wall*2, depth-wall, front_height ]);

    //rotate([ 90, 0, 90 ]) linear_extrude(height = front+corr, center = false, convexity = 0, twist = 0) polygon(points=[[0,0], [38,equi_side+corr], [38,0]]);
      
    }
    //PCB slit
    translate([ wall, equi_side+dbw/2-PCB_y+ext, PCB_z+ext/2 ]) cube([PCB_x, PCB_y+5, PCB_z+corr ]); 
    
    //blue filter slit
    translate([ 0, 1+equi_side-PCB_y/2, 12+ext/2 ]) cube([front, depth/2, filterSlit_thickness ]);    
    translate([ -1, equi_side, filterSlit_thickness+12+ext/2 ]) cube([front+2, 10, filterSlit_thickness ]);
    

        
    }

//PCB click-in   
difference(){   
translate([ 0, equi_side+dbw/2-PCB_y+ext+8.5, PCB_z+ext/2 ]) cube([front, 3.8, 0.32]);
   translate([ wall*2, wall, 0 ]) cube([PCB_x-wall*2, depth-wall, front_height-wall ]); 
   } 

   
//blue filter slit holder   
difference(){   
translate([ 0, equi_side+2, -0+12+ext/2 ]) cube([front, 6, filterSlit_thickness ]);
   translate([ wall*3, wall, 0 ]) cube([PCB_x-wall*4, depth-wall, front_height-wall ]); 
   } 
   
}     

    
    
    module GMO3D_square_open(){
difference(){
        union() {
            //front
            color("blue") cube([front, wall, front_height ]);
            //notches for PCB holding
                   translate([ wall, 0, 0 ])  cube([wall, depth_sq, wall*2]);
                  translate([ front-wall*2, 0, 0 ])  cube([wall, depth_sq, wall*2 ]); 
            }
 
        //window
               translate([ (front-window_x)/2, 0, front_height-window_h-4 ]) cube([window_x, depth-wall, window_h ]);
    //orange filter
translate([ 0,wall/2, front_height-window_h*1.5]) cube([front, PCB_z/2, window_h*2 ]);
            
    //PCB slit 
       translate([ wall, wall, wall ])  cube([PCB_x, PCB_y*3, PCB_z+corr ]); 
  //PCB alignment used to check holes and LEDs are aligned
        #translate([ wall, wall, wall ]) PCB();
      }
difference(){
       color("red") cube([front, depth_sq, front_height ]);

    
        //internal
        translate([ wall, wall, 0 ]) cube([front-wall*2, depth-wall, front_height-wall ]);
        //window
           translate([ (front-window_x)/2, 0, win_location_h ]) cube([window_x, depth-wall, window_h ]);
        //tubes 
    //(considering that there is 12mm from center of LEDs to front of PCB, so in order to align tubes and LEDs, this distance should be considered carefully
        translate([(front-window_x)/2-dbw/2,wall+dist_centerLEDs,front_height-wall]) neg_tubes();
    //blue filter slit
    translate([ 0, wall*2, 12+ext ]) cube([front, depth, PCB_z/2 ]);   
   //orange filter
#translate([ 0,wall/2, win_location_h-2]) cube([front*1.1, PCB_z/2, window_h*2 ]);
    }
      //cover
    translate([ 0, wall/2+PCB_z/2, front_height ]) 
    difference(){    
      color("red")  cube([front, depth_sq-wall/2-PCB_z/2, cover ]);
         translate([ wall, wall/2, 0 ])  color("yellow")  cube([front-wall*2, depth_sq-wall, cover ]);
        }
                  translate([ 0, depth_sq-wall, front_height/2])  cube([front, wall, front_height/2 ]);
    }     
    
    
//  GMO3D_square_clopen();  
  module GMO3D_square_clopen(){
 
    }     
    
    module clopen_rear(){
           //bottom
    translate([ 0, depth_sq, front_height/2])  cube([front, wall, front_height/2 ]);
}
    
//GMO3D_square();
module GMO3D_square(){
 difference(){
        union() {cube([front, wall, front_height ]);
                   translate([ wall, 0, 0 ])  cube([wall, depth_sq, wall*2]);
                  translate([ front-wall*2, 0, 0 ])  cube([wall, depth_sq, wall*2 ]); 
            }
 
        //window
               translate([ (front-window_x)/2, 0, front_height-window_h-4 ]) cube([window_x, depth-wall, window_h ]);
    //orange filter
translate([ 0,wall/2, front_height-window_h*1.5]) cube([front, PCB_z/2, window_h*2 ]);
            
    //PCB slit 
       #translate([ wall, wall, wall ])  cube([PCB_x, PCB_y*3, PCB_z+corr ]); 
  //PCB alignment
        #translate([ wall, wall, front_height-wall*4 ]) PCB();
      }
difference(){
        cube([front, depth_sq, front_height ]);
        //internal
        translate([ wall, wall, 0 ]) cube([front-wall*2, depth-wall, front_height-wall ]);
        //window
           translate([ (front-window_x)/2, 0, front_height-window_h-4 ]) cube([window_x, depth-wall, window_h ]);
        //tubes 
    //(considering that there is 12mm from center of LEDs to front of PCB, so in order to align tubes and LEDs, this distance should be considered carefully
        translate([(front-window_x)/2-dbw/2,wall+dist_centerLEDs,front_height-wall]) neg_tubes();
    //blue filter slit
    #translate([ 0, wall, 12+ext ]) cube([front, depth, PCB_z/2 ]);   
   //orange filter
translate([ 0,wall/2, front_height-window_h*1.5]) cube([front, PCB_z/2, window_h*2 ]);
    }
     

    }     
    
//PCB();    
module PCB(){
    difference(){
        cube([PCB_x, PCB_y, PCB_z+corr ]);
   
       #translate([ 0, PCB_y/2-notch_y/2, 0 ]) cube([notch_x, notch_y, PCB_z+corr ]);   
    }
       translate([(front-window_x)/2-dbw/2-wall,dist_centerLEDs,0])   LEDs();}     
    

module LEDs(){
   for(x = [1:8]){
						// tube holes
						translate([x*dbw,0,LED_h/2])
						color("orange") cylinder (h=LED_h, r = 5/2, center=true);	
       }}




 module neg_tubes(){
				for(x = [1:8]){
						// tube holes
						translate([x*dbw,0,0])
						color("orange") cylinder (h=zplate+corr, r = wd/2, center=true);	
                          }}   
    