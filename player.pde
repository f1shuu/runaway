class Player {
  boolean lost, won;
  float x, y, w, h, speed, speedX, speedY;
  
  Player() {
    lost = false;
    won = false;
    
    x = width - 50;
    y = height - 50;
    speedX = 0;
    speedY = 0;
  }
  
  void dialogueBox() {
    fill(0);
    rect(width - 550, 0, 550, 170);
    
    fill(255);
    textSize(10);
    text("GRA 'UCIECZKA'\nFABUŁA:\nTwoim zadaniem jest ucieczka z terenu objętego klątwą, na której nagle pojawia się 100 duchów.\nMusisz w jak najkrótszym czasie dotrzeć do wyjścia (białego pola w lewym górnym rogu) nie\ndotykając żadnego z duchów.\nINSTRUKCJA:\n1. Wciśnij F, aby pojawiły się duchy, a timer uruchomił się. Pamiętaj! Gdy zaczniesz się\nporuszać, timer też zacznie odliczanie, a limit czasu to tylko 100 sekund!\n2. Poruszaj się klawiszami W, S, A i D.\nPowodzenia i miłej gry!", width - 540, 15);
  }
  
  void idle() {
    image(player, x, y, 25, 40);
  }
    
  void move() {
    if (paused) {
      speed = 0;
    }
    else speed = 4;
    if (up) {
      speedX = 0;
      speedY = -speed;
    }
    if (down) {
      speedX = 0;
      speedY = speed;
    }
    if (left) {
      speedX = -speed;
      speedY = 0;
    }
    if (right) {
      speedX = speed;
      speedY = 0;
    }
    if (up && down) {
      speedY = 0;
    }
    if (!up && !down) {
      speedY = 0;
    }
    if (left && right) {
      speedX = 0;  
    }
    if (!left && !right) {
      speedX = 0;  
    }
    if (up && right) {
      speedX = speed;
      speedY = -speed;
    }
    if (right && down) {
      speedX = speed;
      speedY = speed;
    }
    if (down && left) {
      speedX = -speed;
      speedY = speed;
    }
    if (left && up) {
      speedX = -speed;
      speedY = -speed;
    }
    if (left && up && right) {
      speedX = 0;
      speedY = -speed;
    }
    if (up && right && down) {
      speedX = speed;
      speedY = 0;
    }
    if (right && down && left) {
      speedX = 0;
      speedY = speed;
    }
    if (down && left && up) {
      speedX = -speed;
      speedY = 0;
    }
    if (up && down && left && right) {
      speedX = 0;
      speedY = 0;
    }
    x += speedX;
    y += speedY;
    image(player, x, y, 25, 40);
  }
  
  void lost(float[] tabx, float[] taby) {
    for (int i = 0; i < 100; i++) {
      if ((x <= tabx[i] + 50 && x >= tabx[i] && y <= taby[i] + 50 && y >= taby[i]) || (x + 25 <= tabx[i] + 50 && x + 25 >= tabx[i] && y <= taby[i] + 50 && y >= taby[i]) || (x <= tabx[i] + 50 && x >= tabx[i] && y + 40 <= taby[i] + 50 && y + 40 >= taby[i]) || (x + 25 <= tabx[i] + 50 && x + 25 >= tabx[i] && y + 40 <= taby[i] + 50 && y + 40 >= taby[i])) {
        fill(0);
        rect((width / 2) - 185, (height / 2) - 30, 360, 70);
        fill(255);
        textSize(64);
        textAlign(CENTER, CENTER);
        text("Porażka :(", width / 2, height / 2);
        //theme.stop();
        //lose.play();
        looping = false;
      }
    }
  }
  
  void won() {
    if (x <= 65 && y <= 65) {
      fill(0);
      rect((width / 2) - 200, (height / 2) - 30, 390, 70);
      fill(255);
      textSize(64);
      textAlign(CENTER, CENTER);
      text("Gratulacje!", width / 2, height / 2);
      //theme.stop();
      //win.play();
      looping = false;
    }
  }
}
