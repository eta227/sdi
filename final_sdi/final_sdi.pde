import arb.soundcipher.*; //link: http://www.explodingart.com/soundcipher/index.html
import processing.video.*;

SoundCipher sc = new SoundCipher(this);
SoundCipher sc2 = new SoundCipher(this);
SoundCipher sc3 = new SoundCipher(this);
boolean callMethod = false;
color trackColor; 
//cada numero aqui é uma nota. Cada variavel (array) tem um conjunto de notas
float[] pitchSet1 = {31, 26, 28}; //aqui são as notas, sendo que cada numero é uma nota. Ainda preciso de ver quais os numeros que são as notas que ficam dentro da tonalidade da musica base
float[] pitchSet11 = {33};        //estes notas pertencem á escala pentatonica de Lam
float[] pitchSet2 = {36, 38, 40};
float[] pitchSet3 = {43, 45, 48};
float[] pitchSet4 = {50, 52, 55};
float[] pitchSet5 = {57, 60, 62};
float[] pitchSet6 = {64, 67, 69};
float[] pitchSet7 = {72, 74, 76};
float[] pitchSet8 = {79, 81, 84};
float[] pitchSet9 = {86, 88, 91};
float[] pitchSet10 = {93};
float setSize1 = pitchSet1.length;
float setSize2 = pitchSet2.length;
float setSize3 = pitchSet3.length;
float setSize4 = pitchSet4.length;
float setSize5 = pitchSet5.length;
float setSize6 = pitchSet6.length;
float setSize7 = pitchSet7.length;
float setSize8 = pitchSet8.length;
float setSize9 = pitchSet9.length;
float setSize10 = pitchSet10.length;
float setSize11 = pitchSet11.length;
float density = 50;

Capture cam;
float noteDuration;
int x, y, a, b; //estas variaveis vão ser a posição da bola e de onde se vão tocar as notas (importate)

void setup() {
  size(1200, 640);  //tamanho ecra
  frameRate(12); //frames por segundo = 12
  sc.instrument(sc.PIANO);
  //id do instrumento (neste caso piano) da libraria soundcipher
 
  
  String[] cameras = Capture.list();   //lista as webcams
  
  if (cameras.length == 0) {// este condição if nao interessa muito. é para ver se as camera estão boas de saúde!
    println("There are no cameras available for capture."); 
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]); 
    }
    
    // elemento da array que retir da lista de cameras a camera
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }    
  trackColor = color(255, 0, 0);
}

void draw() {
  if (cam.available() == true) { 
    cam.read();
    cam.loadPixels();
    
    float maxBri = 0; 
    int theBrightPixel = 0; //pixel luminoso
    for(int i=0; i<cam.pixels.length; i++) {  //aqui é para ir buscar o pixel mais luminoso
      if(brightness(cam.pixels[i]) > maxBri) {
        maxBri = brightness(cam.pixels[i]);
        theBrightPixel = i;
      }
    }
    x = theBrightPixel % cam.width*2;  //as variaveis que vão definir a posição da bola
    y = theBrightPixel / cam.width+90;  //vais buscar a posição do pixel mais luminoso em x e em y
  }
  image(cam, 0, 0, width, height);
  strokeWeight(4.0);
  stroke(0);
  fill(#FFFFFF);
  ellipse(x, y, 20, 20);
  
  if (keyPressed) {  //utilizei key pressed so para testar o toque das notas. Na realidade, keyPressed = bater do sapato
    noStroke();
    fill(#FFFFFF);
    ellipse(x, y, 10, 10);
  }
  
  fill(10);
  stroke(10, 10, 10, 100);
  
  line(60, 0, 60, height);  //linhas para orientar onde estão as notas 
  line(120, 0, 120, height);
  line(240, 0, 240, height);
  line(360, 0, 360, height);
  line(480, 0, 480, height);
  line(600, 0, 600, height);
  line(720, 0, 720, height);
  line(840, 0, 840, height);
  line(960, 0, 960, height);
  line(1080, 0, 1080, height);
  float pixelVermelho = 500; 

  // XY coordinate of closest color
  int closestX = 0;
  int closestY = 0;
 if(keyPressed) {
   noteDuration = random(20, 100); 
  } else {
   noteDuration = 0; 
  }
  
   // começar loop, vai saltando de pixel em pixel
  for (int x = 0; x < cam.width; x++ ) {
    for (int y = 0; y < cam.height; y++ ) {
      int loc = x + y * cam.width;

      color currentColor = cam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);
      float d = dist(r1, g1, b1, r2, g2, b2); 

      if (d < pixelVermelho) {
        pixelVermelho = d;
        closestX = x;
        closestY = y;
      }
    }
  }
  a = closestX*2-20;
  b = closestY+140;
  
  if (pixelVermelho < 1) { 
    // Draw a circle at the tracked pixel
    fill(trackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(a, b, 16, 16);
  }
 
}


void keyReleased() { 
  int loc = mouseX + mouseY*cam.width;
  trackColor = color(255, 0, 0);
  //tocar das notas 
  
  if (key == 'q' ||key == 'Q') {
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
  sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.BASS_DRUM);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    }
}











if (key == 'w' ||key == 'W') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.ACOUSTIC_SNARE);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
  
  
  
  
  
  
  
  
  
  
  
  if (key == 'e' ||key == 'E') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.JAZZ_GUITAR);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
  
  
  
  
  
  
  
  
  
  
   if (key == 'r' ||key == 'R') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.STEEL_GUITAR);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
  
  
  
  
  
  
  
  
  
  
    if (key == 't' ||key == 'T') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_GUITAR);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
  
  
  
  
  
  
  
  
  if (key == 'y' ||key == 'Y') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.DISTORTED_GUITAR);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
  
  
  
  
  
  
  
  
  
  
   if (key == 'u' ||key == 'U') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.FINGERED_BASS);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
  
  
  
  
  
  
  
  
  
  
  
  
  if (key == 'i' ||key == 'I') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.ELECTRIC_PIANO);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
  
  
  
  
  
  
  
  
  
  
  
     if (key == 'o' ||key == 'O') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.HONKYTONK_PIANO);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
  
  
  
  
  
  
  
  
  
  
  
  
    if (key == 'z' ||key == 'Z') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.METAL_PAD);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }











  if (key == 'x' ||key == 'X') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.HALO_PAD);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }












    if (key == 'c' ||key == 'C') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.SOLO_VOX);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }














  if (key == 'v' ||key == 'V') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.ALTO_SAX);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }













  if (key == 'b' ||key == 'B') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.CLARINET);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }









 if (key == 'n' ||key == 'N') {
  //tocar das notas 
  if(x > 0 && x < 60 &&   //se a tecla tocar com a variavel x e y dentro destes parametros,
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet1[(int)random(setSize1)], random(85, 100), noteDuration);  //vai tocar estar notas, dentro daquela array que defini no inicio
  }
   if(x > 60 && x < 120 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet11[(int)random(setSize11)], random(85, 100), noteDuration);
  }
   if(x > 120 && x < 240 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet2[(int)random(setSize2)], random(85, 100), noteDuration);
  }
  if(x > 240 && x < 360 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet3[(int)random(setSize3)], random(85, 100), noteDuration);
  }
  if(x > 360 && x < 480 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet4[(int)random(setSize4)], random(85, 100), noteDuration);
  }
  if(x > 480 && x < 600 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet5[(int)random(setSize5)], random(85, 100), noteDuration);
  }
  if(x > 600 && x < 720 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet6[(int)random(setSize6)], random(85, 100), noteDuration);
  }
   if(x > 720 && x < 840 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet7[(int)random(setSize7)], random(85, 100), noteDuration);
  }
   if(x > 840 && x < 960 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet8[(int)random(setSize8)], random(85, 100), noteDuration);
  }
  if(x > 960 && x < 1080 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet9[(int)random(setSize9)], random(85, 100), noteDuration);
  }
  if(x > 1080 && x < 1200 && 
      y > 0 && y < height){
        sc.instrument(sc.GMSAW_WAVE);
  sc.playNote(pitchSet10[(int)random(setSize10)], random(85, 100), noteDuration);
    } 
  }
}