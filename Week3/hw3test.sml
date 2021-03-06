(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)
use"hw3.sml";
(*
val test1 = only_capitals ["A","B","C"] = ["A","B","C"]
val test1a = only_capitals ["A","b","C"] = ["A","C"]
val test1b = only_capitals ["a","b","C"] = ["C"]
val test1c = only_capitals ["a","b","c"] = []
val test1d = only_capitals [] = []
val test1e = only_capitals ["Abc","aBc","abC"] = ["Abc"]

					      
					      

					    
val test2 = longest_string1 ["A","bc","C"] = "bc"
val test2a = longest_string1 ["AB","bc","C"] = "AB"
val test2b = longest_string1 ["A","bc","Cde"] = "Cde"
val test2c = longest_string1 ["A","bc","C","abcd"] = "abcd"
val test2d = longest_string1 ["A","b","C"] = "A"
val test2e = longest_string1 [] = ""
						 
						 


						 

val test3 = longest_string2 ["A","bc","C"] = "bc"
val test3a = longest_string2 ["AB","bc","C"] = "bc"
val test3b = longest_string2 ["A","bc","Cde"] = "Cde"
val test3c = longest_string2 ["A","bc","C","abcd"] = "abcd"
val test3d = longest_string2 ["A","b","C"] = "C"
val test3e = longest_string2 [] = ""
*)


						 

val test4a = longest_string3 ["A","bc","C"] = "bc"

val test4b = longest_string4 ["A","B","C"] = "C"

val test5 = longest_capitalized ["A","bc","C"] = "A"


val test6 = rev_string "abc" = "cba"

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test7a = first_answer (fn x => if x > 4 then SOME x else NONE) [1,2,3,4,5] = 5
										     (*
val test7b = first_answer (fn x => if x > 5 then SOME x else NONE) [1,2,3,4,5] = raise NoAnswer
										    

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8a = all_answers (fn x => if x = 1 then SOME [x] else NONE) [] = SOME []
val test8b = all_answers (fn x => if x = 2 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2]
val test8c = all_answers (fn x => if x > 1 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]
										       
*)
val test9a = count_wildcards Wildcard = 1
val test9a1 =count_wildcards (ConstructorP("a", Variable("a"))) = 0
val test9a2 =count_wildcards (ConstructorP("a", Wildcard)) = 1
val test9a3 = count_wildcards (Variable("a")) = 0
						    

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1
val test9b1 = count_wild_and_variable_lengths (Wildcard) = 1
val test9b2 = count_wild_and_variable_lengths (Variable("abc")) = 3
val test9b3 = count_wild_and_variable_lengths (ConstructorP("a", Wildcard)) = 1
val test9b4 = count_wild_and_variable_lengths (TupleP([Variable("x"), Wildcard, Wildcard])) = 3
										  								  
val test9c = count_some_var ("x", Variable("x")) = 1
val test9c1 = count_some_var ("x", Variable("a")) = 0
val test9c2 = count_some_var ("x", (ConstructorP("a", Variable("x")))) = 1
val test9c3 = count_some_var ("x", (TupleP([Variable("x"), Wildcard, Wildcard]))) = 1
						       
						       
val test10 = check_pat (Variable("x")) = true
val test10a = check_pat (TupleP([Variable("x"), Variable("x"),Wildcard, Wildcard])) = false
val test10b = check_pat (TupleP([Variable("x"), Variable("y"),Wildcard, Wildcard])) = true
val test10b = check_pat (ConstructorP("hi",TupleP[Variable "x",Variable "x"])) = false									  					     					     
val test11 = match (Const(1), UnitP) = NONE
val test11a = match (Const(1), ConstP(2)) = SOME []
val test11b = match (Const(1), Wildcard) = SOME []
					      					   
val test12 = first_match Unit [UnitP] = SOME []
val test12a = first_match Unit [ConstP(2)] = NONE
val test12b = first_match Unit [Variable("x")] = SOME [("x",Unit)]
					     

