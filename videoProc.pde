
public class SecondApplet extends PApplet {
  int w;
  int h;
  public SecondApplet(int w, int h){
    this.w = w;
    this.h = h;
  }
  public void settings() {
    size(this.w, this.h);
  }
  public void setup(){
    canvasStats = createGraphics(this.w, this.h);
    String[] cameras = Capture.list();
    //println(cameras);
    video = new Capture(this, canvasStats.width, canvasStats.height, cameras[3]);
    video.start();
  }
  public void draw() {
    video.loadPixels();
    canvasStats.beginDraw();  
    canvasStats.image(video, 0, 0);
    for(Malla m : mallas){
      m.getColor(canvasStats);
      m.drawMalla(canvasStats);
    }
    
    canvasStats.endDraw();
    image(canvasStats, 0, 0);
    
  }
  void mouseClicked(){
    actual = getColor(canvasStats, mouseX, mouseY);
  }
  
  //asign to actual when is clicked
  public color getColor(PGraphics canvas, int x, int y){
    canvas.loadPixels();
    return canvas.get(x,y);
  }
  void captureEvent(Capture video) {
    video.read();
  }
  void keyPressed() {
    switch(key) {
        case '1':
            red = actual;
            colors = new ArrayList();
            colors.add(red);
            colors.add(green);
            colors.add(blue);
            colors.add(yellow);
            colors.add(white);
            colors.add(black);
            break;
        case '2':
            green = actual;
            colors = new ArrayList();
            colors.add(red);
            colors.add(green);
            colors.add(blue);
            colors.add(yellow);
            colors.add(white);
            colors.add(black);
            break;
        case '3':
            blue = actual;
            colors = new ArrayList();
            colors.add(red);
            colors.add(green);
            colors.add(blue);
            colors.add(yellow);
            colors.add(white);
            colors.add(black);
            break;
        case '4':
            yellow = actual;
            colors = new ArrayList();
            colors.add(red);
            colors.add(green);
            colors.add(blue);
            colors.add(yellow);
            colors.add(white);
            colors.add(black);
            break;
        case '5':
            white = actual;
            colors = new ArrayList();
            colors.add(red);
            colors.add(green);
            colors.add(blue);
            colors.add(yellow);
            colors.add(white);
            colors.add(black);
            break;
        case '6':
            black = actual;
            colors = new ArrayList();
            colors.add(red);
            colors.add(green);
            colors.add(blue);
            colors.add(yellow);
            colors.add(white);
            colors.add(black);
            break;
    }
  }

 
}