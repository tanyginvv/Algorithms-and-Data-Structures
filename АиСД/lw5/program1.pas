program ShaykerSort;{5. Имеется массив целых чисел. Отсортировать его  на  месте
методом шейкер-сортировки. Удалить повторное вхождение  чисел,
не используя дополнительной памяти (8).
Таныгин Вадим ПС-23 . PascalABC.NET 3.8.3}
CONST 
   X=100;
var
  i,a, temp, k, j,n, arrLength, bump: integer;
  arr : array [1..X] of integer;
  firstIndex, lastIndex : integer;
  input: string;
  Fin: TEXT;
begin
  writeln ('Введите исходный файл с числами');
  readln(input);
  Assign(Fin, input);
  Reset(Fin);
  i:=1;
  While not eof(Fin) do begin
    Readln(Fin,a);
    arr[i] := a;
    i:= i+1
  end;
  writeln;
  arrLength:= i;
  firstIndex := 1; 
  lastIndex := arrLength; 
  while firstIndex < lastIndex do
  begin
    for i:= firstIndex to lastIndex-1 do
      if arr[i] > arr[i+1] then
      begin
        temp := arr[i];
        arr[i] := arr[i+1];
        arr[i+1] := temp;
      end;
    for i:= lastIndex downto firstIndex+1 do
      if arr[i] < arr[i-1] then
      begin
        temp := arr[i];
        arr[i] := arr[i-1];
        arr[i-1] := temp;
      end;

    firstIndex := firstIndex + 1;
    lastIndex := lastIndex - 1;
  end;
  n:= arrLength;
  i:= 1;
  bump:=0;
 while i<=n do
 begin
  j:=i+1;
  while j<=n do
   begin
    if arr[j]=arr[i] then
     begin
      for k:=j to n-1 do
      arr[k]:=arr[k+1];
      n:=n-1;
      end
     else j:=j+1;
   end;
  i:=i+1;
 end;  
 arrLength:= n ;
  writeln('Отсортированный список: ');
  for i:= 2  to arrLength do
    write (arr[i], ' ');
end.