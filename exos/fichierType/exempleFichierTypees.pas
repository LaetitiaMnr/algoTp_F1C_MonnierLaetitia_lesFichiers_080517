program FichierType; //Laetitia Monnier

uses crt;

CONST 
	MAX = 3;

VAR
	f : file of integer;
	score, compteur : integer;
	resultat : array[1..MAX] of integer;

BEGIN
	clrscr;
	Assign(f, 'score.txt');
	rewrite(f); //Crée un fichier s'il est inexistant.
	writeln('Entrez votre score / 000 pour sortir');
	REPEAT
		read(score);
		write(f, score);
		GOTOXY(1,2);
		write('               ');
		GOTOXY(1,2);
	UNTIL score = 000;
	seek(f,0); //Position courante que l'on place à la position 0.
	BlockRead(f, resultat, MAX); //Cette procedure permet une lecture à l'intérieur du fichier. On va prendre dans le fichier les 3 premiers score que l'on va stocker dans un tableau (resultat).
	FOR compteur := 1 TO MAX DO
		writeln(resultat[compteur]);
	readln;
	close(f); //On ferme le fichier.
	readln;
END.

