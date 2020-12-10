fun is_older(x : int * int * int, y : int * int * int)=
	if (#1 x) < (#1 y) then true
	else if ((#1 x) = (#1 y)) andalso ((#2 x) < (#2 y)) then true
	else if ((#1 x) = (#1 y)) andalso (#2 x) = (#2 y) andalso ((#3 x) < (#3 y)) then true
	else false

	     
fun number_in_month(xs: (int*int*int) list, y: int)=
    if null xs then 0
    else
	let fun count (xs: (int * int * int) list, y: int) =
		if null xs then 0
		else
		    let val tl_ans = count(tl xs, y)
		    in
			if (#2 (hd xs))=y
			then tl_ans + 1
			else tl_ans
		    end
	in (count(xs,y))		
	end


fun number_in_months(xs : (int*int*int) list, y: int list)=
    if null xs
    then 0
    else
	let
	    fun count (xs : (int*int*int) list, y: int list)=
		if null y
		then 0
		else
		    let val ans = count(xs, tl y)
		    in ans + number_in_month(xs, hd y)
		    end
	in count(xs, y)
	end





fun dates_in_month(xs: (int*int*int) list, y: int)=
    if null xs then []
    else
	let fun record (xs: (int * int * int) list, y: int) =
		if null xs then []
		else
		    let val ans_list = record(tl xs, y)
		    in
			if (#2 (hd xs))=y
			then [hd xs]@ans_list
			else ans_list
		    end
	in (record(xs,y))		
	end


fun dates_in_months(xs: (int*int*int) list, y: int list)=
    if null xs then []
    else
	let fun record (xs: (int * int * int) list, y: int list) =
		if null y then []
		else	    
		    let val ans_list = record(xs, tl y)
		    in
			dates_in_month(xs, hd y) @ ans_list
		    end
	in record (xs, y)
end

	    
fun get_nth(xs:string list, y: int)=
     if null xs then ""
     else
	 let fun get_num(xs:string list, cur:int)=
		 if null xs orelse cur>y then ""		 
		 else
		     if cur=y then hd xs
		     else get_num(tl xs, cur+1)
	 in get_num(xs, 1)
	 end

	     
fun date_to_string(year:int, month:int, date: int)=
    if year=0 orelse month=0 orelse date=0 then ""
    else
	let val month_list = ["January","February","March", "April",
			      "May", "June", "July", "August", "September", "October", "November", "December"]
	    val month = get_nth(month_list, month)
	    val ans = month^" "^Int.toString(date)^", "^Int.toString(year)
	in
	    ans
	end
	    
						  
fun number_before_reaching_sum(sum : int, num : int list)=
    if null num then 0
    else
	let fun get_sum(x: int list, cur_sum: int) =
		if null x then 0
		else   
		    let val ans = get_sum(tl x, cur_sum + hd x)
		    in
			if (cur_sum + hd x) < sum then ans+1
			else ans
		    end		  
	in
	    get_sum(num,0)
	end
	    
fun what_month(day:int)=
    if day=0 then 0
    else
	let val day_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]
	    val num = number_before_reaching_sum(day, day_in_month)
	in
	    if num<12 then num+1
	    else
		1
	end
	    
fun month_range(day1:int, day2:int)=
    if day1=0 orelse day2=0  then []
    else
	let
	    fun get_month_range(day:int)=
		if day > day2 then []
		else
		   what_month day:: get_month_range(day + 1) 
	in
	    get_month_range(day1)
	end

	    
fun oldest (dates: (int * int * int) list) =
    if null dates then NONE
    else
	let
	    fun older (date: (int * int *int) list)=
		if null (tl date) then (hd date)
		else
		    let
			val tl_ans = older(tl date)
		    in	    
			if is_older(hd date, tl_ans) then hd date
			else tl_ans
		    end
	in SOME (older dates)		
	end

	    
fun contain (xs: int list, num : int)=
    if null xs then false
    else
	let fun remain (xs: int list, num : int)=
		if null xs then false
		else
		    if(hd xs = num) then true
		    else remain (tl xs, num)
	in
	    remain (xs, num)
	end
	    

	    
fun reduce (xs: int list)=
    if null xs
    then []
    else
	let
	    fun remain (xs: int list, num:int) =
		if null xs then num::[]
	    else
		let val ry = remain(tl xs, hd xs)
		in
		    if contain(ry, hd xs) then ry
		    else
			(hd xs)::ry
		end
	in
	    remain(xs, hd xs)
	end			


fun number_in_months_challenge(xs : (int*int*int) list, y: int list)=
    if null xs
    then 0
    else
	let
	    fun count (xs : (int*int*int) list, y: int list)=
		if null y
		then 0
		else
		    let val ans = count(xs, tl y)
		    in ans + number_in_month(xs, hd y)
		    end
	in count(xs, reduce(y))
	end

fun dates_in_months_challenge(xs: (int*int*int) list, y: int list)=
    if null xs then []
    else
	let fun record (xs: (int * int * int) list, y: int list) =
		if null y then []
		else	    
		    let val ans_list = record(xs, tl y)
		    in
			dates_in_month(xs, hd y) @ ans_list
		    end
	in record (xs, reduce(y))
end

fun get_nth_month(xs:int list, y: int)=
     if null xs then 0
     else
	 let fun get_num(xs:int list, cur:int)=
		 if null xs orelse cur>y then 0		 
		 else
		     if cur=y then hd xs
		     else get_num(tl xs, cur+1)
	 in get_num(xs, 1)
	 end

fun is_leap(year: int)=
    if(year mod 400 = 0) orelse ((year mod 4 = 0) andalso not(year mod 100=0)) then true
    else false	     
	    
	    
fun reasonable_date (date : int * int * int) =
    if (#1 date)<1 orelse (#2 date)<1 orelse (#2 date)>12 orelse (#3 date)<1 orelse (#3 date)>31 then false
    else
	let
	     val day_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]
	     val day = get_nth_month (day_in_month, #2 date)
	in
	    if (#3 date <= day) then true
	    else if (is_leap(#1 date)) andalso ((#2 date) = 2) andalso (#3 date <= 29) then true
	    else false
	end
	    
