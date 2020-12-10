use "hw1.sml";
val test10 = is_older ((1,2,3),(1,2,3)) = false
val test11 = is_older ((1,2,3),(2,3,4)) = true
val test12 = is_older ((1,2,3),(1,2,4)) = true
val test13 = is_older ((2,2,3),(1,1,4)) = false
					      
					    
val test20 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test21 = number_in_month ([(2012,2,28),(2013,12,1)],3) = 0
val test22 = number_in_month ([(2012,2,28),(2013,12,1)],12) = 1
val test23 = number_in_month ([(2012,12,28),(2013,12,1)],2) = 0
val test24 = number_in_month ([(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1)],2) = 2
val test25 = number_in_month ([(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1),(2012,2,28),(2013,12,1)],2) = 15

val test30 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1,3,4]) = 2
val test31 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1,3,5]) = 1
val test32 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28),(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 6
val test33 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1]) = 0
val test34 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2]) = 1
val test35 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,5,6,7,8,9,10,11,12]) = 4

val test40 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test41 = dates_in_month ([(2012,2,8),(2012,2,18),(2012,2,28),(2012,2,2),(2012,2,22),(2013,12,1)],2) = [(2012,2,8),(2012,2,18),(2012,2,28),(2012,2,2),(2012,2,22)]
val test42 = dates_in_month ([(2012,2,28),(2013,12,1)],1) = []
val test43 = dates_in_month ([(2012,2,28),(2013,12,1)],12) = [(2013,12,1)]
								 
val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]	      
val test51 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5,6,7,1]) = []
												 
val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test61 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi"
val test62 = get_nth (["hi", "there", "how", "are", "you"], 5) = "you"
								     
val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"
val test71 = date_to_string (2013, 8, 2) = "August 2, 2013"
val test72 = date_to_string (2019, 9, 30) = "September 30, 2019"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test81 = number_before_reaching_sum (3, [1,2,3,4,5]) = 1
val test82 = number_before_reaching_sum (16, [1,2,3,4,5]) = 5
val test83 = number_before_reaching_sum (1, [1,2,3,4,5]) = 0
							       
val test9 = what_month 70 = 3
val test91 = what_month 1 = 1
val test92 = what_month 32 = 2
val test93 = what_month 31 = 1
val test94 = what_month 59 = 2
				
val test10 = month_range (31, 34) = [1,2,2,2]
val test101 = month_range (61, 69) = [3,3,3,3,3,3,3,3,3]
val test102 = month_range (28, 34) = [1,1,1,1,2,2,2]
val test103 = month_range (1, 4) = [1,1,1,1]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test111 = oldest([(2002,2,28),(2011,3,31),(2011,4,28)]) = SOME (2002,2,28)
val test112 = oldest([(2012,2,28),(2014,3,31),(2011,4,28)]) = SOME (2011,4,28)

val test120 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1,3,3,3,3,4]) = 2
val test121 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1,3,5,5]) = 1
val test122 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28),(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,5]) = 6
val test123 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[1]) = 0
val test124 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2]) = 1
val test125 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,5,6,7,8,9,10,11,12]) = 4


val test130 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]	      
val test131 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5,6,7,1]) = []
val test132 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,3,4,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]	      
val test133 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5,6,6,6,7,1]) = []
val test134 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,2,2,4,4,4,2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]	      
val test135 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5,6,7,11,1,5,6,7]) = []

val test140 = reasonable_date (2012,2,28) = true	      
val test141 = reasonable_date (2012,2,29) = true
val test142 = reasonable_date (2000,2,29)= true	      
val test143 = reasonable_date (2012,4,31) = false
val test144 = reasonable_date (~1,4,31) = false
val test145 = reasonable_date (0,4,31) = false
val test146 = reasonable_date (2012,0,31) = false
						



						
