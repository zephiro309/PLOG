/* all needed operations for soving the problem */

:- use_module(library(clpfd)).

gamePiece([X1, X2, X3, X4, X5, X6]) :-
	all_different([X1, X2, X3, X4, X5, X6]),
	X1 #>= 1, X1 #=< 6,
	X2 #>= 1, X2 #=< 6,
	X3 #>= 1, X3 #=< 6,
	X4 #>= 1, X4 #=< 6,
	X5 #>= 1, X5 #=< 6,
	X6 #>= 1, X6 #=< 6.

addPiece(Total, Piece, Result) :-
	append(Total, Piece, Result).

generateStandardPieces(Board, FinalBoard) :-
	append(Board, [1, 6, 2, 4, 5, 3], Board1),
	append([Board1], [[2, 3, 5, 1, 4, 6]], Board2),
	append(Board2, [[3, 2, 4, 1, 6, 5]], Board3),
	append(Board3, [[1, 4, 3, 6, 5, 2]], Board4),
	append(Board4, [[4, 5, 6, 1, 2, 3]], Board5),
	append(Board5, [[2, 5, 3, 1, 6, 4]], Board6),
	append(Board6, [[5, 4, 3, 2, 1, 6]], FinalBoard).

generateBoard('standard', Board, FinalBoard) :-
	generateStandardPieces(Board, FinalBoard).

generateBoard('dynamic', Board).

getStandardBoardPiece([B|Bs], 0, Piece) :-
	Piece = B.

getStandardBoardPiece([Board|BoardS], Position, Piece) :-
	Position > 0,
	Position2 is Position - 1,
	Board2 = BoardS,
	getStandardBoardPiece(Board2, Position2, Piece).

solveNuts(Board, 'standard') :-
	/* get pieces */
	element(1, Board, Piece),
	element(2, Board, Piece2),
	/* get elements */
	element(1, Piece, Top1),
	element(2, Piece, TopRight1),
	element(3, Piece, BottomRight1),
	element(4, Piece, Bottom1),
	element(5, Piece, BottomLeft1),
	element(6, Piece, TopLeft1),
	element(4, Piece2, Bottom2),
	/* constrain */
	Top1 #= Bottom2.

checkPieceValidity(Piece, 0, Rotation) :-
	.*