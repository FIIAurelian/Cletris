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
    (assert (print_board 20))
)
(defrule print_board_block
    ?id <- (print_board ?line_index)
    (row ?line_index X $?line_values X)
    (test (> ?line_index 0))
        =>
    (retract ?id)
    (assert (print_board (- ?line_index 1)))
    (printout t $?line_values crlf)
)
(defrule print_board_end
    ?id <- (print_board ?)
        =>
    (retract ?id)
)


;; Initializare tabla joc
(defrule init_board_for_begin
    ?id <- (init_board)
        =>
    (retract ?id)
    (assert (init_board 21))
    (assert (row 0 X X X X X X X X X X X X))
)
(defrule init_board_for_block
    ?id <- (init_board ?line_index)
    (test (> ?line_index 0))
        =>
    (retract ?id)
    (assert (init_board (- ?line_index 1)))
    (assert (row ?line_index X 0 0 0 0 0 0 0 0 0 0 X))
)
(defrule init_board_for_end
    ?id <- (init_board ?)
        =>
    (retract ?id)
)


;; Stergere linii ocupate
(defrule remove_line_end
    ?id <- (remove_line 21)
        =>
    (retract ?id)
    (assert (row 21 X 0 0 0 0 0 0 0 0 0 0 X))
)
(defrule remove_line_block
    ?id1 <- (remove_line ?line_index)
    ?id2 <- (row ?line_index $?line_values)
        =>
    (retract ?id1)
    (retract ?id2)
    (assert (remove_line (+ ?line_index 1)))
    (assert (row (- ?line_index 1) $?line_values))
)
(defrule remove_line_begin
    ?id1 <- (row ?line_index1 X X X X X X X X X X X X)
    (test (> ?line_index1 0))
        =>
    (retract ?id1)
    (assert (remove_line (+ ?line_index1 1)))
)
