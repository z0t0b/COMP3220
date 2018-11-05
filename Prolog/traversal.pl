% ----------- traversal.pl ---------------------- %
% ----------- Author: Zachary Bedsole ----------- %
% ----------- Due Date: 11/04/18 ---------------- %
% ----------- Class: COMP-3220 ------------------ %

% ------ FACTS ------ %
% Rooms
room(01).
room(02).
room(03).
room(04).
room(05).
room(06).
room(07).
room(08).
room(09).
room(10).
room(11).
room(12).
room(13).
room(14).
room(15).
room(16).

% Doors
door(01,02).
door(01,07).
door(02,08).
door(03,08).
door(04,08).
door(04,09).
door(05,06).
door(05,09).
door(06,09).
door(07,08).
door(07,09).
door(07,10).
door(07,11).
door(07,12).
door(07,13).
door(07,14).
door(14,15).
door(15,16).

% Rooms with phoneing phones (modify if you want to test that the predicates work for different rooms)
phone(05).
phone(09).
phone(16).


% ------ BASIC PREDICATES FOR OTHERS ------ %
% Checks if rooms are next to each other
next_to(Room1,Room2) :-
	(door(Room1,Room2); door(Room2,Room1)).

% Method for when trying to move to same room
move(Start,Start,T,[Start|T]).

% Moves from one room to another (if possible)
move(Start,End,T,H) :-
	next_to(Start,NextRoom),
	\+(member(NextRoom,T)),
	move(NextRoom,End,[Start|T],H).

% Reverses order when given a set of integers and an empty set
reverse_order([],X,X).

% Reverses order of set of integers after predicate above handles first data transfer
reverse_order([H|T],X,Path) :-
	reverse_order(T,X,[H|Path]).

% Returns path from one room to another
make_path(Start,End,T) :-
	var(T),
	T = [],
	move(Start,End,T,X),
	reverse_order(X,Path,[]),
   nl,
	write(Path).

% Returns all paths from start to end
return_path(Start,End) :-
   var(T),
	forall(make_path(Start,End,T),nl).
      

% ------ MAIN PREDICATES ------ %
% Predicate for when start and end is given
path_to_phone(Start,End) :-
	nonvar(Start),
	nonvar(End),
   phone(End),
   return_path(Start,End),
   fail.

% Predicate for when only start is given
path_to_phone(Start,End) :-
	nonvar(Start),
	var(End),
   forall(phone(Room),(return_path(Start,Room))),
	fail.

% Predicate for when only end is given
path_to_phone(Start,End) :-
	var(Start),
	nonvar(End),
   phone(End),
   forall(room(Room),(return_path(Room,End))),
	fail.

% Predicate for when nothing is given
path_to_phone(Start,End) :-
	var(Start),
	var(End),
   forall(phone(Room2),forall(room(Room1),(return_path(Room1,Room2)))),
	fail.
   
% ----------- EOF ----------- %
