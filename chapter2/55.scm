
					;Why is it printing back quote?

(car ''abracadabra)

					;Because spaces and paranthesis work as delimeter,
					;so when we say ''abracadabra, we are making a list of quote and abracadabra, whose
					;car is quote

					;Diggin into schemewiki, I found that
					;(car ''abracadabra) evaluates as (car (quote (quote abracadabra)))
					;Note that the evaluation runs from left to right
					;So, the first quote actually quotes the entire thing that comes after it
					;So that second quote becomes a literal 'quote' instead of a command
					;Hence, it print back quote

(car '(list 'a))

;This returns a literal list
