(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
	     
fun all_except_option (xs, ys)=
    case ys of
	[] => NONE 
     | y :: ys' => if same_string (xs, y) then SOME (ys')
		   else
		       (case all_except_option(xs, ys')of
			     NONE => NONE
			   | SOME i => SOME (y::i))

fun get_substitutions1 (xs, s)=
    case xs of
	[]=> []
      | x :: xs' => (case all_except_option(s, x) of
	      NONE => [] @ get_substitutions1(xs', s)
	| SOME i => i @ get_substitutions1(xs', s))

fun get_substitutions2 (xs, s)=
    let fun f (xs, y) = 
	   case xs of
		[]=> y
	      | x :: xs' => f(xs', y @ (case all_except_option(s, x) of
					       NONE => []
					     | SOME i => i ))
    in f(xs,[])
    end

fun similar_names (name_list,{first=x, middle=y, last=z})=
    let
	fun f (xn, res) =
	    case xn of
		[] => res
	      | xs :: xn' => f(xn', res @ [{first=xs, last=z, middle=y}])
    in
	f(get_substitutions2 (name_list, x), [{first=x, last=z, middle=y}])	
    end
	
			
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
fun card_color (x, y) =
    case x of
	Spades => Black
     | Clubs => Black
     | _ => Red

fun card_value (x, y) =
    case y of
	Jack => 10
     | Queen => 10
     | King => 10
     | Ace => 11
     | Num val_y => val_y

fun remove_card (cs, c, e)=
    let fun f(cs, res) =
	    case cs of
	    [] => raise e
	  | x :: cs' => if c=x then res @ cs'
			else
			   ( case f(cs', res) of
				 [] => raise e
			       | m => x :: m)
    in
	f(cs, [])
    end


fun all_same_color (cs)=
    case cs of
	[]=> true
     | c ::[] => true  
     | c :: d :: cs' => if not(card_color(c)= card_color(d)) then false
			   else all_same_color (d::cs')
fun sum_cards cs =
    let fun sum (cs, res) =
	    case cs of
		[] => res
	      | x::cs' => res + card_value(x) + sum(cs', res)
    in
	sum (cs, 0)
    end
	
fun score(cs, goal)=
    let val sum = sum_cards(cs)
    in
	let val pre_score =if sum > goal then 3*(sum - goal) else goal - sum
	in
	    if not(sum=0) andalso all_same_color(cs) then pre_score div 2
	    else
		pre_score
	end
    end

		
fun officiate (cs, ms, goal) =
    let fun current_state (cs', ms', held_list) =
	    case (cs', ms') of
		([], [])=> score(held_list, goal)
	      | (_, []) => score(held_list, goal)
	      | ([], y::ms1) => (case y of
				     Discard i => current_state ([], ms1, remove_card(held_list, i, IllegalMove))
				   | Draw => current_state ([], ms1, held_list)
				)					
	      | (x :: cs1, y::ms1) => if (sum_cards(held_list) > goal) then score (held_list, goal)
				      else (case y of
					    Discard i => current_state (x :: cs1, ms1, remove_card(held_list, i, IllegalMove))
					     | Draw => current_state (cs1, ms1, held_list@[x])
					   )
    in
	current_state(cs, ms, [])
    end

	
fun count_ace (cs)=
    case cs of
	[] => 0
      | x::cs1 => let fun count(cs1, res) =
			  if card_value(x)=11 then res +1 + count_ace (cs1)
			  else
			      res
		  in
		      count(cs1, 0)
		  end
		      

	
fun score_challenge(cs, goal)=
    let val sum = sum_cards(cs)
	val cnt = count_ace (cs)
    in
	let val pre_score =
		let fun calc_score(cnt, res)=
			case cnt of
			    0 => if res > goal then 3*(res - goal) else goal - res
			  | cnt => if calc_score(cnt-1, res) > calc_score(cnt-1,res-10) then calc_score(cnt-1, res-10) else calc_score(cnt-1, res)
		in
		    calc_score(cnt, sum)
		end
	in
	    if all_same_color(cs) then pre_score div 2
	    else
		pre_score
	end
    end

		
fun officiate_challenge (cs, ms, goal) =
    let fun current_state (cs', ms', held_list) =
	    case (cs', ms') of
		([], [])=> score(held_list, goal)
	      | (_, []) => score(held_list, goal)
	      | ([], y::ms1) => (case y of
				     Discard i => current_state ([], ms1, remove_card(held_list, i, IllegalMove))
				   | Draw => current_state ([], ms1, held_list)
				)			
	      | (x :: cs1, y::ms1) => if (sum_cards(held_list) > goal) then score_challenge (held_list, goal)
				      else (case y of
					    Discard i => current_state (cs1, ms1, remove_card(held_list, i, IllegalMove))
					     | Draw => current_state (cs1, ms1, held_list@[x])
					   )
    in
	current_state(cs, ms, [])
    end


	
fun careful_player (cs, goal)=
    case cs of
	[]=> []
      | a::[] => if (goal - card_value a)>10 then [Draw] else [] 
      | a::b::xs => let fun deter(cs, held_list, move_list)=
			 if(goal - (sum_cards held_list)>10) then move_list @ [Draw] @ careful_player(b::xs, goal)
			 else if  sum_cards (remove_card(held_list @ [a], b, IllegalMove)) = goal then move_list @ [Draw, Discard b]
			 else
			     move_list
		    in
			deter(cs, [], [])
		    end
			
		     

			 
