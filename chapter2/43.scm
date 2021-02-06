
					;Why this takes a long time
(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))


					;Here, (queen-cols * ) procedure is a really expensive procedure;
					;In the previous program, we called it once for each column of the board
					;Now, it is being called for each row of each column of the board
					;In a nutshell

					;This procedure is generating all the posible solutions for (k-1) columns for each one of these rows
					;Previously, this procedure was generating all the possible solutions for (k-1)columns once for each column
					;So the time complexity is high

