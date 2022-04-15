#lang racket
;It is because explicitly multiplying (expmod base exp m) twice would consume twice as much as time
;than square the expression (expmod base exp m) because the same operation would have to be computed twice
;and multiplied at last
