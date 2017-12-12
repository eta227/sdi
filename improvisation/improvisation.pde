//Três instâncias de SoundChiper são usadas para habilitar peças independentes.
//A aleatoriedade restrita mantém um equilíbrio de ordem e variedade.

import arb.soundcipher.*; //importar a libraria que é preciso fazer previamente o download e colocar no exemplos (ver toturias no youtube)

SoundCipher sc = new SoundCipher(this);// eis as três instâncias
SoundCipher sc2 = new SoundCipher(this);
SoundCipher sc3 = new SoundCipher(this);
float[] pitchSet = {36, 100, 64,}; //aqui são as notas, sendo que cada numero é uma nota. Ainda preciso de ver quais os numeros que são as notas que ficam dentro da tonalidade da musica base
float setSize = pitchSet.length;
float density = 0.8;


void setup() {
  fullScreen(); //ecra completo XD
  background(0); //fundo negro
  frameRate(12);  //frameRate a 12 para impedir que com um clique toque mais de uma nota
  sc3.instrument(49); //id do instrumento (neste caso piano) da libraria soundcipher
}

void draw() {
  if (mousePressed) { //ao clicar o rato faz o seguinte
    sc.playNote(pitchSet[(int)random(setSize)], random(90)+30, random(20)/10 + 0.2); //toca uma nota aleatoria dentro das notas defenidas anteriomente em pitchSet
    fill(color(random(256), random (256), random(256))); //cor aleatoria dos quadrados 
    rect(mouseX, mouseY, random(100), random(100)); //desenhar quadrados com cada clique, na posição do rato e tamanha aleatorio entre 0  e 100
  }                                                                                                                                                      
/*  if (frameCount%32 == 0) {
    keyRoot = (random(4)-2)*2;
    density = random(7) / 10 + 0.3;
    sc2.playNote(36+keyRoot, random(40) + 70, 8.0);
  }
  if (frameCount%16 == 0) {
    float[] pitches = {pitchSet[(int)random(setSize)]+keyRoot-12, pitchSet[(int)random(setSize)]+keyRoot-12};
    sc3.playChord(pitches, random(50)+30, 4.0);
   }*/
}
