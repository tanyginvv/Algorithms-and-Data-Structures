PROGRAM Algor_Floid(INPUT, OUTPUT);
USES CRT;
{ 16. Реализовать алгоритм поиска кратчайших путей  Флойда  и
проиллюстрировать по шагам этапы его выполнения (9).
   Таныгин Вадим ПС-23
    PascalABC.NET 3.8.3
}

TYPE 
  matr=ARRAY[.] OF STRING;
  matrPos = ARRAY[.] OF INTEGER;
VAR 
  i, j, vertNum, startW, endW: INTEGER;
  Graf: matr;
  GrafPos: matrPos;
  Fin, Fout: TEXT;
  STOP, stopGr: BOOLEAN;
  p, stopAll, stopWay: CHAR;
  Inp, Out: STRING;
  
  
Procedure MinWay(Graf: matr; GrafPos: matrPos; startW, endW: INTEGER);
VAR
  endWi, i: INTEGER;
  wayStr: STRING;
BEGIN
  IF Graf[startW, endW] <> '*'
  THEN
    BEGIN
      wayStr := '';
      WRITELN('Минимальный путь = ', Graf[startW, endW]);
      WRITE('Путь: ', startW, '-');
      endWi := endW;
      WHILE (GrafPos[startW, endW] <> endW) AND (GrafPos[startW, endW] <> endWi)
      DO
        BEGIN
          wayStr := wayStr + GrafPos[startW, endW]; 
          endW := GrafPos[startW, endW];
        END;
      IF wayStr <> ''
      THEN
        BEGIN
          i := length(wayStr);
          WHILE i > 0
          DO
            BEGIN
              WRITE(wayStr[i], '-');
              i := i - 1
            END
        END;
      WRITELN(endWi)
    END
  ELSE
    WRITELN('Нет ', startW, '-', endW, ' пути') 
END;


Procedure Floid(Graf: matr; GrafPos: matrPos; V: INTEGER);
VAR 
  k, i, j, int, int1, int2, int3, Code: INTEGER;
BEGIN
  FOR i := 1 TO V 
  DO 
    Graf[i, i] := '0';
  FOR k := 1 TO V 
  DO
    BEGIN
      FOR i := 1 TO V 
      DO
        FOR j := 1 TO V 
        DO
          IF (Graf[i, k] <> '*') AND (Graf[k, j] <> '*') AND (i <> j) 
          THEN
            BEGIN
              VAL(Graf[i, k], int1, Code);
              VAL(Graf[k, j], int2, Code);
              VAL(Graf[i, j], int3, Code);
              IF ((int1 + int2) < int3) OR (Graf[i, j] = '*') 
              THEN
                BEGIN
                  VAL(Graf[i, j], int, Code);
                  STR((int1 + int2), Graf[i, j]);
                  VAL(Graf[i, j], int3, Code);
                  IF int <> int3
                  THEN
                    GrafPos[i, j] := k
                END
            END;
      WRITELN('Шаг № ', k);
      FOR i:=1 TO V 
      DO
        BEGIN
         FOR j:=1 TO V 
         DO
           WRITE('   ', Graf[i, j]);
         WRITE('    |  ');
         FOR j:=1 TO V 
         DO
            WRITE(GrafPos[i, j]:4);
           WRITELN
        END
    END;
    
  WRITELN(Fout, 'Матрица кратчайших путей:');
  FOR i:=1 TO V 
  DO
  BEGIN
    FOR j:=1 TO V 
    DO
      WRITE(Fout, Graf[i, j]:4);
    WRITELN(Fout)
  END
END;


BEGIN
  clrscr;
  STOP := false;
  WHILE NOT STOP
  DO
    BEGIN
      stop := true;
      WRITELN('Введите имя входного файла: ');
      READLN(Inp);
      WRITELN('Введите имя выходного файла: ');
      READLN(Out);
      Assign(Fin, Inp);
      Assign(Fout, Out);
      Reset(Fin);
      Rewrite(Fout);
      READLN(Fin, vertNum);
      Graf := new string[vertNum+1, vertNum+1];
      GrafPos := new integer[vertNum+1, vertNum+1];
      FOR i:=1 TO vertNum 
      DO
        FOR j:=1 TO vertNum 
        DO
          BEGIN
            Graf[i, j] := '*';
            GrafPos[i, j] := 0;
            IF i = j
            THEN
              GrafPos[i, j] := i
          END;
      WHILE NOT EOF(Fin)
      DO
        BEGIN
         READ(Fin, i);
         READ(Fin, p); 
         READ(Fin, j);
         READ(Fin, p);
         READ(Fin, Graf[i, j]);
         GrafPos[i, j] := j;
       END;
      Floid(Graf, GrafPos, vertNum);
      stopGr := false;
      WHILE NOT stopGr
      DO
        BEGIN
          stopGr := true;    
          WRITELN('Введите начальную вершину: ');
          READLN(startW);
          WRITELN('Введите конечную вершину: ');
          READLN(endW);
          MinWay(Graf, GrafPos, startW, endW);    
          WRITELN('Если вы хотите повторить поиск минимального пути, напишите R. Если вы хотите выйти, нажмите enter: ');
          READLN(stopWay);
          IF stopWay = 'R'
          THEN
            stopGr := false
        END; 
     CLOSE(Fin);
     CLOSE(Fout);
     WRITELN('Если вы хотите повторить вставку матриц, напишите R. Если вы хотите выйти, нажмите enter: ');
     READLN(stopAll);
     IF stopAll = 'R'
     THEN
       STOP := false
   END
END.
