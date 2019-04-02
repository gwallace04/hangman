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
  
  int incorrectGuesses = 0;
  
  // The values of each letter eg a = 1, b = 3, etc
  private final int[] LETTER_SCORES = {
    1, 3, 3, 2, 1, 4, 2, 4, 1, 8,
    5, 1, 3, 1, 1, 3, 10, 1, 1, 1,
    1, 4, 4, 8, 4, 10
  };
  
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
  
  public int getScore(String word) 
  {
    int wordScore = 0;
    int score = 0;
    for(char letter: word.toCharArray()) 
    {
      wordScore += getLetterScore(letter);
    }
    score = wordScore / (incorrectGuesses + 1);
    score *= 100;
    return score;
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
  
  private int getLetterScore(char letter) 
  {
    char upper = Character.toUpperCase(letter);
    return LETTER_SCORES[upper - 'A'];
  }
  
}//End game
