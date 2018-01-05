public class Malla{
  PVector primero;
  PVector segundo;
  PVector tercero;
  PVector cuarto;
  color propioColor;
  int supIzX; 
  int supDerX;
  int supIzY;
  int infIzY;
  int ancho;
  IntList redAverage = new IntList();
  IntList blueAverage = new IntList();
  IntList greenAverage = new IntList();
  boolean selected = false;
  public Malla(PVector primero, PVector segundo, PVector tercero, PVector cuarto){
    this.primero = primero;
    this.segundo = segundo;
    this.tercero = tercero;
    this.cuarto = cuarto;
    this.propioColor = color(random(0,255),random(0,255),random(0,255));
    this.supIzX= (int) primero.x;
    this.supDerX= (int) tercero.x;
    this.supIzY= (int) primero.y;
    this.infIzY= (int) segundo.y;
    this.ancho =  supDerX - supIzX;
  }
  
  void draw(PGraphics canvas){
    canvas.fill(propioColor);
    canvas.stroke(0);
    canvas.beginShape();
    canvas.vertex(this.primero.x,this.primero.y);
    canvas.vertex(this.tercero.x,this.tercero.y);
    canvas.vertex(this.cuarto.x,this.cuarto.y);
    canvas.vertex(this.segundo.x,this.segundo.y);
    canvas.endShape(CLOSE);
    if(this.selected){
      println(red(propioColor),green(propioColor),blue(propioColor));
     }
  }
  void drawMalla(PGraphics canvas){
    canvas.noFill();
    canvas.stroke(0);
    canvas.beginShape();
    canvas.vertex(this.primero.x,this.primero.y);
    canvas.vertex(this.tercero.x,this.tercero.y);
    canvas.vertex(this.cuarto.x,this.cuarto.y);
    canvas.vertex(this.segundo.x,this.segundo.y);
    canvas.endShape(CLOSE);
  }
  
  public void getColor(PGraphics canvas){
    canvas.loadPixels();
    int r = 0, g = 0, b = 0;
    int totalPixels = 0;
    for(int y = this.supIzY; y < this.infIzY; y++){
       for(int x = this.supIzX ; x < this.supDerX; x++ ){
        totalPixels += 1;
         int loc = x + y * canvas.width;      
         color c = canvas.pixels[loc];
         r += c>>16&0xFF;
         g += c>>8&0xFF;
         b += c&0xFF;
      }
    }
    r /= totalPixels;
    g /= totalPixels;
    b /= totalPixels;
    /*
    if (r < 125){
      r = 0;
    }else{
      r = 255;
    }
    if (g < 125){
      g = 0;
    }else{
      g = 255;
    }
    if (b < 125){
      b = 0;
    }else{
      b = 255;
    }
    */
    color possible = distanceColor(color(r,g,b), colors, 70);
    IntList colores= new IntList();
    
    colores = movilAverage(int(red(possible)), int(green(possible)), int(blue(possible)));
    
    this.propioColor = color(r,g,b);
    color newAverageColor = color(colores.get(0), colores.get(1), colores.get(2));
    color possible2 = distanceColor(newAverageColor, colors, 1000);
    //this.propioColor = newAverageColor;
    this.propioColor = possible2;
  }
  public IntList movilAverage(int r, int g, int b){
    float newRedAverage = 0;
    float newGreenAverage = 0;
    float newBlueAverage = 0;
    IntList coloresAverage = new IntList();
    if(redAverage.size() == 20){
      redAverage.remove(0);
      greenAverage.remove(0);
      blueAverage.remove(0);
    }
    redAverage.append(r);
    greenAverage.append(g);
    blueAverage.append(b);
    for(int i = 0; i < redAverage.size(); i ++){
      newRedAverage += redAverage.get(i);
      newGreenAverage += greenAverage.get(i);
      newBlueAverage += blueAverage.get(i);
    }
    coloresAverage.append(int(newRedAverage)/redAverage.size());
    coloresAverage.append(int(newGreenAverage)/redAverage.size());
    coloresAverage.append(int(newBlueAverage)/redAverage.size());
    return coloresAverage;
    
    
  }
  
  public color distanceColor(color possible, ArrayList colors, float threshold){
    float minDist = 100000;
    int minIndex = -1;
    color minColor = color(0,0,0);
    for(int i = 0; i < colors.size();i++){
      color newColor = (color) colors.get(i);
      float distRed = sq(red(possible) - red(newColor));
      float distGreen = sq(green(possible) - green(newColor));
      float distBlue = sq(blue(possible) - blue(newColor));
      float distance = sqrt(distRed + distGreen + distBlue);
      if (distance < minDist && distance < threshold) {
        minDist = distance;
        minIndex = i;
        minColor = newColor;
      }
    }
    if(minIndex == 0){
      return color(255,0,0);
    }else if(minIndex == 1){
      return color(0,255,0);
    }
    else if(minIndex == 2){
      return color(0,0,255);
    }
    else if(minIndex == 3){
      return color(255,255,0);
    }
    else if(minIndex == 4){
      return color(255,255,255);
    }
    else if(minIndex == 5){
      return color(0,0,0);
    }
    else{
      return possible;
    }
    
  }
  
  public void createObject(PGraphics canvas){
    int ubicacionX = this.supIzX+this.ancho/2;
    int ubicacionY = this.supIzY+this.ancho/2;
    if (this.propioColor == color(255,255,255)){
      canvas.ellipse(ubicacionX, ubicacionY, 10,10);
    }
    else if (this.propioColor == color(255,0,0)){
      canvas.ellipse(ubicacionX, ubicacionY, 10,10);
    }
  }
  public boolean select(int mouseX, int mouseY) {
    int ubicacionX = this.supIzX+this.ancho/2;
    int ubicacionY = this.supIzY+this.ancho/2;
     selected = dist(ubicacionX, ubicacionY, mouseX, mouseY) < 10;
     return selected;
 }
  
  
}