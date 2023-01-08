:- dynamic(piece/4).

gets(S) :- get0(C), gets([], C, S).
gets(S, 10, S).		% 10 é o newline
gets(S, -1, S).		% -1 é o end-of-file
gets(I, C, [C|O]) :- get0(CC), gets(I, CC, O).

% Incializar o tabuleiro
init_board :-
    retractall(piece(_, _, _, _)),
    assertz((piece('P', w, a, 2))),
    assertz((piece('P', w, b, 2))),
    assertz((piece('P', w, c, 2))),
    assertz((piece('P', w, d, 2))),
    assertz((piece('P', w, e, 2))),
    assertz((piece('P', w, f, 2))),
    assertz((piece('P', w, g, 2))),
    assertz((piece('P', w, h, 2))),
    assertz((piece('R', w, a, 1))),
    assertz((piece('R', w, h, 1))),
    assertz((piece('N', w, b, 1))),
    assertz((piece('N', w, g, 1))),
    assertz((piece('B', w, c, 1))),
    assertz((piece('B', w, f, 1))),
    assertz((piece('Q', w, d, 1))),
    assertz((piece('K', w, e, 1))),
    assertz((piece('P', b, a, 7))),
    assertz((piece('P', b, b, 7))),
    assertz((piece('P', b, c, 7))),
    assertz((piece('P', b, d, 7))),
    assertz((piece('P', b, e, 7))),
    assertz((piece('P', b, f, 7))),
    assertz((piece('P', b, g, 7))),
    assertz((piece('P', b, h, 7))),
    assertz((piece('R', b, a, 8))),
    assertz((piece('R', b, h, 8))),
    assertz((piece('N', b, b, 8))),
    assertz((piece('N', b, g, 8))),
    assertz((piece('B', b, c, 8))),
    assertz((piece('B', b, f, 8))),
    assertz((piece('Q', b, d, 8))),
    assertz((piece('K', b, e, 8))).

print_board :-
    forall(between(1, 8, Y), (line(Y, Y1), write(Y1), print_row(Y1))), write('  a  b  c  d  e  f  g  h'), nl.

print_row(Y) :-
    write(' '),
    forall(between(1, 8, X), (print_square(X, Y), write(' '))),
    nl.

print_square(X, Y) :-
    % Verifica se há uma peça num quadrado
    piece(Type, Color, Column, Row),
    % Verifica se as coordenadas da peça correspondem a coordenadas do square
    column_number(Column, X),
    Row = Y,
    % Print da peça (cor e tipo), por exemplo: peeão branco = wP
    write(Color), write(Type).
    
print_square(_, _) :-
    % Se não existir nenhuma peça no square dá print de #
    write(' #').
    
% Converte o caractere de uma coluna para um número
column_number(a, 1).
column_number(b, 2).
column_number(c, 3).
column_number(d, 4).
column_number(e, 5).
column_number(f, 6).
column_number(g, 7).
column_number(h, 8).

%Converte o numero da linha para printar o board de forma correta
line(1, 8).
line(2, 7).
line(3, 6).
line(4, 5).
line(5, 4).
line(6, 3).
line(7, 2).
line(8, 1).

showMove(Color, Play) :-
    Play = 'white_wins', endOfGame(Play);
    Play = 'black_wins', endOfGame(Play);
    Play = 'draw', endOfGame(Play);
    Color = w, print('brancas  -> '), print(Play);
    Color = b, print('pretas -> '), print(Play); true.

inCheck(Color, check) :-
    Color = w, print(' Blacks in Check'), nl;
    Color = b, print(' Whites in Check'), nl.

inCheck(Color, checkmate) :-
    Color = w, print('Blacks in checkmate'), nl, endOfGame('Whites Win');
    Color = b, print('Whites in checkmate'), nl, endOfGame('Blacks Win').

endOfGame(A) :-
    A = 'white_wins', print(A), nl,print_board , abort;
    A = 'black_wins', print(A), nl, print_board, abort;
    A = 'draw', print(A), nl, print_board, abort;
    true.

% Lê o ficheiro com as jogadas
read_moves(File) :-
    % Abre o ficheiro
    open(File, read, Stream),
    % Lê a primeira linha do ficheiro
    set_input(Stream),
    read_line(jogada(WhiteMove, BlackMove)),
    % Escreve a jogada branca, faz update do tabuleiro e print do tabuleiro
    showMove(w, WhiteMove), nl,
    update_board(w, WhiteMove),
    print_board,
    nl,
    % Escreve a jogada preta, faz update do tabuleiro e print do tabuleiro
    showMove(b, BlackMove), nl,
    update_board(b, BlackMove),
    print_board,
    nl,
    % Lê o resto do ficheiro
    read_moves.

% Lê o resto do ficheiro
read_moves :-
    % Lê a próxima linha da stream
    read_line(jogada(WhiteMove, BlackMove)),
    % Escreve a jogada branca, faz update do tabuleiro e print do tabuleiro
    showMove(w, WhiteMove), nl,
    update_board(w, WhiteMove),
    print_board,
    nl,
    % Escreve a jogada preta, faz update do tabuleiro e print do tabuleiro
    showMove(b, BlackMove), nl,
    update_board(b, BlackMove),
    print_board,
    nl,
    % Continua a lero resto do ficheiro
    read_moves.

% Lê a linha do ficheiro
read_line(X) :-
    % Lê a linha da stream
    gets(Line),
    % Separa a linha lida em joagada branca e jogada preta através da gramática
    phrase(expr(X), Line, []).

% Main
play(Filename) :-
    init_board,
    print_board,
    read_moves(Filename).