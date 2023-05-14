//import processing.sound.*;

//SoundFile theme, lose, win;

boolean sceneWasGenerated, paused, up, down, left, right;
int scene = 0, start, time, pauseTime, displayTime, i = 0, j = 0, k = 0, w = 0, s = 0, a = 0, d = 0, x, y;
float[] tabx = new float[100];
float[] taby = new float[100];
PFont font;
PImage cemetery, player, ghost, finish;

Player p;

void setup() {
  fullScreen();
  
  //theme = new SoundFile(this, "theme.mp3");
  //lose = new SoundFile(this, "lose.mp3");
  //win = new SoundFile(this, "win.mp3");

  font = createFont("pixel.ttf", 128);
  textFont(font);
  
  cemetery = loadImage("cemetery.png");
  player = loadImage("player.png");
  ghost = loadImage("ghost.png");
  finish = loadImage("finish.png");
  
  p = new Player();
  
  sceneWasGenerated = false;
  up = false;
  down = false;
  left = false;
  right = false;
  
  paused = false;
  displayTime = 0;
}

void draw() {
  switch (scene) {
    case 0: //instrukcja przed grą
      background(cemetery);
      welcomeMsg();
      break;
    case 1: //przejście do sceny 2
      background(cemetery);
      //theme.play();
      scene = 2;
      break;
    case 2: //ładowanie gry..., respienie duchów
      p.idle();
      spawnGhosts();
      showFinishLine();
      showZeroStats();
      loadingGame();
      break;
    case 3: //gra załadowana, oczekiwanie na spację...
      background(cemetery);
      p.idle();
      ghostsSpawned(tabx, taby);
      showFinishLine();
      showZeroStats();
      break;
    case 4: //gra załadowana, w toku (timer działa)
      background(cemetery);
      ghostsSpawned(tabx, taby);
      showFinishLine();
      p.move();
      p.lost(tabx, taby);
      p.won();
      displayTimer();
      displaySpeed();
      break;
    case 5: //gra zapauzowana, timer zatrzymany
      paused = true;
      background(cemetery);
      ghostsSpawned(tabx, taby);
      showFinishLine();
      p.move();
      displayTimer();
      displaySpeed();
      pause();
      break;
  }
  
  x = width - 50;
  y = height - 50;
}

void welcomeMsg() {
  fill(0);
  rect((width / 2) - 275, (height / 2) - 70, 550, 140);
    
  fill(255);
  textSize(10);
  textAlign(CENTER, CENTER);
  text("GRA 'UCIECZKA'\nFABUŁA:\nTwoim zadaniem jest ucieczka z terenu objętego klątwą, na której nagle pojawia się 100 duchów.\nMusisz w jak najkrótszym czasie dotrzeć do wyjścia (pola w lewym górnym rogu) nie dotykając\nżadnego z duchów. Masz na to maksymalnie 100 sekund.\nINSTRUKCJA:\nW, S, A, D - ruch; [ - zmniejszenie prędkości, ] - zwiększenie prędkości, P - pauza, Esc - wyjście\nNaciśnij F, kiedy będziesz gotowy/a.", width / 2, height / 2);
}

void spawnGhosts() {
  if (i < 100) {
    tabx[i] = random(width - 100);
    taby[i] = random(height - 100);
    image(ghost, tabx[i], taby[i], 50, 50);
    i++;
  }
  if (i == 99) scene = 3;
}

void showFinishLine() {
  image(finish, 5, 5, 100, 100);
}

void showZeroStats() {
  fill(0); 
  rect(0, height - 150, 450, 150);
  fill(255);
  textSize(32);
  textAlign(BASELINE);
  text("Prędkość: " + p.speed, 20, height - 100);
  textSize(64);
  text("Czas: 0.0 s", 20, height - 30);
}

void loadingGame() {
  fill(0);
  rect((width / 2) - 220, (height / 2) - 30, 430, 70);
  fill(255);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("Ładowanie...", width / 2, height / 2);
}

void ghostsSpawned(float tabx[], float taby[]) {
  for (int i = 0; i < 100; i++) image(ghost, tabx[i], taby[i], 50, 50);
}

void displaySpeed() {
  fill(0); 
  rect(0, height - 150, 450, 50);
  fill(255);
  textSize(32);
  textAlign(BASELINE);
  text("Prędkość: " + p.speed, 20, height - 100);
}

void displayTimer() {
  if (j == 0) time = millis();
  fill(0); 
  rect(0, height - 100, 450, 100);
  fill(255);
  textSize(64);
  textAlign(BASELINE);
  text("Czas: " + (millis() - time) / 1000 + "." + (millis() - time) % 10 + " s", 20, height - 30);
  j++;
  if (((int) (millis() - time) / 1000 >= 9 && ((int) (millis() - time) % 10 >= 9))) {
    fill(0);
    rect((width / 2) - 315, (height / 2) - 70, 620, 85);
    fill(255);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("Koniec czasu! :(", width / 2, height / 2);
    //theme.stop();
    //lose.play();
    looping = false;
  }
}

void pause() {
  if (paused) {
    if (k == 0) pauseTime = millis();
    fill(0); 
    rect(0, height - 100, 450, 100);
    fill(255);
    textSize(64);
    textAlign(BASELINE);
    text("Czas: " + (pauseTime) / 1000 + "." + (pauseTime) % 10 + " s", 20, height - 30);
    k++;
    fill(0);
    rect((width / 2) - 200, (height / 2) - 30, 390, 70);
    fill(255);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("Pauza", width / 2, height / 2);
    //theme.stop();
    //lose.play();
  }
  else {
    //theme.play();
  }
}

void keyPressed() {
  switch(key) {
    case 'f':
      if (!sceneWasGenerated) {
        scene = 1;
        sceneWasGenerated = true;
      }
      break;
    case 'F':
      if (!sceneWasGenerated) {
        scene = 1;
        sceneWasGenerated = true;
      }
      break;
    case ' ':
      scene = 4;
      break;
    case 'p':
      scene = 5;
      if (paused) {
        scene = 4;
        paused = false;
      }
      break;
    case 'P':
      scene = 5;
      if (paused) {
        scene = 4;
        paused = false;
      }
      break;
    case 'w':
      up = true;
      break;
    case 'W':
      up = true;
      break;
    case 's':
      down = true;
      break;
    case 'S':
      down = true;
      break;
    case 'a':
      left = true;
      break;
    case 'A':
      left = true;
      break;
    case 'd':
      right = true;
      break;
    case 'D':
      right = true;
      break;
  }
}

void keyReleased() {
  switch(key) {
    case 'w':
      up = false;
      break;
    case 'W':
      up = false;
      break;
    case 's':
      down = false;
      break;
    case 'S':
      down = false;
      break;
    case 'a':
      left = false;
      break;
    case 'A':
      left = false;
      break;
    case 'd':
      right = false;
      break;
    case 'D':
      right = false;
      break;
  }
}
