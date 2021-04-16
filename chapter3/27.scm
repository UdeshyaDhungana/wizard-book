
;; Memoize works in following way
]=> (memo-fib 3)
]=> (+ (memo-fib 2) (memo-fib 1))
]=> (+ (+ (memo-fib 1) (memo-fib 0)) (memo-fib 1))
]=> (+ (+ 1 0) (memo-fib 1))
]=> (+ 1 (memo-fib 1))
]=> (+ 1 1)
]=> 2

n-th fibonacci number is computed in linear O(n) because you have memoization table
This procedure never computes fibonacci of same number more than once.
The call tree is linear

Defining memo-fib to be (memoize fib) would never allow memoization to be preserved. We cannot make use of it that way
