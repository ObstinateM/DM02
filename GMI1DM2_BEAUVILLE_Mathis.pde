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
int xMax = 0;
int xMin = 1000;
int yMax = 0;
int yMin = 1000;
int tailleSommet = 1;

boolean newFile = false;
boolean newSommet = false;

File newFilePath;

String nom;

float scaleRatio = 1.0;

//
// Structure de donnée
//
int[][] coordFace = new int[500][500];
int[][] coordSommet = new int[500][4];
int[][] coordArete = new int[500][6];

//
// initialisation
//
void setup() {
  size(800,800);
  selectInput("Lire le fichier : ", "fichierSelectionne");
}

//
// boucle de rendu
//
void draw() {
  if(newFile){
    clearData();
    scale(1);
    litFichier(newFilePath);
    newFile = false;
  }
  if (keyPressed){
    if (key == 'z' || key == 'Z'){
      background(255);
      translate(width/2, height/2);
      scaleRatio += 0.1;
      scale(scaleRatio);
      translate(-width/2,-height/2);

      afficheAretes();
      afficheFaces();
      afficheSommets();

      clearData();
      litFichier(newFilePath);

    } else if (key == 's' || key == 'S'){
      background(255);
      translate(width/2, height/2);
      scaleRatio -= 0.1;
      scale(scaleRatio);
      translate(-width/2,-height/2);

      afficheAretes();
      afficheFaces();
      afficheSommets();

      clearData();
      litFichier(newFilePath);
    } else if (key == 'x' || key == 'X'){
      delay(1000);
      tailleSommet += 10;
      changeSommet();
    } else if (key == 'w' || key == 'W'){
      delay(1000);
      arpSave();
    }
  }
}

//
// Modifier la taille des sommets
//
void changeSommet(){
  newSommet = true;
  clearData();
  litFichier(newFilePath);
}


//
// Reset les variables/tableaux
//
void clearData(){
  background(255);
  stroke(255);
  strokeWeight(1);
  fill(255);
  nbSommet = 0;
  nbArete = 0;
  nbFace = 0;
}


//
// Save nouveau .arp
//
void arpSave(){
  	
  PrintWriter file;
  file = createWriter("newarp.arp");

  // Entete
  file.println("<entete>");
  file.println(nom);
  file.println(largeur);
  file.println(hauteur);
  file.println("</entete>");

  // Sommet
  for (int i = 1; i < nbSommet+1; ++i) {
    file.println("<sommet>");
    file.println(hex(coordSommet[i][0]));
    file.println(coordSommet[i][1]);
    file.println(coordSommet[i][2]);
    file.println(coordSommet[i][3]);
    file.println("</sommet>");
  }

  // Arete
  for (int i = 1; i < nbArete+1; ++i) {
    file.println("<arete>");
    file.println(hex(coordArete[i][0]));
    file.println(coordArete[i][1]);
    file.println(coordArete[i][2]);
    file.println(coordArete[i][3]);
    file.println(coordArete[i][4]);
    file.println(coordArete[i][5]);
    file.println("</arete>");
  }

  // Face
  for (int i = 1; i < nbFace+1; ++i) {
    file.println("<face>");
    file.println(hex(coordFace[i][0]));
    file.println(coordFace[i][1]);
    for (int j = 0; j < coordFace[i][1]*2; ++j) {
      file.println(coordFace[i][2+j]);
    }
    file.println("</face>");
    println(i);
  }
  file.flush();
  file.close();
  println(coordSommet.length);
}

//
// Gère l'interaction clavier
// --------------------------
// 'o' : charge une image
//
void keyTyped() {
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
void fichierSelectionne(File selection) {
  newFile = true;
  newFilePath = selection;
}

//
// Lit l'entete du fichier
// -----------------------
// fichier : le fichier d'entrée
//
void litEntete(BufferedReader fichier) {
  BufferedReader reader;
  reader = fichier;
  try {
    nom = reader.readLine();
    largeur = int(reader.readLine());
    hauteur = int(reader.readLine());
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
void afficheSommet(String couleur, int taille, int abscisse, int ordonnee) {
  int clr = unhex(couleur);
  int scl = taille;
  int x = abscisse;
  int y = ordonnee;
  stroke(clr);
  strokeWeight(scl);
  point(x, y);
}

void afficheSommets(){
  for (int i = 0; i < nbSommet+1; ++i) {
    stroke(coordSommet[i][0]);
    strokeWeight(coordSommet[i][1]);
    point(coordSommet[i][2], coordSommet[i][3]);
  }
}

//
// Lit les caractéristiques d'un sommet et affiche le sommet
// ---------------------------------------------------------
// fichier : le fichier d'entrée
//
void litSommet(BufferedReader fichier) {
  try {
    BufferedReader reader;
    reader = fichier;
    coordSommet[nbSommet][0] = unhex(reader.readLine());
    if (newSommet) {
      coordSommet[nbSommet][1] = tailleSommet;
      reader.readLine();
    } else {
      coordSommet[nbSommet][1] = int(reader.readLine());
    }
    coordSommet[nbSommet][2] = int(reader.readLine());
    coordSommet[nbSommet][3] = int(reader.readLine());
    reader.readLine(); // Ferme la balise
    // afficheSommet(coordSommet[nbSommet][0], coordSommet[nbSommet][1], coordSommet[nbSommet][2], coordSommet[nbSommet][3]);
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
void afficheArete(String couleur, int largeur, int premierAbscisse, int premierOrdonnee, int secondAbscisse, int secondOrdonnee) {
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

void afficheAretes() {
  for (int i = 0; i < nbArete+1; ++i) {
    stroke(coordArete[i][0]);
    strokeWeight(coordArete[i][1]);
    line(coordArete[i][2], coordArete[i][3], coordArete[i][4], coordArete[i][5]);
  }
}

//
// Lit les caractéristiques d'une arête et affiche l'arête
// -------------------------------------------------------
// fichier : le fichier d'entrée
//
void litArete(BufferedReader fichier) {
  try {
    BufferedReader reader;
    reader = fichier;
    coordArete[nbArete][0] = unhex(reader.readLine());
    coordArete[nbArete][1] = int(reader.readLine());
    coordArete[nbArete][2] = int(reader.readLine());
    coordArete[nbArete][3] = int(reader.readLine());
    coordArete[nbArete][4] = int(reader.readLine());
    coordArete[nbArete][5] = int(reader.readLine());
    reader.readLine(); // Ferme la balise
    // afficheArete(coordArete[nbArete][0], coordArete[nbArete][1], coordArete[nbArete][2], coordArete[nbArete][3], coordArete[nbArete][4], coordArete[nbArete][5]);
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

//
// Lit les caractéristiques d'une face et affiche la face
// ------------------------------------------------------
// fichier : le fichier d'entrée
void litEtAfficheFace(BufferedReader fichier) {
  try {
    BufferedReader reader;
    reader = fichier;
    int couleur = unhex(reader.readLine());
    int nbPts = int(reader.readLine());

    coordFace[nbFace][0] = couleur; // Couleur
    coordFace[nbFace][1] = nbPts; // nbPts

    for (int i = 0; i < coordFace[nbFace][1]*2; ++i) {
      coordFace[nbFace][2+i] = int(reader.readLine());
    }

    reader.readLine(); // Ferme la balise
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}

void afficheFaces(){
  for (int i = 0; i < nbFace+1; ++i) {
    fill(coordFace[i][0]);
    beginShape();
    for (int j = 1; j < coordFace[i][1]+1; ++j) {
      vertex(coordFace[i][2*j], coordFace[i][2*j+1]);
    }
    vertex(coordFace[i][2], coordFace[i][3]);
    endShape();
  }
}

//
// dessine le cartouche d'information
//
void afficheInfo() {
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
void litFichier(File selection) {
  // ouverture du fichier
  newFilePath = selection;
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
    afficheSommets();
    afficheAretes();
    afficheFaces();
    afficheInfo();
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}

