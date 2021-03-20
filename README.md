# Complexity theory algorithm (Seidel's shortest path)

## Description
This project was developed as a project for Computational complexity theory course.
It also has unit tests (you can see them work if you watch the video)

## Project
This algoritm was implemented using Swift, iOS mobile development programming language. 
It is not the best choise for implementing algorithms, since algorithms are not Apps.
I used playgroud to run it efficiently. Sadly swift can be only compiled using Mac OS.
Tests do not work in online playgrounds, since they don't allow importing testing lib.

## Tests
I recommend using http://online.swiftplayground.run/ to run the algorithm. To do this
you need to remove line 6 and everything below line 98. To do a test place this in the 
end of the code:
```Swift
print(seidel(input: [
            //*insert arrays here*
            [0, 1, 1, 1, 1],
            [0, 0, 1, 0, 1],
            [0, 1, 0, 1, 1],
            [1, 0, 0, 0, 1],
            [1, 0, 1, 1, 0],
        ]
    )
)
```
There are several tests:
+ test for graph 3x3
+ test for graph 4x4
+ test for graph 5x5
+ test for all 0 graph
+ test for all 1 graph
+ test for matrix multiplication
