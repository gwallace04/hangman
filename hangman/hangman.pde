/*
	Hangman game for CSC-545 using Processing



*/

  
import processing.sound.*;
SoundFile soundFile;

Game game;
PFont f;
int textX = 10;
int textY = 15;

void setup()
{ 
  //Canvas
  size(20, 20);
  surface.setResizable(true);
  surface.setSize(1200, 800);
  
  //Game setup
  game = new Game();
  game.init();
  
  //Text stuff
  f = createFont("arial", 16);
  textFont(f);
  
  soundFile = new SoundFile(this, "The_Ecstacy_of_Gold.mp3");
  soundFile.amp(0.25);
  soundFile.loop();
  
  
}

void draw()
{
  background(0);
  game.update();
 
   //Draw text data
   fill(0, 0, 0);
   //String s1 = "(" + mouseX + ", " + mouseY +") ";
   //text(s1, textX, textY);
}

void mousePressed()
{
  
}

void mouseReleased()
{
  
  game.mouseRelease();
}

/*  65-90 Capital letters
    97-122 lowercase letters
*/
void keyReleased()
{
  if((key >= 65 && key <= 90) || (key >= 97 && key <= 122))
      game.keyRelease();
      
  if((key == ENTER || key == RETURN) && game.isGameEnd)
      game.reset();
}
