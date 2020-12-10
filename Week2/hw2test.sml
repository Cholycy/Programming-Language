use "hw2.sml";
(*
val test1 = all_except_option ("string", ["string"]) = SOME []
val test1a = all_except_option ("string", ["string", "string1", "string2"]) = SOME ["string1", "string2"]
val test1b = all_except_option ("string", ["string1", "string2","string"]) = SOME ["string1", "string2"]
val test1c = all_except_option ("string", ["string1", "string2"]) = NONE
val test1d = all_except_option ("string", []) = NONE
val test1e = all_except_option ("string", ["string1","string", "string2"]) = SOME ["string1", "string2"]
							    						 
val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test2a = get_substitutions1 ([["foo", "tool"],["there"]], "foo") = ["tool"]
val test2b = get_substitutions1 ([["foo"],["there","foo"]], "foo") = ["there"]
val test2c = get_substitutions1 ([["foo", "a"],["there", "foo", "b"]], "foo") = ["a", "there", "b"]
val test2d = get_substitutions1 ([["foo", "a"]], "foo") = ["a"]
val test2e = get_substitutions1 ([["foo"]], "foo") = []
val test2f = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")=["Jeffrey","Geoff","Jeffrey"]

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test3a = get_substitutions2 ([["foo", "tool"],["there"]], "foo") = ["tool"]
val test3b = get_substitutions2 ([["foo"],["there","foo"]], "foo") = ["there"]
val test3c = get_substitutions2 ([["foo", "a"],["there", "foo", "b"]], "foo") = ["a", "there", "b"]
val test3d = get_substitutions2 ([["foo", "a"]], "foo") = ["a"]
val test3e = get_substitutions2 ([["foo"]], "foo") = []
val test3f = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")=["Jeffrey","Geoff","Jeffrey"]

val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test4a = similar_names ([["Fred","Fredrick"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"}]
val test4b = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"}]
val test4c = similar_names ([["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"},{first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val test4d = similar_names ([["Elizabeth","Betty"]], {first="Fred", middle="W", last="Smith"}) =
	     [{first="Fred", last="Smith", middle="W"}]
val test4e = similar_names ([], {first="Fred", middle="W", last="Smith"}) =
			      [{first="Fred", last="Smith", middle="W"}]

val test5 = card_color (Clubs, Num 2) = Black
val test5a = card_color (Diamonds, Num 2) = Red
val test5b = card_color (Hearts, Num 2) = Red
val test5c = card_color (Spades, Num 2) = Black
					    

val test6 = card_value (Clubs, Num 2) = 2
val test6a = card_value (Clubs, Num 8) = 8
val test6b = card_value (Clubs, Ace) = 11
val test6c = card_value (Clubs, Jack) = 10
					    

val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test7a = remove_card ([(Hearts, Ace),(Spades,Ace),(Clubs,Ace)], (Hearts, Ace), IllegalMove) = [(Spades,Ace),(Clubs,Ace)]
val test7b = remove_card ([(Hearts, Ace),(Spades,Ace),(Clubs,Ace),(Hearts, Ace),(Spades,Ace),(Clubs,Ace)], (Hearts, Ace), IllegalMove) = [(Spades,Ace),(Clubs,Ace),(Hearts, Ace),(Spades,Ace),(Clubs,Ace)]
												      																	   									    
val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test8a = all_same_color [(Hearts, Ace)] = true
val test8b = all_same_color [(Hearts, Ace), (Diamonds, Ace)] = true
val test8c = all_same_color [(Hearts, Ace), (Spades, Ace)] = false
val test8d = all_same_color [(Clubs,Ace),(Spades,Ace),(Diamonds,Ace)]=false									  
								
								

val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test9 = sum_cards [(Clubs, Jack)] = 10							    
val test9a = sum_cards [(Clubs, Num 2)] = 2
val test9b = sum_cards [(Clubs, Num 2),(Spades, Ace)] = 13
val test9c = sum_cards [(Clubs, Num 2),(Clubs, Num 8),(Clubs, Num 2),(Clubs, Num 2),(Clubs, Ace),(Clubs, Jack)] = 35
							    

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test10a = score ([(Hearts, Num 2),(Diamonds, Num 4)],10) = 2
val test10b = score ([(Hearts, Num 2),(Clubs, Ace)],10) = 9
val test10c = score ([(Hearts, Num 2),(Diamonds, Jack)],10) = 3
*)				  
							      
val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test11d = officiate ([(Hearts, Num 2),(Clubs, Num 4),(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6
val test11e = officiate ([],[Draw], 15) = 15
val test11f = officiate ([(Hearts, Num 2),(Clubs, Num 4),(Hearts, Num 2),(Clubs, Num 4)],[Draw, Draw], 15) = 9
val test11g = officiate ([(Hearts, Num 9),(Clubs, Num 9),(Hearts, Num 2),(Clubs, Num 4)],[Draw, Draw], 11) = 21
									   
									   
val test11a = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw, Draw], 15) = 9
val test11b = officiate ([(Hearts, Num 2),(Diamonds, Num 4)],[Draw, Draw], 15) = 4
val test11c = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw, Draw, Discard(Hearts, Num 2)], 15) = 5


val test12 = officiate_challenge ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3
val test12a = score_challenge ([(Clubs,Ace),(Hearts,Ace),(Clubs,Ace),(Spades,Ace)],42)
	      = 6		    
val test12b =  score_challenge([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],24) = 0							 
val test12c = score_challenge ([(Clubs,Ace),(Hearts,Ace),(Clubs,Ace),(Spades,Ace)],25) = 1


val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)

val test13a = careful_player([(Spades,Num 7),(Hearts,King),(Clubs,Ace),(Diamonds,Num 2)],17)=[Draw, Draw]
								    
            
      
