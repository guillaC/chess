SCREEN _NEWIMAGE(500, 550, 32)
_LIMIT 15
CONST PAWNDISTANCEPX = 53
CONST WHITE = 1
CONST BLACK = 2
DIM SHARED arrayW(7, 7) AS INTEGER, arrayB(7, 7) AS INTEGER 'un array par joueur
DIM canPlay AS INTEGER '0 = gameover
DIM pX AS INTEGER, pY AS INTEGER, dX AS INTEGER, dY AS INTEGER
DIM selected AS STRING 'coord du pion selectionne par le joueur
DIM SHARED pawnB, pawnW, rookB, rookW, knightB, knightW, kingB, kingW, bishopB, bishopW, queenB, queenW, board AS LONG 'une image par type de pion
board = _LOADIMAGE("Assets/board.png") 'plateau
pawnB = _LOADIMAGE("Assets/pawnB.png")
pawnW = _LOADIMAGE("Assets/pawnW.png")
rookB = _LOADIMAGE("Assets/rookB.png")
rookW = _LOADIMAGE("Assets/rookW.png")
kingB = _LOADIMAGE("Assets/kingB.png")
kingW = _LOADIMAGE("Assets/kingW.png")
knightB = _LOADIMAGE("Assets/knightB.png")
knightW = _LOADIMAGE("Assets/knightW.png")
queenB = _LOADIMAGE("Assets/queenB.png")
queenW = _LOADIMAGE("Assets/queenW.png")
bishopB = _LOADIMAGE("Assets/bishopB.png")
bishopW = _LOADIMAGE("Assets/bishopW.png")
canPlay = 1
currentPlayerTurn = WHITE

CALL setPawnArray 'je set mes deux arrays

choice:
CALL showPawns 'j'affiche
LOCATE 30, 1
IF currentPlayerTurn = 1 THEN
    INPUT "White, choisissez un pion (XY):"; selected
    pX = VAL(MID$(selected, 1, 1)): pY = VAL(MID$(selected, 2, 1))
    IF pX > 7 OR pY > 7 THEN GOTO choice 'selection d'un pion or limite d'array
    IF arrayW(pX, pY) > 0 THEN
        INPUT "White, choisissez une destination (XY):"; selected
        dX = VAL(MID$(selected, 1, 1)): dY = VAL(MID$(selected, 2, 1))
        IF dX > 7 OR dY > 7 THEN GOTO choice 'selection d'une destination hors limite d'array
        IF move(arrayW(), pX, pY, dX, dY) = 0 THEN
            GOTO choice
        END IF
    ELSE
        GOTO choice
    END IF
    currentPlayerTurn = BLACK
ELSE
    INPUT "Black, choisissez un pion (XY):"; selected
    pX = VAL(MID$(selected, 1, 1)): pY = VAL(MID$(selected, 2, 1))
    IF pX > 7 OR pY > 7 THEN GOTO choice 'selection d'un pion or limite d'array
    IF arrayB(pX, pY) > 0 THEN
        INPUT "Black, choisissez une destination (XY):"; selected
        dX = VAL(MID$(selected, 1, 1)): dY = VAL(MID$(selected, 2, 1))
        IF dX > 7 OR dY > 7 THEN GOTO choice 'selection d'une destination hors limite d'array
        IF move(arrayB(), pX, pY, dX, dY) = 0 THEN
            GOTO choice
        END IF
    ELSE
        GOTO choice
    END IF
    currentPlayerTurn = WHITE
END IF
GOTO choice

FUNCTION move (ByRef%(), x, y, newX, newY)
    IF ByRef%(newX, newY) = 0 THEN
        arrayW(newX, newY) = 0
        arrayB(newX, newY) = 0
    ELSE
        move = 0
        EXIT FUNCTION
    END IF
    ByRef%(newX, newY) = ByRef%(x, y)
    ByRef%(x, y) = 0
    move = 1
END FUNCTION

SUB showPawns 'permet l'affichage de tous les pions et du plateau
    CLS
    _PUTIMAGE (0, 0), board
    posY = 14
    FOR y = 0 TO 7
        posX = 14
        FOR x = 0 TO 7
            IF arrayW(x, y) > 0 OR arrayB(x, y) > 0 THEN
                SELECT CASE arrayB(x, y)
                    CASE 1: _PUTIMAGE (posX, posY), pawnB
                    CASE 2: _PUTIMAGE (posX, posY), rookB
                    CASE 3: _PUTIMAGE (posX, posY), knightB
                    CASE 4: _PUTIMAGE (posX, posY), bishopB
                    CASE 5: _PUTIMAGE (posX, posY), queenB
                    CASE 6: _PUTIMAGE (posX, posY), kingB
                END SELECT
                SELECT CASE arrayW(x, y)
                    CASE 1: _PUTIMAGE (posX, posY), pawnW
                    CASE 2: _PUTIMAGE (posX, posY), rookW
                    CASE 3: _PUTIMAGE (posX, posY), knightW
                    CASE 4: _PUTIMAGE (posX, posY), bishopW
                    CASE 5: _PUTIMAGE (posX, posY), queenW
                    CASE 6: _PUTIMAGE (posX, posY), kingW
                END SELECT
            END IF
            posX = posX + PAWNDISTANCEPX
        NEXT
        posY = posY + PAWNDISTANCEPX
    NEXT
    _DISPLAY
END SUB

SUB setPawnArray
    FOR y = 0 TO 7
        FOR x = 0 TO 7
            arrayW(x, y) = 0: arrayB(x, y) = 0
        NEXT
    NEXT

    FOR x = 0 TO 7 'place les pions sur les deux arrays
        arrayW(x, 1) = 1: arrayB(x, 6) = 1
        arrayB(x, 7) = VAL(MID$("23456432", x + 1, 1))
        arrayW(x, 0) = VAL(MID$("23456432", x + 1, 1))
    NEXT
END SUB
