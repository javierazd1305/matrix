public class Colors extends PApplet {
  int w;
  int h;
  public Colors(int w, int h){
    this.w = w;
    this.h = h;
  }
  public void settings() {
    size(this.w, this.h);
  }
  public void setup(){
    canvasColor = createGraphics(this.w, this.h);
  }
  public void draw() {
    canvasColor.beginDraw();
    canvasColor.background(240);
    for(int i = 0; i < colors.size(); i++){
      color coloRect = (color) colors.get(i);
      canvasColor.fill(coloRect);
      canvasColor.rect(20, 10 + i*25, 15,15);
      canvasColor.text(int(red(coloRect)) + " " + int(green(coloRect)) + " " + int(blue(coloRect)), 50, 25 + i*25);
    }
    canvasColor.endDraw();
    image(canvasColor, 0, 0);
    
  }
  void mouseClicked(){
    
  }
}