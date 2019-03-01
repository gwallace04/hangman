/*


*/


public class Game
{
  String[] background = {"titlescreen.png", "gamescreen.png"};
  PImage titleBG, gameBG, currentBG;
  
  boolean isRunning;
  
  //Title screen hitboxes 220x60
  int[] newGameRect = {440, 335, 660, 395};
  int[] scoreRect = {440, 440, 660, 500};
  int[] quitRect = {440, 570, 660, 630};
  
  public Game()
  {
    isRunning = false;
  }
  
  public void init()
  {
    titleBG = loadImage(background[0]);
    gameBG = loadImage(background[1]);
    currentBG = titleBG;
  }
  
  public void mouseRelease()
  {
  if(!isRunning)
  {
    if(inHitBox(newGameRect))
    {
    //create a new game
    isRunning = true;
    currentBG = gameBG;
    }
  
    else if(inHitBox(scoreRect)) 
    {
    //show scores
    }
  
    else if(inHitBox(quitRect)) 
    {
    exit();
    }
  }//End if !isRunning
  }
  
  public void update()
  {
    image(currentBG, 0, 0);
    //
    if(isRunning)
    {
      
      
    }
    else //Show the title screen
    {   
    /* These checks only highlight on mouse over
      See game->mouseRelease for handling click event
    */
    if(inHitBox(newGameRect)) drawBox(newGameRect);
    else if(inHitBox(scoreRect)) drawBox(scoreRect);
    else if(inHitBox(quitRect)) drawBox(quitRect);
    }
  }
  
  private boolean inHitBox(int[] hitBox)
  {
  boolean isxHit = false;
  boolean isyHit = false;
  if(mouseX > hitBox[0] && mouseX < hitBox[2]) isxHit = true;
  if(mouseY > hitBox[1] && mouseY < hitBox[3]) isyHit = true;
  return (isyHit && isxHit);
  }
  
  private void drawBox(int[] hitBox)
  {
    int x1 = hitBox[0];
    int x2 = hitBox[2];
    int y1 = hitBox[1];
    int y2 = hitBox[3];
    //{440, 335, 660, 275};
    stroke(255, 0, 0);
    line(x1, y1, x1, y2);
    stroke(0, 255, 0);
    line(x1, y2, x2, y2);
    stroke(0, 0, 255);
    line(x2, y2, x2, y1);
    stroke(255, 255, 0);
    line(x2, y1, x1, y1);
  }
  
}//End game
