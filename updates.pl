update_board(Color, move('P', FromColumnChar, takes, ToColumnChar, ToRowInt, A)) :-
    constraint_pawn_takes(Color, FromColumnChar, ToColumnChar, ToRowInt, FromRowInt),
    retract(piece('P', Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)), 
    assertz(piece('P', Color, ToColumnChar, ToRowInt)), write(A), nl, inCheck(A); 
    
    true.

% Faz update das peças dependendo do seu tipo
update_board(Color, move(Type, ToColumnChar, ToRowInt)) :-

    Type = 'P',
    constraint_pawn(Color, ToColumnChar, ToRowInt, FromRowInt),
    % Update das peças
    retract(piece('P', Color, ToColumnChar, FromRowInt)),
    assertz(piece('P', Color, ToColumnChar, ToRowInt));

    Type = 'N',
    constraint_knight(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    piece('N', Color, FromColumnChar, FromRowInt),
    retract(piece('N', Color, FromColumnChar, FromRowInt)),
    assertz(piece('N', Color, ToColumnChar, ToRowInt));

    Type = 'B',
    constraint_bishop(Color,'B', ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    piece('B', Color, FromColumnChar, FromRowInt),
    retract(piece('B', Color, FromColumnChar, FromRowInt)),
    assertz(piece('B', Color, ToColumnChar, ToRowInt));

    Type = 'R',
    constraint_rook(Color, 'R', ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    piece('R', Color, FromColumnChar, FromRowInt),
    retract(piece('R', Color, FromColumnChar, FromRowInt)),
    assertz(piece('R', Color, ToColumnChar, ToRowInt));

    Type = 'Q', 
    constraint_queen(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    piece('Q', Color, FromColumnChar, FromRowInt),
    retract(piece('Q', Color, FromColumnChar, FromRowInt)),
    assertz(piece('Q', Color, ToColumnChar, ToRowInt));

    Type = 'K',
    constraint_king(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    piece('K', Color, FromColumnChar, FromRowInt),
    retract(piece('K', Color, FromColumnChar, FromRowInt)),
    assertz(piece('K', Color, ToColumnChar, ToRowInt));
    true.

    
update_board(Color, move('P', FromColumnChar, takes, ToColumnChar, ToRowInt)) :-
    constraint_pawn_takes(Color, FromColumnChar, ToColumnChar, ToRowInt, FromRowInt),
    retract(piece('P', Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece('P', Color, ToColumnChar, ToRowInt));

    true.

update_board(Color, move(Type, takes, ToColumnChar, ToRowInt)) :-
    Type = 'N', constraint_knight_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'B', constraint_bishop_takes(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'R', constraint_rook_takes(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'Q', constraint_queen_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'K', constraint_king_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));
    
    true.
    
update_board(Color, move(Type, ToColumnChar, ToRowInt, check)) :-
    Type = 'N', constraint_knight(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece(_, _, ToColumnChar, ToRowInt), retract(piece(Type, Color, FromColumnChar, FromRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'B', constraint_bishop(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece(_, _, ToColumnChar, ToRowInt), retract(piece(Type, Color, FromColumnChar, FromRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'R',constraint_rook(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece(_, _, ToColumnChar, ToRowInt), retract(piece(Type, Color, FromColumnChar, FromRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'Q', constraint_queen(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece(_, _, ToColumnChar, ToRowInt), retract(piece(Type, Color, FromColumnChar, FromRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'K', constraint_king(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    \+ piece(_, _, ToColumnChar, ToRowInt), retract(piece(Type, Color, FromColumnChar, FromRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    true.
    
update_board(Color, move(Type, takes, ToColumnChar, ToRowInt, A)) :-
    Type = 'N', constraint_knight_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    Type = 'B', constraint_bishop_takes(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    Type = 'R', constraint_rook_takes(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    Type = 'Q', constraint_queen_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    true.

update_board(Color, move(Type, FromColumnChar, ToColumnChar, ToRowInt)) :-
    Type = 'N', constraint_knight(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'R', constraint_rook(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    true.

update_board(Color, move(Type, FromRowInt, ToColumnChar, ToRowInt)) :-
    Type = 'N', constraint_knight(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'R', constraint_rook(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    true.

update_board(Color, move(Type, FromColumnChar, takes, ToColumnChar, ToRowInt)) :-
    Type = 'N', constraint_knight_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'R', constraint_rook_takes(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    true.

update_board(Color, move(Type, FromRowInt, takes, ToColumnChar, ToRowInt)) :-
    Type = 'N', constraint_knight_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    Type = 'R', constraint_rook_takes(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt));

    true.

update_board(Color, move(Type, FromColumnChar, ToColumnChar, ToRowInt, A)) :-
    Type = 'N', constraint_knight(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    Type = 'R', constraint_rook(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    true.

update_board(Color, move(Type, FromRowInt, ToColumnChar, ToRowInt, A)) :-
    Type = 'N', constraint_knight(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    Type = 'R',constraint_rook(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);
    true.

update_board(Color, move(Type, FromColumnChar, takes, ToColumnChar, ToRowInt, A)) :-
    Type = 'N', constraint_knight_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    Type = 'R', constraint_rook_takes(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    true.

update_board(Color, move(Type, FromRowInt, takes, ToColumnChar, ToRowInt, A)) :-
    Type = 'N', constraint_knight_takes(Color, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    Type = 'R', constraint_rook_takes(Color, Type, ToColumnChar, ToRowInt, FromColumnChar, FromRowInt),
    retract(piece(Type, Color, FromColumnChar, FromRowInt)), retract(piece(_, _, ToColumnChar, ToRowInt)),
    assertz(piece(Type, Color, ToColumnChar, ToRowInt)), write(A), nl,
    inCheck(Color, A);

    true.

update_board(Color, Castle) :-
    Color = w,
    Castle = 'kingside_castle',
    constraint_kingside_castle(Color),
    retract(piece('K', Color, e, 1)), retract(piece('R', Color, h, 1)),
    assertz(piece('K', Color, g, 1)), assertz(piece('R', Color, f, 1));

    Color = b,
    Castle = 'kingside_castle',
    constraint_kingside_castle(Color),
    retract(piece('K', Color, e, 8)), retract(piece('R', Color, h, 8)),
    assertz(piece('K', Color, g, 8)), assertz(piece('R', Color, f, 8));

    Color = w,
    Castle = 'queenside_castle',
    constraint_queenside_castle(Color),
    retract(piece('K', Color, e, 1)), retract(piece('R', Color, a, 1)),
    assertz(piece('K', Color, c, 1)), assertz(piece('R', Color, d, 1));

    Color = b,
    Castle = 'queenside_castle',
    constraint_queenside_castle(Color),
    retract(piece('K', Color, e, 8)), retract(piece('R', Color, a, 8)),
    assertz(piece('K', Color, c, 8)), assertz(piece('R', Color, d, 8));

    true.
