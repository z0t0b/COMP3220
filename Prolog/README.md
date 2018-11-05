# Traversal with Prolog


### Quick start
1) Download [GNU Prolog](http://www.gprolog.org/#download)
2) Download/Clone this repository.
3) Consult the 'traversal.pl' file.
4) Enter any of the below (first number parameter can vary, although second number should be either 5, 9, or 16):

```prolog
path_to_phone(1,16).
path_to_phone(1,X).
path_to_phone(X,16).
path_to_phone(X,X).
```

# Table of Contents
* [Summary](#summary)
* [API](#API)

___

#### Summary
For this programming assignment, we will be writing a program in Prolog that will tell us how to get from one
room of a one-story building, to any other room in that building (if it’s possible), by telling us all of the rooms we
must go through to get to the destination room. In addition to the previous statement, there will be phones ringing in
one or more of the rooms. Our prolog program should ONLY tell us how to get to those rooms. If we attempt to go
to a room that does not have a ringing phone, the program should not produce any output.

![map](https://ibb.co/fpmrTL)
___

### API

## room(X)
```prolog
room(1).
room(2).
room(3).
room(4).
room(5).
room(6).
room(7).
room(8).
room(9).
room(10).
room(11).
room(12).
room(13).
room(14).
room(15).
room(16).
```
#### This creates the 16 rooms as facts within the database file.
___

## door(X,Y)
```prolog
door(1,2).
door(1,7).
door(2,8).
door(3,8).
door(4,8).
door(4,9).
door(5,6).
door(5,9).
door(6,9).
door(7,8).
door(7,9).
door(7,10).
door(7,11).
door(7,12).
door(7,13).
door(7,14).
door(14,15).
door(15,16).
```
```prolog
door(1,X).
```
#### This creates the doors as facts within the database file. These are the doorways between the existing rooms. The above call will show which rooms are connected to room 1.
___

## phone(X)
```prolog
phone(5).
phone(9).
phone(16).
```
```prolog
phone(5). 
```
#### This creates 3 rooms with ringing phones as facts within the database file. The above call will return 'yes' to the console, and 'no' if the number is not already in the database.
___

## next_to(Room1,Room2)
```prolog
next_to(Room1, Room2) :-
  (door(Room1, Room2); door(Room2, Room1)).
```
```prolog
next_to(1,2).
```
#### next_to will return 'yes' if the rooms are next to each other (as in the above call), and 'no' if they are not next to each other. This predicate uses door(X,Y) to evaluate this.
___

## move(Start,End,T,H)
```prolog
% Used when Starting room and ending room are the same
move(Start,Start,T,[Start|T]). 	

% Used to move from one room to another (if possible)
move(Start,End,T,H) :-
   next_to(Start,NextRoom),
   \+(member(NextRoom,T)), 
   move(NextRoom,End,[Start|T],H).
```
#### This predicate will move forward to another room if there is a room next to it (verified with next_to) that can be moved to.
#### Has two versions: comments for both will highlight the differences. 
___


## reverse_order([H|T],X,Path)
```prolog
% Reverses order when given a set of integers and an empty set
reverse_order([],X,X).

% Reverses order of set of integers after predicate above handles first data transfer
reverse_order([H|T],X,Path) :-
  reverse_order(T,X,[H|Path]).
```
#### These two predicates will reverse the order of the path given to it.
___

## find_path(Start,End,T)
```prolog
find_path(Start,End,T) :-
  var(T),
  T = [],
  move(Start,End,T,X),
  reverse_order(X,Path,[]),
  nl,
  write(Path).
```
#### This predicate will find the path from a starting number to an ending number.
___

## return_paths(Start,End)
```prolog
return_paths(Start,End) :-
  var(T),
  forall(make_path(Start,End,T),nl).
```
```prolog
return_paths(1,16).
```
#### This predicate returns all paths from the start to the end when called. Relies on find_path to work.
___

## path_to_phone(Start,End)
```prolog
% Predicate for when start and end is given
path_to_phone(Start,End) :-
  nonvar(Start),
  nonvar(End),
  phone(End),
  return_paths(Start,End),
  fail.

% Predicate for when only start is given
path_to_phone(Start,End) :-
  nonvar(Start),
  var(End),
  forall(phone(Room),(return_paths(Start,Room))),
  fail.

% Predicate for when only end is given
path_to_phone(Start,End) :-
  var(Start),
  nonvar(End),
  phone(End),
  forall(room(Room),(return_paths(Room,End))),
  fail.

% Predicate for when nothing is given
path_to_phone(Start,End) :-
  var(Start),
  var(End),
  forall(phone(Room2),forall(room(Room1),(return_paths(Room1,Room2)))),
  fail.
```
```prolog
path_to_phone(1, 16). % Both parameters are given
path_to_phone(1, End). % Start is the only thing given
path_to_phone(Start, 16). % End is the only thing given
path_to_phone(Start, End). % Nothing is given
```
#### path_to_phone has four predicates: one where the start and end are given, one where the start is only given, one where 
#### the end is only given, and one where only nothing is given. They are all listed above on how to call them.
___

#### License
Auburn University
___

## Author
Zachary Bedsole
