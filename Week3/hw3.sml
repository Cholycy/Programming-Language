(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

(**** you can put all your code here ****)

fun only_capitals xs = List.filter (fn v=> Char.isUpper(String.sub(v, 0))) xs
			      
fun longest_string1 xs = List.foldl (fn(x, y)=> if String.size x> String.size y then x else y) "" xs

fun longest_string2 xs = List.foldl (fn(x, y)=> if String.size x>= String.size y then x else y) "" xs
			    
fun longest_string_helper f xs = List.foldl (fn(x, y)=> if f(String.size x, String.size y) then x else y) "" xs
	
fun longest_string3 xs =
    let fun f(a,b) = a>b
    in
	
	longest_string_helper f xs
    end
	
fun longest_string4 xs=
    let fun f(a,b) = a>=b
    in
	
	longest_string_helper f xs
    end

fun longest_capitalized xs = longest_string1 (only_capitals xs)

fun rev_string s = (String.implode o List.rev o String.explode) s

fun first_answer f xs =
     case xs of
	 [] => raise NoAnswer
       | x::xs' => case f(x) of NONE=>first_answer f xs'
			      | SOME v => v
(* val all_answers = fn : ('a -> 'b option) -> 'a list -> 'b list option *)
(* should be: val all_answers = fn : ('a -> 'b list option) -> 'a list -> 'b list option *)
fun all_answers f xs =
	let fun get_answer xs l =
		    case xs of
			[] => SOME l
		      | x::xs'=> case f(x) of
			    NONE => NONE
			  | SOME v => get_answer xs' (l@v) 
	    in
		get_answer xs []
	    end

(**** 9 ******)
datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end


fun count_wildcards pat = g (fn ()=> 1) (fn x=>0) pat

fun count_wild_and_variable_lengths pat = count_wildcards pat + g (fn ()=>0)(fn y=> String.size y) pat

fun count_some_var (str, pat) = g (fn ()=>0) (fn y=> if(str=y) then 1 else 0) pat
										   
fun check_pat pat =
    let
	val res =
	    let fun patlist pat =
	      case pat of
		    Variable x => [x]
		  | TupleP ps => List.foldl (fn (p, i) => (patlist p) @ i) [] ps
		  | ConstructorP(s1, p) => patlist p
		  | _ => []
	    in
		patlist pat
	    end
    in
	let fun	filter res =(
		case res of		    
		    [] => true
		  | x :: xs => if List.exists (fn y => y=x) xs then false else filter xs
	    )
	in
	    filter res
	end
    end

	 
fun match (vu, pat) =
	    case (vu, pat) of
		(_ , Wildcard) => SOME [] 
	      | (v, Variable s) => SOME [(s, v)]
	      | (Unit, UnitP) => SOME []			     
	      | (Const a, ConstP b) => if(a=b) then SOME [] else NONE	   
	      | (Tuple vs, TupleP ps) => if List.length vs = List.length ps then
					     all_answers match (ListPair.zip(vs,ps))
					 else NONE 
	      | (Constructor(s1,v), ConstructorP(s2,p)) => if(s1=s2) then match(v,p) else NONE
	      | (_, _) => NONE
							      

(*val first_match = fn : valu -> pattern list -> (string * valu) list option*)
fun first_match vu patl = SOME (first_answer (fn x => match(vu, x)) patl)
			  handle NoAnswer => NONE
	
			
(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string
	    
(* ((string * string * typ) list) * (pattern list) -> typ option *)								
fun typecheck_patterns (cs, ps) =
    let
	fun all_answers2 f p =
	    let fun get_answer p res =
		    case p of
			[] => SOME res
		      | p1::p' => case f(p1) of
				      NONE => NONE
				    | SOME l => get_answer p' (res@[l])
	    in
		get_answer p []
	    end

	fun type_lenient (t1, t2) =
	    case (t1, t2) of
		(t, Anything) => SOME t
	      | (Anything, t) => SOME t
	      | (UnitT, UnitT) => SOME UnitT
	      | (IntT, IntT) => SOME IntT
	      | (TupleT tt1, TupleT tt2) => (case (tt1,tt2) of
						 ([], []) => SOME Anything
					       | _ => case all_answers2 type_lenient (ListPair.zip(tt1, tt2)) of
							  NONE=>NONE
							| SOME lst => SOME (TupleT lst) 
					    )
	      | (Datatype d1, Datatype d2) => if d1=d2 then SOME (Datatype d1) else NONE
	      | _ => NONE
	(* validate s from pattern list whether is defined in cs *)
	fun valid cs s t =
	    case cs of
		[] => NONE
	      | (a, b, c)::cs' => if(b=s) then type_lenient(c, t)
			    else
				valid cs' s t
	fun convert pat = 
	    case pat of
		Wildcard => SOME Anything
	      | Variable s => SOME Anything
	      | UnitP => SOME UnitT
	      | ConstP c => SOME IntT
	      | TupleP ps => (case all_answers2 convert ps of
				  NONE => NONE
				| SOME lst => SOME (TupleT lst))
	      | ConstructorP (s, p) => case convert p of
					   NONE => NONE
					 | SOME t => valid cs s t						       
	
    in
	case all_answers2 convert ps of
	    NONE => NONE
	  | SOME lst => let fun get_answer lst res =
				case lst of
				    [] => SOME res
				  | a :: lst' => (case type_lenient(a, res) of
						     NONE => NONE
						   | SOME l => get_answer lst' l
						 )
			in
			   get_answer lst Anything
			end		    				    
    end
