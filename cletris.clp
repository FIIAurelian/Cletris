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
	(retract ?id)
)
(defrule print_board_block
	(declare(salience 100))
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
	(assert (print_board))
	(bind ?piece_index (random 1 7))
	(assert (current_piece ?piece_index))
)

;;Adaugarea unei piese in tabla de joc
(defrule insert_piece
	?id <- (current_piece ?piece_index)
	?row_id1 <- (row 21 X $? X)
	?row_id2 <- (row 20 X $? X)
		=>
	(retract ?row_id1)
	(retract ?row_id2)
	(assert (row 21 X 0 0 0 0 X X X 0 0 0 X))
	(assert (row 20 X 0 0 0 0 0 X 0 0 0 0 X))
	(assert (print_board))
	(printout t crlf crlf)
	(assert (move_piece 21 20 19))
)

;;Mutarea unei piese de joc pana jos
(defrule move
	?id <- (move_piece ?row_index1 ?row_index2 ?row_index3)
	?row_id1 <- (row ?row_index1 X $? X)
	?row_id2 <- (row ?row_index2 X $? X)
	?row_id3 <- (row ?row_index3 X $? X)
	(test (> ?row_index1 2))
		=>
	(retract ?id)	
	(retract ?row_id1)
	(retract ?row_id2)
	(retract ?row_id3)
	(assert (row ?row_index1 X 0 0 0 0 0 0 0 0 0 0 X))
	(assert (row ?row_index2 X 0 0 0 0 X X X 0 0 0 X))
	(assert (row ?row_index3 X 0 0 0 0 0 X 0 0 0 0 X))
	(assert (print_board 20))
	(printout t " " crlf)
	(printout t " " crlf)
	(assert (move_piece ?row_index2 ?row_index3 (- ?row_index3 1)))
)
(defrule move_end
	?id_row <- (move_piece ?row_index1 ?row_index2 ?row_index3)
	?id_piece <- (current_piece ?piece_index)
	=>
	(retract ?id_row)
	(retract ?id_piece)
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
