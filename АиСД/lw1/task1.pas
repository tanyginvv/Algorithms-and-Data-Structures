PROGRAM Task1;      {Dev Gnu Pascal Таныгин Вадим пс-23. Условие: 9. Некоторый текст состоит из нескольких частей,
записанных отдельных файлах.  Имена этих файлов и общий заголовок текста указаны в отдельных файлах.
Создать файл с полным текстом.Заголовок должен содержаться в центре первой строки}
VAR
  F, F1, F2: TEXT;
  Fn1, Fn2, Fn, S: STRING;
  Count, I: INTEGER;
BEGIN
  WRITELN('Введите название входного и выходного файла:');
  READLN(Fn1);
  READLN(Fn2);
  ASSIGN(F1, Fn1);
  RESET(F1);
  IF IOResult <> 0 
  THEN
    BEGIN
      WRITELN(' Не удалось открыть входной файл ');
    END;
  ASSIGN(F2, Fn2);
  REWRITE(F2);
  IF IOResult <> 0 
  THEN
    BEGIN
      WRITELN(' Не удалось открыть выходной файл ');
    END;
  IF NOT EOF(F1) {Чтение и запись заголовка}
  THEN
    BEGIN
      READLN(F1, S);
      FOR I := 1 TO (80 - LENGTH(S)) DIV 2{Добавляем пробелы перед заголовком, для расположения в центре, пусть строка - 80 символов}
      DO
        WRITE(F2, ' ');
      WRITELN(F2, S);
      WRITELN(F2);
    END;
  Count := 0; {Порядковый номер файла в списке.}
  WHILE NOT EOF(F1) 
  DO
    BEGIN
      READLN(F1, Fn); {Читаем имя очередного файла.}
      IF Fn = '' 
      THEN
       Continue; {Пропускаем пустые строки.}
      Inc(Count);
      IF Count > 1 
      THEN 
        WRITELN(F2); {Содержимое файлов разделяем переводом строки.}
      ASSIGN(F, Fn);
      RESET(F);
      IF IOResult <> 0 
      THEN
        BEGIN
          WRITELN(F2, ' Не удалось открыть файл: "', Fn, '"');
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
  {Закрытие файлов}
  Close(F1);
  Close(F2)
END.
