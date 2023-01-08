constraint_pawn(Color, ToColumnChar, ToRowInt, FromRowInt):-
    Color = w,
    piece('P', Color, ToColumnChar, FromRowInt),
    FromRowInt #= 2,
    ToRowInt - FromRowInt =<2;

    Color = w, 
    piece('P', Color, ToColumnChar, FromRowInt),
    FromRowInt #\= 2,
    ToRowInt - FromRowInt #=1;

    Color = b, 
    piece('P', Color, ToColumnChar, FromRowInt),
    FromRowInt #= 7,
    FromRowInt - ToRowInt =< 2;

    Color = b,
    piece('P', Color, ToColumnChar, FromRowInt),
    FromRowInt #= 7,
    FromRowInt - ToRowInt #= 1.

constraint_knight(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt):-
    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt + 1, FromRowInt is ToRowInt - 2,
    column_number(FromColumnChar, FromColumnInt), piece('N', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt - 1, FromRowInt is ToRowInt - 2,
    column_number(FromColumnChar, FromColumnInt), piece('N', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt - 2, FromRowInt is ToRowInt - 1,
    column_number(FromColumnChar, FromColumnInt), piece('N', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt - 2, FromRowInt is ToRowInt + 1,
    column_number(FromColumnChar, FromColumnInt), piece('N', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt - 1, FromRowInt is ToRowInt + 2,
    column_number(FromColumnChar, FromColumnInt), piece('N', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt + 1, FromRowInt is ToRowInt + 2,
    column_number(FromColumnChar, FromColumnInt), piece('N', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt + 2, FromRowInt is ToRowInt + 1,
    column_number(FromColumnChar, FromColumnInt), piece('N', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt + 2, FromRowInt is ToRowInt - 1,
    column_number(FromColumnChar, FromColumnInt), piece('N', Color, FromColumnChar, FromRowInt).

diagonal_direita_cima(Color, P, CF, LF, CI, LI) :-
    column_number(CF, CFInt), CFIntI is CFInt - 1, column_number(CI, CFIntI), LI is LF - 1,
    piece(P, Color, CI, LI);

    column_number(CF, CFInt), CFIntI is CFInt - 1, column_number(CFF, CFIntI), LFF is LF - 1,
    diagonal_direita_cima(Color, P, CFF, LFF, CI, LI).

diagonal_direita_baixo(Color, P, CF, LF, CI, LI) :-
    column_number(CF, CFInt), CFIntI is CFInt - 1, column_number(CI, CFIntI), LI is LF + 1,
    piece(P, Color, CI, LI);

    column_number(CF, CFInt), CFIntI is CFInt - 1, column_number(CFF, CFIntI), LFF is LF + 1,
    diagonal_direita_baixo(Color, P, CFF, LFF, CI, LI).

diagonal_esquerda_cima(Color, P, CF, LF, CI, LI) :-
    column_number(CF, CFInt), CFIntI is CFInt + 1, column_number(CI, CFIntI), LI is LF - 1,
    piece(P, Color, CI, LI);

    column_number(CF, CFInt), CFIntI is CFInt + 1, column_number(CFF, CFIntI), LFF is LF - 1,
    diagonal_esquerda_cima(Color, P, CFF, LFF, CI, LI).

diagonal_esquerda_baixo(Color, P, CF, LF, CI, LI) :-
    column_number(CF, CFInt), CFIntI is CFInt + 1, column_number(CI, CFIntI), LI is LF + 1,
    piece(P, Color, CI, LI);

    column_number(CF, CFInt), CFIntI is CFInt + 1, column_number(CFF, CFIntI), LFF is LF + 1,
    diagonal_esquerda_baixo(Color, P, CFF, LFF, CI, LI).

constraint_bishop(Color,Piece, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt):-
    diagonal_direita_cima(Color, Piece, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt);
    diagonal_direita_baixo(Color, Piece, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt);
    diagonal_esquerda_cima(Color, Piece, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt);
    diagonal_esquerda_baixo(Color, Piece, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt).
    
constraint_bishop_takes(Color, P, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt) :-
    Color = w, constraint_bishop(Color, P, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, b, ToColumnChar, ToRowInt);

    Color = b, constraint_bishop(Color, P, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, w, ToColumnChar, ToRowInt).

constraint_king(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt):-
    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt - 1, FromRowInt is ToRowInt + 1,
    column_number(FromColumnChar, FromColumnInt),
    piece('K', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt, FromRowInt is ToRowInt + 1,
    column_number(FromColumnChar, FromColumnInt),
    piece('K', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt + 1, FromRowInt is ToRowInt + 1,
    column_number(FromColumnChar, FromColumnInt),
    piece('K', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt + 1, FromRowInt is ToRowInt,
    column_number(FromColumnChar, FromColumnInt),
    piece('K', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt + 1, FromRowInt is ToRowInt - 1,
    column_number(FromColumnChar, FromColumnInt),
    piece('K', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt , FromRowInt is ToRowInt - 1,
    column_number(FromColumnChar, FromColumnInt),
    piece('K', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt - 1, FromRowInt is ToRowInt - 1,
    column_number(FromColumnChar, FromColumnInt),
    piece('K', Color, FromColumnChar, FromRowInt);

    column_number(ToColumnChar, ToColumnInt),
    FromColumnInt is ToColumnInt - 1, FromRowInt is ToRowInt,
    column_number(FromColumnChar, FromColumnInt),
    piece('K', Color, FromColumnChar, FromRowInt).
    
    
constraint_kingside_castle(Color) :-
    Color = w,
    % rei em e1 e torre em h1, f1 e g1 estão vazios,
    piece('K', Color, e, 1), piece('R', Color, h, 1), \+ piece(_, _, f, 1), \+ piece(_, _, g, 1);
    
    Color = b,
    % rei em e8 e torre em h8, f8 e g8 estão vazios 
    piece('K', Color, e, 8), piece('R', Color, h, 8), \+ piece(_, _, f, 8), \+ piece(_, _, g, 8).

constraint_queenside_castle(Color) :-
    Color = w,
    % rei em e1 e torre em a1, b1, c1 e d1 estão vazios,
    piece('K', Color, e, 1), piece('R', Color, a, 1), \+ piece(_, _, b, 1), \+ piece(_, _, c, 1), \+ piece(_, _, d, 1);
    
    Color = b,
    % rei em e8 e torre em a8, b8, c8 e d8 estão vazios 
    piece('K', Color, e, 8), piece('R', Color, a, 8), \+ piece(_, _, b, 8), \+ piece(_, _, c, 8), \+ piece(_, _, d, 8).

constraint_pawn_takes(Color, FromColumnChar, ToColumnChar, ToRowInt, FromRowInt) :-
    Color = w, piece('P', Color, FromColumnChar, FromRowInt), \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, b, ToColumnChar, ToRowInt),
    column_number(ToColumnChar, ToColumnInt), FromColumnInt is ToColumnInt - 1, column_number(FromColumnChar, FromColumnInt),
    FromRowInt #= ToRowInt - 1;

    Color = w, piece('P', Color, FromColumnChar, FromRowInt), \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, b, ToColumnChar, ToRowInt),
    column_number(ToColumnChar, ToColumnInt), FromColumnInt is ToColumnInt + 1, column_number(FromColumnChar, FromColumnInt),
    FromRowInt #= ToRowInt - 1;

    Color = b, piece('P', Color, FromColumnChar, FromRowInt), \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, w, ToColumnChar, ToRowInt),
    column_number(ToColumnChar, ToColumnInt), FromColumnInt is ToColumnInt - 1, column_number(FromColumnChar, FromColumnInt),
    FromRowInt #= ToRowInt + 1;

    Color = b, piece('P', Color, FromColumnChar, FromRowInt), \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, w, ToColumnChar, ToRowInt),
    column_number(ToColumnChar, ToColumnInt), FromColumnInt is ToColumnInt + 1, column_number(FromColumnChar, FromColumnInt),
    FromRowInt #= ToRowInt + 1.

constraint_knight_takes(Color, ToColumn, ToRow, FromColumnChar, FromRowInt) :-
    Color = w,
    constraint_knight(Color, ToColumn, ToRow, FromColumnChar, FromRowInt),
    \+ piece('K', b, ToColumn, ToRow), piece(_, b, ToColumn, ToRow);

    Color = b,
    constraint_knight(Color, ToColumn, ToRow, FromColumnChar, FromRowInt),
    \+ piece('K', w, ToColumn, ToRow), piece(_, w, ToColumn, ToRow).
    
constraint_rook(Color, P, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt) :-
    piece(P, Color, FromColumnChar, ToRowInt), piece(P, Color, FromColumnChar, FromRowInt), column_number(FromColumnChar, FromColumnInt),
    column_number(ToColumnChar, ToColumnInt), FromColumnInt #< ToColumnInt, CIInt is FromColumnInt + 1, CFInt is ToColumnInt - 1,
    forall(between(CIInt, CFInt, C), (column_number(CC, C), \+ piece(_, _, CC, FromRowInt))), FromRowInt = ToRowInt;

    piece(P, Color, FromColumnChar, ToRowInt), piece(P, Color, FromColumnChar, FromRowInt), column_number(FromColumnChar, FromColumnInt),
    column_number(ToColumnChar, ToColumnInt), FromColumnInt #> ToColumnInt, CIInt is FromColumnInt - 1, CFInt is ToColumnInt + 1,
    forall(between(CFInt, CIInt, C), (column_number(CC, C), \+ piece(_, _, CC, FromRowInt))), FromRowInt = ToRowInt;

    piece(P, Color, ToColumnChar, FromRowInt), piece(P, Color, FromColumnChar, FromRowInt), FromRowInt #< ToRowInt,
    LI is FromRowInt + 1, LF is ToRowInt - 1, forall(between(LI, LF, L), \+ piece(_, _, FromColumnChar, L)), FromColumnChar = ToColumnChar;
    piece(P, Color, ToColumnChar, FromRowInt), piece(P, Color, FromColumnChar, FromRowInt), FromRowInt #> ToRowInt,
    LI is FromRowInt - 1, LF is ToRowInt + 1, forall(between(LF, LI, L), \+ piece(_, _, FromColumnChar, L)), FromColumnChar = ToColumnChar.

constraint_rook_takes(Color, P, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt) :-
    Color = w, constraint_rook(Color, P, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, b, ToColumnChar, ToRowInt);

    Color = b, constraint_rook(Color, P, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, w, ToColumnChar, ToRowInt).
    
constraint_queen(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt) :-
    constraint_bishop(Color, _, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt);
    constraint_rook(Color, _, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt).

constraint_queen_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt) :-
    Color = w, constraint_queen(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, b, ToColumnChar, ToRowInt);

    Color = b, constraint_queen(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, w, ToColumnChar, ToRowInt).

constraint_king_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt) :-
    Color = w, constraint_king(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, b, ToColumnChar, ToRowInt);

    Color = b, constraint_king(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece('K', _, ToColumnChar, ToRowInt), piece(_, w, ToColumnChar, ToRowInt).
