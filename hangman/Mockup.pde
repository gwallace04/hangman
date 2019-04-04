PFont f;  //This will hold the font
String s = "Hello World!";
String fnames[] = {"Canyon.PNG"};
int imgIndex = 0; //load fnames
PImage img;
int lives = 6;
String[] phrases;
int phraseIndex;
String phrase;
String coded_phrase = "";
IntDict letters_in_phrase;

void setup() {
  size(900, 500);
  surface.setResizable(true);
  img = loadImage(fnames[imgIndex]);
  phrases = loadStrings("Phrases.txt");
  phraseIndex = int(random(phrases.length));
  phrase = phrases[phraseIndex];
  for (int i = 0; i < phrase.length(); i++) {
    //if (phrase[i].match(/[a-z]/i)); //Check if letter
    if (phrase.charAt(i) == ' ') coded_phrase += "/ ";
    else coded_phrase += "_ ";
  }
  surface.setSize(img.width, img.height);
  //Set up your font here
  f = createFont("Arial", 48);
  textFont(f);
  
}
void draw() {
  //Control your display here
  background(0); //Set canvas to black
  image(img, 0, 0);
  fill(255, 100, 0);
  textAlign(LEFT);
  text(lives, 50, 50);
  text(phrase, 50, 100);
  text(coded_phrase, 50, 150);
}

void mousePressed() {
  lives -= 1;
}

void keyPressed() {
  print(key);
}
