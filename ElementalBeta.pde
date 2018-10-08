//
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
 
 //Para la pantalla
int pantalla;
int ofs =0;
int ofs_v =1;
//Para declarar Imagenes 
PImage puerta1;
PImage puerta2;
PImage avatar;

Box2DProcessing box2d;

ArrayList<Boundary> boundaries;
ArrayList<Box> boxes;

void setup() {
  size(740,460);
  puerta1 = loadImage("APuerta_1.png");
  puerta2 = loadImage("APuerta_2.png");
  avatar = loadImage("_avatar.png");
  smooth();
  
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);

  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();

  boundaries.add(new Boundary(width/5,height-5,width/2-50,10)); 
  boundaries.add(new Boundary(3*width/4,height-5,width/1-50,10));
  boundaries.add(new Boundary(width-6,height/1.2,10,height));
  boundaries.add(new Boundary(5,height/1.2,10,height));
}

void draw() {
  background(255);
  image(puerta1,0,4);
  image(puerta2,687,4);
  image(avatar,345,300);

  box2d.step();

  if (random(1) < 0.1) {
    if (boxes.size() < 50){
      Box p = new Box(random(width),10);
    boxes.add(p);
    }
  }
  
  if (mousePressed) {
    for (Box b: boxes) {
     b.attract(mouseX,mouseY);
    }
  }

  // Para los pinches límites
  for (Boundary wall: boundaries) {
    wall.display();
  }

  for (Box b: boxes) {
    b.display();
  }

  // Las particulas que salen de la pantalla, se eliminan.
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
  
  fill(0);
  text("Pulsa el cursor para mover los elementos",50,20);
  text("hacia las puertas de salida",60,32);
}
