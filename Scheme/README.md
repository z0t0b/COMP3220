Scheme MD FIle



# Scheme - Lee County Funfair


### Quick start
1) Download [Dr. Racket](https://download.racket-lang.org/)
2) Open a new file.
3) Put the following line at the top of the file: 

```scheme
#lang racket
(require (planet dyoo/simply-scheme:1:2/simply-scheme) )

```

# Table of Contents
* [Summary](#summary)
* [API](#API)

___

#### Summary
The project description is as follows:
Lee county is organizing a county fair over the upcoming summer. You along with one
other friend plan to participate in several games including the bucket ball game. Each
player will be assigned a bucket to start with and the player that gets the bucket with the
highest worth wins the game. The worth of each bucket is calculated as per the rules
below. 

A bucket contains 10 balls of four different colors – red, blue, white, and green. Each
red is worth 10 points, each green is worth 15 points, each blue ball is worth 20 points,
and each white ball is worth 1 point. 

**You are going to write a computer program in
Scheme to look at a bucket and decide how many points it’s worth.**
___

### API

## ball-val
```racket
(define (ball-val ball)
           (let ([W 1]
                 [R 10]
                 [G 15]
                 [B 20])
                (if (equal? ball 'R)
                    (display 10))
                (if (equal? ball 'W)
                    (display 1))
                (if (equal? ball 'G)
                    (display 15))
                (if (equal? ball 'B)
                    (display 20))))
```
```scheme
(ball-val 'R)
```
#### This procedure takes a single ball as its argument and returns the value of that ball.
___

## count-balls
```racket
(define (count-balls color bucket)
  (count (keep (lambda (c) (equal? color c)) bucket)))
```
```scheme
(count-balls 'R '(R B G R R R B W R W))
```
#### This procedure takes a color and a bucket as arguments and returns the number of balls in the bucket with the given color.
___

## color-counts
```racket
(define (color-counts bucket)
  (let ([R (count-balls 'R bucket)]
        [W (count-balls 'W bucket)]
        [B (count-balls 'B bucket)]
        [G (count-balls 'G bucket)])
    (display (list R G W B))))
```
```scheme
(color-counts '(R B G R R R B W R W))
```
#### This procedure takes a bucket as its argument and returns a sentence containing the number of reds, the number of green, the number of blues, and the number of whites in the bucket.
___

## bucket-val
```racket
(define (bucket-val bucket)
          (let ([R (count-balls 'R bucket)]
                [W (count-balls 'W bucket)]
                [G (count-balls 'G bucket)]
                [B (count-balls 'B bucket)])
            (let ([sum (+ (+ (* R 10) (* W 1)) (+ (* G 15) (* B 20)))])
              (display sum))))
```
```scheme
(bucket-val '(R B G R R R B W R W))
```
#### This procedure takes a bucket as its argument and returns the total number of points that the bucket is worth.
___

## judge
```racket
(define (judge bucket_1 bucket_2)
          (let ([R1 (count-balls 'R bucket_1)]
                [W1 (count-balls 'W bucket_1)]
                [G1 (count-balls 'G bucket_1)]
                [B1 (count-balls 'B bucket_1)]
                [R2 (count-balls 'R bucket_2)]
                [W2 (count-balls 'W bucket_2)]
                [G2 (count-balls 'G bucket_2)]
                [B2 (count-balls 'B bucket_2)])
            (let ([sum1 (+ (+ (* R1 10) (* W1 1)) (+ (* G1 15) (* B1 20)))]
                  [sum2 (+ (+ (* R2 10) (* W2 1)) (+ (* G2 15) (* B2 20)))])
            (if (equal? sum1 sum2)
                (display "It\'s a Tie .. !"))
            (if (> sum1 sum2)
                (display "Bucket 1, Won .. !"))
            (if (< sum1 sum2)
                (display "Bucket 2, Won .. !")))))
```
```scheme
(judge '(R B G R R R B W R W) '(W R R R R G B B G W))
```
#### This procedure takes two arguments bucket_1 and bucket_2 and returns who won the game, player of BUCKET_1 or BUCKET_2.
___

#### License
Auburn University
___

## Author
Zachary Bedsole
