program TreeProc;{ Таныгин Вадим ПС-23. PascalAbc 3.8.3
15.Имеется  дерево  вызовов  процедур некоторой программы.
Структура программы такова,  что каждая  вызываемая  процедура
вложена в вызывающую ее процедуру. Задан объем памяти, который
требуется  для  загрузки  каждой  процедуры.  При  выходе   из
процедуры  занимаемая ей память освобождается.  Известно,  что
вызов процедур  при  работе  программы  соответствовал  обходу
дерева  в  порядке  сверху вниз.  Дать трассировку программы в
виде списка вызываемых процедур.  Процедура должна попадать  в
список, если к ней произошло обращение из вызывающей процедуры
либо возврат управления из вызванной ей  процедуры. Определить
размер  памяти,  необходимый  для работы программы,  и цепочку
вызовов, требующую максимальной памяти (11)}
uses crt;
label m, s, t;
type
  Tree = ^TreeType;
  TreeType = RECORD
    left, right, fath: Tree;
    urov, ram: INTEGER;
    ProcName: STRING
  END;

var
  root: Tree;
  FIn, FInRam, FOut: TEXT;
  Input1, Input2: STRING;
  Ch: CHAR;

procedure PrintMenu;
begin
  WRITELN('1-Печать дерева на экране');
  WRITELN('2-Распечатать трассирову и необходимый размер памяти');
  WRITELN('3-выберите другой файл с оперативной памятью');
  WRITELN('4-выберите другой файл с деревом');
  WRITELN('5-выход из программы');
end;

procedure ReadTree(var F: text; var ro: Tree);
var
  i, m, k, Len: integer;
  R, S: string;   {для формирования строки выдачи}
  p, t, kon: Tree;
begin
  while not Eof(F) do
  begin
    ReadLn(F, S);
    k := 0;
    Len := Length(S);
    while S[k + 1] = '.' do k := k + 1;  
      {k - уровень вершины, начиная с 0}
    R := Copy(S, k + 1, Len - k);         
      {имя вершины без точек}
    New(kon);
    kon^.ProcName := R;
    kon^.left := nil;
    kon^.right := nil;
    kon^.urov := k;
    if k = 0 then             {нулевой уровень - корень}
    begin
      ro := kon;       {корень - для возврата в вызывающую}
      kon^.fath := nil;
      m := 0;            {уровень предыдущей вершины}
      t := kon;          {указатель на предыдущую вершину }
      continue;
    end;
    if k > m then       {переход на следующий уровень}
    begin
      t^.left := kon;
      kon^.fath := t;
    end
      else                    { k<>0 и k<=m }
    if k = m then     { уровень, как у предыдущей}
    begin
      t^.right := kon;
      kon^.fath := t^.fath;         {отец тот же, что у брата}
    end
        else                  { k < m - подъем по дереву на m-k уровней }
    begin
      p := t;
      for i := 1 to m - k do
        p := p^.fath;
            { p-предыдущая вершина того же уровня }
      kon^.fath := p^.fath; 
            { отец в исходном дереве тот же, что у брата }
      p^.right := kon;
    end;
    m := k;        { запомнили текущий уровень }
    t := kon;      {для работы со следующей вершиной}
  end;              {конец While}
end;

procedure AddRam(var root: Tree; var name: string; var Ram: Integer);
begin
  if root <> nil
  then
  begin
    if root^.ProcName = name
      then
    begin
      root^.ram := Ram
    end
    else
      AddRam(root^.left, name, Ram);
    AddRam(root^.right, name, Ram)
  end;
end;

procedure ReadRam(var F: text; var root: Tree);
var
  Ram: integer;
  name: string;
  Ch: CHAR;
begin
  while not eof(F)
  do
  begin
    Read(F, Ch);
    name := '';
    while Ch <> ' '
      do
    begin
      name := name + Ch;
      READ(F, Ch);
    end;
    READLN(F, Ram);
    AddRam(root, name, Ram)
  end;
end;

procedure PrintTree(var t: Tree);
{выдача в файл в порядке сверху вниз}
var
  p: Tree;
  j: integer;
  St: string;{для формирования строки выдачи}
begin
  if t <> nil then
  begin
    St := t^.ProcName;
    p := t;
    for j := 1 to t^.urov do  {отступ в зависимости от уровня}
    begin
      p := p^.fath;
      St := '.' + St;
    end;
    WriteLn(St);
    PrintTree(t^.left);
    PrintTree(t^.right);
  end
end;

procedure PreRam(root: Tree; var Chain: string; var ChainRam: integer; var MaxChain: string; var MaxChainRam: integer);
begin
  Chain := Chain + '-' + root^.ProcName;
  ChainRam := ChainRam + root^.ram;
  if root^.left <> nil
  THEN
  begin
    root := root^.left;
    PreRam(root, Chain, ChainRam, MaxChain, MaxChainRam);
  end
  ELSE
  begin
    WRITELN(ChainRam, ' ', Chain);
    if MaxChainRam < ChainRam
      THEN
    begin
      MaxChainRam := ChainRam;
      MaxChain := Chain
    end;
    ChainRam := ChainRam - root^.ram;
    DELETE(Chain, LENGTH(Chain) - LENGTH(root^.ProcName), LENGTH(root^.ProcName) + 1);
    while root^.right <> nil
      DO
    begin
      root := root^.right;
      if (root^.left <> nil) AND (root^.right = nil)
          THEN
      begin
        PreRam(root, Chain, ChainRam, MaxChain, MaxChainRam);
        DELETE(Chain, LENGTH(Chain) - LENGTH(root^.ProcName), LENGTH(root^.ProcName) + 1);
        ChainRam := ChainRam - root^.ram
      end
      ELSE
        PreRam(root, Chain, ChainRam, MaxChain, MaxChainRam)
    end
  end;
end;

procedure CalculateRam(root: Tree);
var
  MaxChain, Chain: STRING;
  MaxChainRam, ChainRam: INTEGER;
begin
  MaxChainRam := 0;
  Chain := root^.ProcName;
  ChainRam := root^.ram;
  root := root^.left;
  PreRam(root, Chain, ChainRam, MaxChain, MaxChainRam);
  DELETE(Chain, LENGTH(Chain) - LENGTH(root^.ProcName), LENGTH(root^.ProcName) + 1);
  ChainRam := ChainRam - root^.ram;
  if root^.right <> nil
  then
  begin
    root := root^.right;
    PreRam(root, Chain, ChainRam, MaxChain, MaxChainRam);
    DELETE(Chain, LENGTH(Chain) - LENGTH(root^.ProcName), LENGTH(root^.ProcName) + 1);
    ChainRam := ChainRam - root^.ram
  end;
  WRITELN('Самая длинная цепочка вызовов - ', MaxChain);
  WRITELN('Максимальная оперативная память - ', MaxChainRam)
end;


procedure PrintTras(root: Tree);
begin
  if root <> nil then
  begin
    write(root^.ProcName, ' ');
    PrintTras(root^.left);
    if root^.fath <> nil then
      write(root^.fath^.ProcName, ' ');
    PrintTras(root^.right);
  end;
end;

procedure CleanTree(var root: Tree);
begin
  if root <> nil
  THEN 
  begin
    CleanTree(root^.Left);
    CleanTree(root^.Right);
    DISPOSE(root);
    root := nil
  end
end;

begin
  t: WRITE('Введите исходный файл с деревом:(exit-выход из программы) ');
  READln(Input1);
  if Input1 = 'exit'
      then
    exit;
  Assign(FIn, Input1);
  RESET(FIn);
  if not EOF(FIn)
      then
  begin
    ReadTree(FIn, root);
    m: WRITE('Введите файл, содержащий оперативную память:');
    READln(Input2);
    Assign(FInRam, Input2);
    RESET(FInRam);
    if not eof(FInRam)
          then 
    begin
      ReadRam(FInRam, root);
      s: PrintMenu;
      ReadLn(Ch);
      read;
      case Ch of
        '1':
          begin
            PrintTree(root);
            goto s
          end;                 
        '2':
          begin
            PrintTras(root);
            WRITELN;
            CalculateRam(root);
            goto s
          end;
        '3': goto m;
        '4':
          begin
            CleanTree(root);
            goto t
          end;
        '5': exit;
      end;
    end
         else
    begin
      WRITELN('файл с оперативной памятью пустой');
      goto m
    end
  end
     else
  begin
    writeln('файл с деревом пустой');
    goto t
  end;
end.
