program FichierTexte; //Laetitia Monnier

uses crt;

TYPE 
	client = record
		nom : string;
		prenom : string;
		adresse : string;
		cp : string;
		ville : string;
end;

//BUT: L'utilisateur entre ses renseignements.
PROCEDURE renseignement(var XClient : client; var f : TextFile);
begin 
	writeln('Entrez votre nom.');
	readln(XClient.nom);
	XClient.nom := upCase(XClient.nom);
	writeln(f,XClient.nom);
	writeln('Entrez votre prenom.');
	readln(XClient.prenom);
	XClient.prenom := upCase(XClient.prenom);
	writeln(f,XClient.prenom);
	writeln('Entrez votre adresse.');
	readln(XClient.adresse);
	writeln(f,XClient.adresse);
	writeln('Entrez votre code postal.');
	readln(XClient.cp);
	XClient.cp := copy(XClient.cp,1,5);
	writeln(f,XClient.cp);
	writeln('Entrez le nom de votre ville.');
	readln(XClient.ville);
	XClient.ville := upCase(XClient.ville);
	writeln(f,XClient.ville);
	writeln(f,' ');
end;

//BUT: Si le fichier existe déjà et qu'on veut le modifier afin d'ajouter de nouvelles données.
PROCEDURE modifier(var XClient : client; var f : TextFile);
begin
	{$I-}
	append(f);
	{$I+}
	IF IOResult <> 0 THEN
		rewrite(f);
	renseignement(XClient, f);
	close(f);
end;

//Procedure affichant le menu.
PROCEDURE menu();
begin 
	writeln('-- Fiche de Renseignement Client --');
    writeln('1 : Inscription.');
    writeln('2 : Afficher la liste renseignement client.');
    writeln('0 : Sortir !');
end;


//BUT: Eviter que le programme ne se ferme.
//Si un utilisateur veut afficher le contenu d'un fichier inexistant, un message d'erreur apparaitra afin d'éviter un quelconque 'exit code'.
//En revanche, si le fichier existe déjà, l'utilisateur sera en mesure de regarder le contenu du fichier.
PROCEDURE affichage(var f : TextFile);
VAR
	s : string;
begin
	{$I-}
	Reset(f);
	{$I+}
	If IOResult <> 0 Then
	begin
		writeln('Une erreur s''est produite avec le fichier.');
	end
	else
	begin
		while not Eof(f) do
		begin
			ReadLn(f,s);
			WriteLn(s);
		end;
		close(f);
	end; 
end;


//BUT: Purement esthétique.
//Le pointeur revient à la 5eme ligne de l'écran. 
PROCEDURE effaceEcran();
VAR
	compteur : integer;
begin
	GOTOXY(1, 5);
	FOR compteur := 1 TO 12 DO
		writeln('                                       ');
	GOTOXY(1, 5);
end;

// Programme Principal

VAR
	XClient : client;
	f : TextFile;
	choix : integer;

BEGIN
	clrscr;
	Assign(f, 'FicheClient.txt');
	menu();
    REPEAT
	    readln(choix);
	    IF choix = 1 THEN
	    	modifier(XClient, f);
		effaceEcran();
	UNTIL (choix = 2) OR (choix = 0);
	IF choix = 2 THEN
	begin
		writeln;
		affichage(f);
		writeln;
	end
	ELSE IF choix = 0 THEN
		writeln('Exit');
	readln;
END.

