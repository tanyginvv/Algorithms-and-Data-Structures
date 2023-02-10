PROGRAM StackQ(INPUT, OUTPUT);{ Таныгин Вадим ПС-23. ABC Pascal.
18. 
Организовать  в  основной  памяти с помощью указателей
стек из очередей. Обеспечить   операции   ведения  очереди из
вершины   стека,   расширения   и  сокращения  стека,  выдачи 
содержимого стека (9)}
USES Crt;
TYPE
  QPtr = ^Ochered;
  Ochered = RECORD
            key: CHAR;
            next: QPtr
          END;
  StackPtr = ^Steck;
  Steck = RECORD
            Key: QPtr;
            Next: StackPtr
          END;
VAR
  TopSt, temp: StackPtr;
  a, Ch: CHAR;
  Str: String;
  EndProg: BOOLEAN;
  TopQ: QPtr;
PROCEDURE AddSt(CurrEl: StackPtr);
VAR
  NewStEl: StackPtr;
BEGIN
  IF CurrEl^.Next <> NIL
  THEN
    AddSt(CurrEl^.Next)
  ELSE
    BEGIN
      New(NewStEl);
      New(NewStEl^.Key);
      NewStEl^.Key^.next := NIL;
      NewStEl^.Key^.key := #0;
      WRITELN('Пустая очередь создана, нажмите "Enter"');
      READLN;
      CurrEl^.Next := NewStEl
    END
END;

PROCEDURE ShowSt(VAR TopSt: StackPtr);
PROCEDURE ShowEl(Q: QPtr);
BEGIN
  IF Q <> NIL
  THEN
    BEGIN
      WRITE(Q^.key);
      IF Q^.next <> NIL
      THEN
        ShowEl(Q^.next);
    END
END;
BEGIN
  IF TopSt <> NIL
  THEN
    BEGIN
      IF TopSt^.Next <> NIL
      THEN
        ShowSt(TopSt^.Next);
        ShowEl(TopSt^.Key);
        WRITELN
    END
  ELSE
    WRITELN('Стек пустой')
END;

PROCEDURE DelSt(VAR TopSt:StackPtr);
VAR
  DelEl: StackPtr;
BEGIN
  IF TopSt <> NIL
  THEN
    BEGIN  
      IF TopSt^.Next <> NIL
      THEN
        DelSt(TopSt^.Next)
      ELSE
        BEGIN
          DelEl := TopSt^.Next;
          TopSt := NIL;
          DISPOSE(DelEl)
        END
    END
  ELSE
    WRITELN('Стек пустой')
END;

PROCEDURE PrintStackMenu;
BEGIN
  WRITELN('1 - Добавить элемент в стек');
  WRITELN('2 - Удалить элемент из стека');
  WRITELN('3 - Показать содержимое стека');
  WRITELN('4 - Работа с очередью');
  WRITELN('5 - Конец программы')
END;

PROCEDURE PrintQueueMenu;
BEGIN
  ClrScr;
  WRITELN('1 - Добавить элемент в очередь');
  WRITELN('2 - Освободить элемент из очереди');
  WRITELN('3 - Показать содержимое очереди');
  WRITELN('4 - Возврат к стеку')
END;

PROCEDURE AddQ(VAR TopQ: Qptr);
VAR
  NewElQ: QPtr;
PROCEDURE Add(VAR CurrEl: QPtr; VAR NewEl: CHAR);
BEGIN
  IF CurrEl^.next <> NIL
  THEN
    Add(CurrEl^.next, NewEl)
  ELSE
    BEGIN
      NEW(NewElQ);
      NewElQ^.key := NewEl;
      NewElQ^.next := NIL;
      CurrEl^.next := NewElQ;
    END
END;
BEGIN
  WRITELN('Введите очередь, нажмите "enter", чтобы продолжить');
  READ(Str);
  READLN;
  IF TopQ = NIL
  THEN
    BEGIN
      NEW(TopQ);
      TopQ^.key := Str[1];
      TopQ^.next := NIL;
      IF length(Str) > 1 
      THEN
        for var i := 1 to length(Str) - 1 do
          Add(TopQ, Str[i]);
    END
    ELSE
      for var i := 1 to length(Str)  do
        Add(TopQ, Str[i]);
END;

PROCEDURE DelQ(VAR TopQ: Qptr);
VAR
  DelEl: QPtr;
BEGIN
  DelEl := TopQ;
  TopQ := TopQ^.next;
  DISPOSE(DelEl);
END;

PROCEDURE ShowQ(VAR TopQ: QPtr);
BEGIN
  WRITE(TopQ^.key);
  IF TopQ^.next <> NIL
  THEN
    BEGIN
      IF TopQ^.next <> NIL
      THEN
        ShowQ(TopQ^.next)
    END
END;

PROCEDURE WorkWithQueue(VAR TopQ: QPtr);
VAR
  EndProc: BOOLEAN;
  a, Ch: CHAR;
BEGIN
  EndProc := TRUE;
  WHILE EndProc
  DO
  BEGIN
    PrintQueueMenu;
    a := READKEY;
    CASE a OF
      '1': AddQ(TopQ);
      '2': IF TopQ <> NIL
           THEN
             DelQ(TopQ)
           ELSE
             BEGIN
               WRITELN('Очередь пустая, добавьте новые элементы');
               WRITELN('Нажмите "Enter", чтобы продолжить');
               READLN
             END;
      '3': BEGIN
             IF TopQ <> NIL
             THEN
               BEGIN
                 ShowQ(TopQ);
                 WRITELN;
                 WRITELN('Нажмите "Enter"');
                 READLN
               END
             ELSE
               BEGIN
                 WRITELN('Очередь пустая, добавьте новый элемент');
                 WRITELN('Нажмите "Enter", чтобы продолжить');
                 READLN
               END;
             WRITELN
            END;
       '4':EndProc := FALSE
    END
  END
END;

BEGIN
  ClrScr;
  NEW(TopSt);
  EndProg := TRUE;
  WHILE EndProg
  DO
    BEGIN
      PrintStackMenu;
      a := READKEY;
      CASE a OF
        '1': IF TopSt <> NIL
             THEN
               AddSt(TopSt)
             ELSE
               BEGIN
                 NEW(TopSt);
                 WRITELN('Пустая очерeдь создана, нажмите "Enter"');
                 READLN;
                 New(TopSt^.Key);
                 TopSt^.Key^.key := #0;
                 TopSt^.Key^.next := NIL;
                 TopSt^.Next := NIL;
               END;
       '2': IF  TopSt <> NIL
            THEN
              DelSt(TopSt)
            ELSE
              BEGIN
                WRITELN('Стек пустой, добавьте новый элемент');
                WRITELN('Нажмите "Enter", чтобы продолжить');
                READLN
              END;
      '3': BEGIN
             ShowSt(TopSt);
             WRITELN;
             WRITELN('Нажмите "ENTER", чтобы продолжить');
             READLN
           END;
      '4': BEGIN
             IF TopSt <> NIL
             THEN
             BEGIN
               IF TopSt^.Next <> NIL
               THEN
               BEGIN
                 temp := TopSt^.Next;
                 WHILE temp^.Next <> NIL
                 DO
                   temp := temp^.Next;
                   WorkWithQueue(temp^.Key)
               END
               ELSE
                 WorkWithQueue(TopSt^.Key)
            END
            ELSE
              BEGIN
                WRITELN('Стек пустой, добавьте новый элемент');
                WRITELN('Нажмите "enter", чтобы продолжить')
              END
            END;
      '5':EndProg := FALSE
    END;
 ClrScr
END
END.