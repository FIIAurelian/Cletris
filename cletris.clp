(defglobal
    ?*rows* = 20
    ?*cols* = 10
)

(deffacts tetris
    (init_game)
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
    (assert (line 0))
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
    (assert (line ?line_index))
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


; Stergere linii ocupate
(defrule remove_line_end
    ?id <- (remove_line 21)
        =>
    (retract ?id)
    (assert (row 21 X 0 0 0 0 0 0 0 0 0 0 X))
)
(defrule remove_line_block_1
    (remove_line ?line_index)
    ?id2 <- (cell ?line_index $?line_values)
        =>
    (retract ?id1)
    (retract ?id2)
    (assert (remove_line (+ ?line_index 1)))
    (assert (row (- ?line_index 1) $?line_values))
)
(defrule remove_line_block_2
    ?id1 <- (remove_line ?line_index)
(defrule remove_line_begin
    (line ?line_index)
    (test (> ?line_index 0))
    (forall (cell ?line_index ?col_index ?) (cell ?line_index ?col_index X))
        =>
    (assert (remove_line ?line_index))
)
