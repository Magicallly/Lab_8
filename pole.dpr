program pole;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

var
  buffer: string;
  bukva: char;
  slovo, task, comment: string;
  is_end, is_okay, contin: boolean;
  score, Len: integer;
  playerNum: integer;
  score1, score2, score3: integer;
  i: integer;
  baraban: integer;

procedure zapolnenie(var slovo_new: string; g: integer);
var
  f: integer;
begin
  Setlength(slovo_new, g);
  for f := 1 to g do
  begin
    slovo_new[f] := '_';
  end;
end;

procedure FileVvod(var sl, com: string);
var
  buff: string;
  inp: textfile;
  n, flag: integer;
begin
  assignfile(inp, 'input.txt');
  reset(inp);
  flag := 0;
  while (not(EOF(inp))) and (flag = 0) do
  begin
    readln(inp, buff);
    randomize;
    flag := random(2);
    n := pos('&', buff);
    sl := copy(buff, 1, n - 1);
    com := copy(buff, n + 1, length(buff) - n);
  end;
  closefile(inp);
end;

procedure ball(var d: integer);

begin

  randomize;
  d := random(221) + 90;
  if d <= 99 then
    writeln('сектор +')
  else if d >= 301 then
    writeln('переход хода')
  else
    writeln('На барабане ', d);

end;

function check(ch: char; buff: string): boolean;
begin
  result := false;
  if (pos(ch, buff) = 0) = false then
    result := true;
end;

procedure openLiter(var slovo1: string; task1: string);
var
  num: integer;
begin
  writeln('Введите номер буквы для открытия');
  readln(num);
  slovo1[num] := task1[num]
end;

begin
  randomize;
  playerNum := random(5) + 1;
  score1 := 0;
  score2 := 0;
  score3 := 0;
  is_end := false;
  FileVvod(task, comment);
  Len := length(task);
  zapolnenie(slovo, Len);

  repeat
    if playerNum > 5 then
      Dec(playerNum, 5);
    contin := false;
    writeln(comment, ': ', slovo, ' (Количество букв: ', Len, ')');
    writeln('Баланс игроков: 1 игрок 2 игрок 3 игрок');
    writeln(score1: 27, score2: 15, score3: 15);

    writeln('Ход ', playerNum, '-го игрока');
    ball(baraban);
    if baraban in [90 .. 99] then
      openLiter(slovo, task)
    else if baraban >= 301 then
    writeln('Пропуск хода')
    else
    begin

      is_okay := false;
      repeat
        writeln('Введите букву');
        readln(bukva);
        bukva := upcase(bukva);
        if (ord(bukva) in [65 .. 90]) and (not(check(bukva, buffer))) then
          is_okay := true;
      until is_okay;
      buffer := buffer + bukva;
      score := 0;
      for i := 1 to Len do
      begin
        if task[i] = bukva then
        begin
          score := score + baraban;
          slovo[i] := bukva;
          contin := true
        end;
      end;

      case playerNum of
        1:
          score1 := score1 + score;
        2:
          score2 := score2 + score;
        3:
          score3 := score3 + score;
      end;
    end;

    if slovo = task then
      is_end := true
    else if not(contin) then
      inc(playerNum);
  until is_end;

  case playerNum of
    1:
      score := score1;
    2:
      score := score2;
    3:
      score := score3;
  end;
  writeln(slovo);
  writeln('Выиграл ', playerNum, ' игрок. Его баланс ', score, ' очков.УРАААААА');

  readln;

end.
