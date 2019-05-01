SCREEN _NEWIMAGE(500, 500, 32)

DIM SHARED arrayW(7, 7) AS INTEGER, arrayB(7, 7) AS INTEGER 'un array par joueur
DIM canPlay AS INTEGER
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

CALL setPawnArray
CALL showPawns

SUB showPawns 'permet l'affichage de tous les pions et du plateau
    _PUTIMAGE (0, 0), board
    posY = 14
    FOR y = 0 TO 7
        posX = 14
        FOR x = 0 TO 7
            IF arrayW(x, y) > 0 OR arrayB(x, y) > 0 THEN
                SELECT CASE arrayB(x, y)
                    CASE 1: _PUTIMAGE (posX, posY), pawnB
                    CASE 2: _PUTIMAGE (posX, posY), rookB
                    CASE 6: _PUTIMAGE (posX, posY), kingB
                    CASE 3: _PUTIMAGE (posX, posY), knightB
                    CASE 5: _PUTIMAGE (posX, posY), queenB
                    CASE 4: _PUTIMAGE (posX, posY), bishopB
                END SELECT
                SELECT CASE arrayW(x, y)
                    CASE 1: _PUTIMAGE (posX, posY), pawnW
                    CASE 2: _PUTIMAGE (posX, posY), rookW
                    CASE 6: _PUTIMAGE (posX, posY), kingW
                    CASE 3: _PUTIMAGE (posX, posY), knightW
                    CASE 5: _PUTIMAGE (posX, posY), queenW
                    CASE 4: _PUTIMAGE (posX, posY), bishopW
                END SELECT
            END IF
            posX = posX + 53
        NEXT
        posY = posY + 53
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
