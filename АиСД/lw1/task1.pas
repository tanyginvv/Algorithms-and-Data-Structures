PROGRAM Task1;      {Dev Gnu Pascal ������� ����� ��-23. �������: 9. ��������� ����� ������� �� ���������� ������,
���������� ��������� ������.  ����� ���� ������ � ����� ��������� ������ ������� � ��������� ������.
������� ���� � ������ �������.��������� ������ ����������� � ������ ������ ������}
VAR
  F, F1, F2: TEXT;
  Fn1, Fn2, Fn, S: STRING;
  Count, I: INTEGER;
BEGIN
  WRITELN('������� �������� �������� � ��������� �����:');
  READLN(Fn1);
  READLN(Fn2);
  ASSIGN(F1, Fn1);
  RESET(F1);
  IF IOResult <> 0 
  THEN
    BEGIN
      WRITELN(' �� ������� ������� ������� ���� ');
    END;
  ASSIGN(F2, Fn2);
  REWRITE(F2);
  IF IOResult <> 0 
  THEN
    BEGIN
      WRITELN(' �� ������� ������� �������� ���� ');
    END;
  IF NOT EOF(F1) {������ � ������ ���������}
  THEN
    BEGIN
      READLN(F1, S);
      FOR I := 1 TO (80 - LENGTH(S)) DIV 2{��������� ������� ����� ����������, ��� ������������ � ������, ����� ������ - 80 ��������}
      DO
        WRITE(F2, ' ');
      WRITELN(F2, S);
      WRITELN(F2);
    END;
  Count := 0; {���������� ����� ����� � ������.}
  WHILE NOT EOF(F1) 
  DO
    BEGIN
      READLN(F1, Fn); {������ ��� ���������� �����.}
      IF Fn = '' 
      THEN
       Continue; {���������� ������ ������.}
      Inc(Count);
      IF Count > 1 
      THEN 
        WRITELN(F2); {���������� ������ ��������� ��������� ������.}
      ASSIGN(F, Fn);
      RESET(F);
      IF IOResult <> 0 
      THEN
        BEGIN
          WRITELN(F2, ' �� ������� ������� ����: "', Fn, '"');
          Continue
        END;
    WHILE NOT EOF(F)
    DO
      BEGIN
        READ(F, S);
        WRITE(F2, S);
        IF EOLN(F) AND NOT EOF(F)
        THEN
          BEGIN
            READLN(F);
            WRITELN(F2)
          END;
      END;
    Close(F)
  END;
  {�������� ������}
  Close(F1);
  Close(F2)
END.
