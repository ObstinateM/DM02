import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GMI1DM2_BEAUVILLE_Mathis extends PApplet {

///////////////////////////////////////////////////// //<>//
//
// Visualiseur d'Art Polygonal
// DM2 "UED 131 - Programmation impérative" 2020-2021
// NOM         : Beauville
// Prénom      : Mathis
// N° étudiant : 20200048
//
// Collaboration avec : 
//
/////////////////////////////////////////////////////

//
// les variables globales
//
int largeur, hauteur;
int nbSommet = 0;
int nbArete = 0;
int nbFace = 0;
boolean newFile = false;
File newFilePath;
String nom;

//
// initialisation
//
public void setup() {
  
  selectInput("Lire le fichier : ", "litFichier");
}

//
// boucle de rendu
//
public void draw() {
  if(newFile){
    litFichier(newFilePath);
    newFile = false;
  }
}

//
// Gère l'interaction clavier
// --------------------------
// 'o' : charge une image
//
public void keyTyped() {
  if (keyPressed){
    if (key == 'o' || key == 'O'){
      selectInput("Lire le fichier : ", "fichierSelectionne");
    }
  }
}

//
// Sélectionne l'image à afficher
// ------------------------------
// selection : le fichier renvoyé par la boîte de dialogue d'ouverture du fichier
//
public void fichierSelectionne(File selection) {
  newFile = true;
  newFilePath = selection;
}

//
// Lit l'entete du fichier
// -----------------------
// fichier : le fichier d'entrée
//
public void litEntete(BufferedReader fichier) {
  BufferedReader reader;
  reader = fichier;
  try {
    nom = reader.readLine();
    largeur = PApplet.parseInt(reader.readLine());
    hauteur = PApplet.parseInt(reader.readLine());
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

//
// Affiche le sommet
// -----------------
// x, y : les coordonnées (x,y) du sommet
// t    : la taille du point 
//
public void afficheSommet(String couleur, int taille, int abscisse, int ordonnee) {
  int clr = unhex(couleur);
  int scl = taille;
  int x = abscisse;
  int y = ordonnee;
  stroke(clr);
  strokeWeight(scl);
  point(x, y);
}

//
// Lit les caractéristiques d'un sommet et affiche le sommet
// ---------------------------------------------------------
// fichier : le fichier d'entrée
//
public void litSommet(BufferedReader fichier) {
  try {
    BufferedReader reader;
    reader = fichier;
    String couleur = reader.readLine();
    int taille = PApplet.parseInt(reader.readLine());
    int abscisse = PApplet.parseInt(reader.readLine());
    int ordonnee = PApplet.parseInt(reader.readLine());
    reader.readLine(); // Ferme la balise
    afficheSommet(couleur, taille, abscisse, ordonnee);
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

//
// Affiche l'arête
// ---------------
// x1, y1 : les coordonnées (x1,y1) d'une extrémité du segment 
// x2, y2 : les coordonnées (x2,y2) de l'autre extrémité du segment 
// t      : la taille du segment
// c      : la couleur du segment
//
public void afficheArete(String couleur, int largeur, int premierAbscisse, int premierOrdonnee, int secondAbscisse, int secondOrdonnee) {
    int clr = unhex(couleur);
    int lgr = largeur;
    int firstX = premierAbscisse;
    int firstY = premierOrdonnee;
    int secondX = secondAbscisse;
    int secondY = secondOrdonnee;
    stroke(clr);
    strokeWeight(lgr);
    line(firstX, firstY, secondX, secondY);
}

//
// Lit les caractéristiques d'une arête et affiche l'arête
// -------------------------------------------------------
// fichier : le fichier d'entrée
//
public void litArete(BufferedReader fichier) {
  try {
    BufferedReader reader;
    reader = fichier;
    String couleur = reader.readLine();
    int largeur = PApplet.parseInt(reader.readLine());
    int firstX = PApplet.parseInt(reader.readLine());
    int firstY = PApplet.parseInt(reader.readLine());
    int secondX = PApplet.parseInt(reader.readLine());
    int secondY = PApplet.parseInt(reader.readLine());
    reader.readLine(); // Ferme la balise
    afficheArete(couleur, largeur, firstX, firstY, secondX, secondY);
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

//
// Lit les caractéristiques d'une face et affiche la face
// ------------------------------------------------------
// fichier : le fichier d'entrée
//
public void litEtAfficheFace(BufferedReader fichier) {
  try {
    BufferedReader reader;
    reader = fichier;
    int couleur = unhex(reader.readLine());
    int nbPts = PApplet.parseInt(reader.readLine());
    int[][] coordFace;
    coordFace = new int[nbPts][2];
    fill(couleur);

    beginShape();

    for (int i = 0; i < nbPts; ++i) {
      int[] temp;
      temp = new int[2];
      int line = PApplet.parseInt(reader.readLine());
      temp[0] = line;
      line = PApplet.parseInt(reader.readLine());
      temp[1] = line;
      coordFace[i] = temp;
      vertex(coordFace[i][0], coordFace[i][1]);
    }
    vertex(coordFace[0][0], coordFace[0][1]);
    
    endShape();

    reader.readLine(); // Ferme la balise
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

//
// dessine le cartouche d'information
//
public void afficheInfo() {
  fill(0);
  text(nom, 25, 25);
  text(largeur, 25, 35);
  text(hauteur, 25, 45);
  text(nbSommet, 25, 55);
  text(nbArete, 25, 65);
  text(nbFace, 25, 75);
}

//
// lit le fichier sélectionné
// --------------------------
// fichier : le nom du fichier à lire
//
public void litFichier(File selection) {
  // ouverture du fichier
  BufferedReader reader = createReader(selection);
  String line = null;
  int i = 0;
  try {
    // lecture du fichier
    line = reader.readLine();
    if (line.equals("<entete>") == true){
      litEntete(reader);
      reader.readLine(); // Ferme l'entete
    }

    // TO LOOP AFTER ALL
    line = reader.readLine();
    while(line != null){
      if (line.equals("<sommet>") == true){
        nbSommet += 1;
        litSommet(reader);
        line = reader.readLine();
      } else if (line.equals("<arete>") == true){
        nbArete += 1;
        litArete(reader);
        line = reader.readLine();
      } else if (line.equals("<face>") == true){
        nbFace+= 1;
        litEtAfficheFace(reader);
        line = reader.readLine();
      }
    }
  afficheInfo();


    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}

  public void settings() {  size(800,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GMI1DM2_BEAUVILLE_Mathis" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
