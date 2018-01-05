import processing.video.*;
JSONObject jsonColors;
PGraphics canvasStats;
PGraphics canvas;
PGraphics canvasColor;

SecondApplet sa1 = new SecondApplet(640,640);
Colors col = new Colors(100,200);

Capture video;
int nblocks = 40;
int scl;
PVector[][] malla = new PVector[nblocks][nblocks];
ArrayList<Malla> mallas = new ArrayList();
color yellow = color(255,255,0);
color red = color(255,0,0);
color green = color(0,255,0);
color blue = color(0,0,255);
color white = color(255,255,255);
color black = color(0,0,0);
color actual = color(0,0,0);
ArrayList colors = new ArrayList();
boolean continueReading = true;

void settings(){
  size(640,640);
}
void setup(){
  canvas = createGraphics(width, height);
  scl = canvas.width/nblocks; //modificar para el temaño
  colors.add(red);
  colors.add(green);
  colors.add(blue);
  colors.add(yellow);
  colors.add(white);
  colors.add(black);
  for(int w = 0; w < malla.length; w++){
     for(int z = 0; z < malla.length; z++){
      int puntox = w*scl;
      int puntoy = z*scl;
      malla[w][z] = new PVector(puntox,puntoy);
    } 
  }
  for(int i = 0; i < nblocks-1; i++){
    for(int y = 0; y < nblocks-1; y++){
      PVector pri = malla[y][i];
      PVector sec = malla[y][i+1];
      PVector ter = malla[y+1][i];
      PVector cuar = malla[y+1][i+1];
      mallas.add(new Malla(pri,sec,ter,cuar)); 
    }
  }
  String[] args = {"Animation"};
  String[] argsCol = {"colors"};
  PApplet.runSketch(args, sa1);
  PApplet.runSketch(argsCol, col);
}

void draw(){
 canvas.beginDraw();
 canvas.background(255);
 for(Malla m : mallas){
      m.draw(canvas);
      m.createObject(canvas);
 }
  canvas.endDraw();
  image(canvas, 0, 0);
}

void keyPressed() {
    switch(key) {
        case 'e':
            exportJSON();      
            break;
    }
}

void mouseClicked() {
    for(Malla m : mallas){
      m.select(mouseX,mouseY);
 }
}

void exportJSON(){
   jsonColors = new JSONObject();
  String[] colors = { "red", "green", "blue","yellow","white","black"};
  color[] colorsValue = { red, green, blue, yellow, white, black};
  int index = 0;
  for (color i : colorsValue){
    String colorName = colors[index];
    float redTemp = red(i);
    float greenTemp = green(i);
    float blueTemp = blue(i);
    String colorValues = str(int(redTemp)) + ',' + str(int(greenTemp)) + ',' + str(int(blueTemp));
    jsonColors.setString(colorName, colorValues);
    index ++;
  }
  saveJSONObject(jsonColors, "data/colors.json");
  println("json exported!");
}