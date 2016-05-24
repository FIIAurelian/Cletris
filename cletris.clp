(defglobal
    ?*rows* = 20
    ?*cols* = 10
)

(deffacts tetris
    (init_game)
    (init_piece)
)

(defrule init_game
    ?id <- (init_game)
        =>
    (retract ?id)
    (assert (init_board))
)

;; Afisare tabla joc
(defrule print_board_begin
    ?id <- (print_board)
        =>
    (assert (print_board_line 20))
    (retract ?id)
)
(defrule print_board_end
    ?id <- (print_board_line 0)
        =>
    (retract ?id)
)
(defrule print_board_block
    ?id <- (print_board_line ?line_index)
    (cell ?line_index  1 ?value01)
    (cell ?line_index  2 ?value02)
    (cell ?line_index  3 ?value03)
    (cell ?line_index  4 ?value04)
    (cell ?line_index  5 ?value05)
    (cell ?line_index  6 ?value06)
    (cell ?line_index  7 ?value07)
    (cell ?line_index  8 ?value08)
    (cell ?line_index  9 ?value09)
    (cell ?line_index 10 ?value10)
        =>
    (retract ?id)
    (printout t ?value01 ?value02 ?value03 ?value04 ?value05 ?value06 ?value07 ?value08 ?value09 ?value10 crlf)
    (assert (print_board_line (- ?line_index 1)))
)


;; Initializare tabla joc
(defrule init_board_begin
    ?id <- (init_board)
        =>
    (retract ?id)
    (assert (init_board_line 21))
)
(defrule init_board_end
    ?id <- (init_board_line 0)
        =>
    (bind ?line_index 0)
    (retract ?id)
    (assert (cell ?line_index  0 X))
    (assert (cell ?line_index  1 X))
    (assert (cell ?line_index  2 X))
    (assert (cell ?line_index  3 X))
    (assert (cell ?line_index  4 X))
    (assert (cell ?line_index  5 X))
    (assert (cell ?line_index  6 X))
    (assert (cell ?line_index  7 X))
    (assert (cell ?line_index  8 X))
    (assert (cell ?line_index  9 X))
    (assert (cell ?line_index 10 X))
    (assert (cell ?line_index 11 X))
)
(defrule init_board_block
    ?id <- (init_board_line ?line_index)
        =>
    (retract ?id)
    (assert (cell ?line_index  0 X))
    (assert (cell ?line_index  1 O))
    (assert (cell ?line_index  2 O))
    (assert (cell ?line_index  3 O))
    (assert (cell ?line_index  4 O))
    (assert (cell ?line_index  5 O))
    (assert (cell ?line_index  6 O))
    (assert (cell ?line_index  7 O))
    (assert (cell ?line_index  8 O))
    (assert (cell ?line_index  9 O))
    (assert (cell ?line_index 10 O))
    (assert (cell ?line_index 11 X))
    (assert (init_board_line (- ?line_index 1)))
)


;; Stergere linii ocupate
(defrule remove_line_end
    ?id <- (remove_line 21)
        =>
    (bind ?line_index 21)
    (retract ?id)
    (assert (cell ?line_index  1 O))
    (assert (cell ?line_index  2 O))
    (assert (cell ?line_index  3 O))
    (assert (cell ?line_index  4 O))
    (assert (cell ?line_index  5 O))
    (assert (cell ?line_index  6 O))
    (assert (cell ?line_index  7 O))
    (assert (cell ?line_index  8 O))
    (assert (cell ?line_index  9 O))
    (assert (cell ?line_index 10 O))
)
(defrule remove_line_block
    ?id <- (remove_line ?line_index)
    ?id01 <- (cell ?line_index  1 ?value01)
    ?id02 <- (cell ?line_index  2 ?value02)
    ?id03 <- (cell ?line_index  3 ?value03)
    ?id04 <- (cell ?line_index  4 ?value04)
    ?id05 <- (cell ?line_index  5 ?value05)
    ?id06 <- (cell ?line_index  6 ?value06)
    ?id07 <- (cell ?line_index  7 ?value07)
    ?id08 <- (cell ?line_index  8 ?value08)
    ?id09 <- (cell ?line_index  9 ?value09)
    ?id10 <- (cell ?line_index 10 ?value10)
        =>
    (retract ?id)
    (retract ?id01)
    (retract ?id02)
    (retract ?id03)
    (retract ?id04)
    (retract ?id05)
    (retract ?id06)
    (retract ?id07)
    (retract ?id08)
    (retract ?id09)
    (retract ?id10)
    (assert (remove_line (+ ?line_index 1)))
    (assert (cell (- ?line_index 1)  1 ?value01))
    (assert (cell (- ?line_index 1)  2 ?value02))
    (assert (cell (- ?line_index 1)  3 ?value03))
    (assert (cell (- ?line_index 1)  4 ?value04))
    (assert (cell (- ?line_index 1)  5 ?value05))
    (assert (cell (- ?line_index 1)  6 ?value06))
    (assert (cell (- ?line_index 1)  7 ?value07))
    (assert (cell (- ?line_index 1)  8 ?value08))
    (assert (cell (- ?line_index 1)  9 ?value09))
    (assert (cell (- ?line_index 1) 10 ?value10))
)
(defrule remove_line_begin
    ?id01 <- (cell ?line_index  1 X)
    ?id02 <- (cell ?line_index  2 X)
    ?id03 <- (cell ?line_index  3 X)
    ?id04 <- (cell ?line_index  4 X)
    ?id05 <- (cell ?line_index  5 X)
    ?id06 <- (cell ?line_index  6 X)
    ?id07 <- (cell ?line_index  7 X)
    ?id08 <- (cell ?line_index  8 X)
    ?id09 <- (cell ?line_index  9 X)
    ?id10 <- (cell ?line_index 10 X)
    (test (> ?line_index 0))
        =>
    (retract ?id01)
    (retract ?id02)
    (retract ?id03)
    (retract ?id04)
    (retract ?id05)
    (retract ?id06)
    (retract ?id07)
    (retract ?id08)
    (retract ?id09)
    (retract ?id10)
    (assert (remove_line ?line_index))
)
