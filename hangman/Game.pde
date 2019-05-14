/*


*/


public class Game
{
  String[] background = {"titlescreen.png", "gamescreen.png"};
  PImage titleBG, gameBG, currentBG, scoreBG;
  
  boolean isRunning;
  boolean isScoreScreen;
  
  //Title screen hitboxes 220x60
  int[] newGameRect = {440, 335, 660, 395};
  int[] scoreRect = {440, 440, 660, 500};
  int[] quitRect = {440, 570, 660, 630};
  
  int incorrectGuesses = 0;
  char[] hangManWord;
  String[] playerWord;
  String[] phrases;
  String[] scores;
  int phraseIndex;
  String phrase;
  int totalLetters;
  int correctGuesses;
  char[] guessedLetters = {};
  
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
    scoreBG = loadImage("scores+background.png");
    phrases = loadStrings("Phrases.txt");
    phraseIndex = int(random(phrases.length));
    phrase = phrases[phraseIndex];
    hangManWord = phrase.toCharArray();
    playerWord = new String[hangManWord.length];
    
    for(int i = 0; i < hangManWord.length; i++)
      if (hangManWord[i] == ' ') playerWord[i] = "/";
      else if (hangManWord[i] == '\'') playerWord[i] = "'";
      else if (hangManWord[i] == ',') playerWord[i] = ",";
      else {
        playerWord[i] = "_";
        totalLetters += 1;
      }

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
    isScoreScreen = true;
    isRunning = false;
    }
  
    else if(inHitBox(quitRect)) 
    {
    exit();
    }
  }//End if !isRunning
  else {
    
  }
  }
  
  public void update()
  {
    image(currentBG, 0, 0);
    //
    if(isRunning)
    {
      //String output = new String(playerWord);
      text(incorrectGuesses, 50, 50);
      text(join(playerWord, " "), 50, 100);
      if (incorrectGuesses >= 6) {
        text("You lose", 50, 200);
        String score = str(getScore(phrase));
        text("Score: " + score, 50, 225);
      }
      if (correctGuesses == totalLetters) {
        text("You win", 50, 150);
        String score = str(getScore(phrase));
        text("Score: " + score, 50, 225);
      }
      
    } 
    else if (isScoreScreen) {
      image(scoreBG, 0, 0);
      //background(255);
      fill(0);
      textSize(50);
      
      //Control where the columns of scores appear
      int column1 = 315;
      int column2 = 650;
      int yPos = 375;
      
      //Read the scores from "Scores.txt"
      scores = loadStrings("Scores.txt");
      scores = reverse(sort(scores));
      
      //Display the scores
      for (int i = 0; i < 5; i++) {
        text(str(i + 1) + ". " + scores[i], column1, yPos + i*100);
      }
      for (int i = 5; i < 10; i++) {
        text(str(i + 1) + ". " + scores[i], column2, yPos + (i - 5)*100);
      }
      
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
    float wordScore = 0;
    float score = 0;
    for(char letter: word.toCharArray()) 
    {
      wordScore += getLetterScore(letter);
    }
    score = (float) wordScore / (incorrectGuesses + correctGuesses + 1);
    score *= 100;
    return (int) score;
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
    stroke(0, 0, 0);
    line(x1, y1, x1, y2);
    stroke(0, 0, 0);
    line(x1, y2, x2, y2);
    stroke(0, 0, 0);
    line(x2, y2, x2, y1);
    stroke(0, 0, 0);
    line(x2, y1, x1, y1);
  }
  
  private int getLetterScore(char letter) 
  {
    char lower = Character.toLowerCase(letter);
    if (Character.isLetterOrDigit(lower)) {
      return LETTER_SCORES[lower - 'a'];
    } else {
      return 0;
    }
  }
  
  public void keyRelease()
  {
    boolean inWord = false;
    boolean alreadyGuessed = false;
    //Uses global "key" variable from processing
    //ex: System.out.println(key);
    for(int i = 0; i < guessedLetters.length; i++) {
      if(Character.toLowerCase(key) == Character.toLowerCase(guessedLetters[i]))
      {
        alreadyGuessed = true;
        break;
      }
    }
    if (alreadyGuessed == false) {
      guessedLetters = append(guessedLetters, Character.toLowerCase(key));
      for(int i = 0; i < hangManWord.length; i++)
      {
        if(Character.toLowerCase(key) == Character.toLowerCase(hangManWord[i]))
        {
          playerWord[i] = str(hangManWord[i]);
          correctGuesses += 1;
          inWord = true;
        } 
      }
      if(!inWord) incorrectGuesses++;
    }
      
    //The rest of this method just prints to console to see whats going on
    //for(char c : playerWord)
    //  System.out.print(c);
      
    System.out.print("\tIncorrect Guesses:" + incorrectGuesses);
    System.out.println();
  }
  
}//End game
