SCREEN _NEWIMAGE(500, 650, 32)
_LIMIT 15
CONST PAWNDISTANCEPX = 53
CONST WHITE = 1
CONST BLACK = 2
DIM SHARED outW(15) AS INTEGER, outB(15) AS INTEGER

DIM SHARED outWCounter AS INTEGER, outBCounter AS INTEGER
DIM SHARED arrayW(7, 7) AS INTEGER, arrayB(7, 7) AS INTEGER 'un array par joueur
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
currentPlayerTurn = WHITE

CALL setPawnArray 'je set mes deux arrays

choice:
IF currentPlayerTurn = WHITE THEN
    CALL guessPlayer("WHITE", arrayW())
    currentPlayerTurn = BLACK
ELSE
    CALL guessPlayer("BLACK", arrayB())
    currentPlayerTurn = WHITE
END IF
GOTO choice

SUB guessPlayer (colPlayer AS STRING, currArray%())
    DIM selected AS STRING
    choice:
    CALL showPawns 'j'affiche
    CALL showOut
    LOCATE 30, 1
    PRINT colPlayer
    INPUT "choisissez un pion (XY):"; selected
    pX = VAL(MID$(selected, 1, 1)): pY = VAL(MID$(selected, 2, 1))
    IF pX > 7 OR pY > 7 THEN GOTO choice 'selection d'un pion or limite d'array
    IF currArray%(pX, pY) > 0 THEN
        INPUT "choisissez une destination (XY):"; selected
        dX = VAL(MID$(selected, 1, 1)): dY = VAL(MID$(selected, 2, 1))
        IF dX > 7 OR dY > 7 THEN GOTO choice 'selection d'une destination hors limite d'array
        IF move(currArray%(), pX, pY, dX, dY) = 0 THEN
            GOTO choice
        END IF
    ELSE
        GOTO choice
    END IF
END FUNCTION


FUNCTION move (currArray%(), x, y, newX, newY)
    IF currArray%(newX, newY) = 0 THEN
        CALL outWB(newX, newY)
        arrayW(newX, newY) = 0
        arrayB(newX, newY) = 0
    ELSE
        move = 0
        EXIT FUNCTION
    END IF
    currArray%(newX, newY) = currArray%(x, y)
    currArray%(x, y) = 0
    move = 1
END FUNCTION

SUB outWB (x, y)
    IF arrayW(x, y) > 0 THEN
        outW(outWCounter) = arrayW(x, y)
        outWCounter = outWCounter + 1
    END IF
    IF arrayB(x, y) > 0 THEN
        outB(outBCounter) = arrayB(x, y)
        outBCounter = outBCounter + 1
    END IF
END SUB

SUB showOut
    posY = 500
    posX = 14
    FOR x = 0 TO 15
        IF outB(x) > 0 THEN
            SELECT CASE outB(x)
                CASE 1: _PUTIMAGE (posX, posY), pawnB
                CASE 2: _PUTIMAGE (posX, posY), rookB
                CASE 3: _PUTIMAGE (posX, posY), knightB
                CASE 4: _PUTIMAGE (posX, posY), bishopB
                CASE 5: _PUTIMAGE (posX, posY), queenB
                CASE 6: _PUTIMAGE (posX, posY), kingB
            END SELECT
            posX = posX + PAWNDISTANCEPX
        END IF
    NEXT
    posY = posY + PAWNDISTANCEPX
    posX = 14
    FOR x = 0 TO 15
        IF outW(x) > 0 THEN
            SELECT CASE outB(x)
                CASE 1: _PUTIMAGE (posX, posY), pawnW
                CASE 2: _PUTIMAGE (posX, posY), rookW
                CASE 3: _PUTIMAGE (posX, posY), knightW
                CASE 4: _PUTIMAGE (posX, posY), bishopW
                CASE 5: _PUTIMAGE (posX, posY), queenW
                CASE 6: _PUTIMAGE (posX, posY), kingW
            END SELECT
            posX = posX + PAWNDISTANCEPX
        END IF
    NEXT

END SUB

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

    FOR x = 0 TO 14
        outB(x) = 0
        outW(x) = 0
    NEXT

END SUB
