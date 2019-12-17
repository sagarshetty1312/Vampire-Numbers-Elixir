	COP5615 – Fall 2019 
	Project-1 : Finding Vampire Numbers

1.	Team Members:
	Mittal, Prakhar 		(UFID:39099969)
	Jayanth Shetty, Sagar	(UFID:43517929)

 ->	Instructions to run the Program:
	* Extract the zip file JayanthShetty,Mittal
	* Navigate to folder JayanthShetty,Mittal
	* Open terminal and run the command "mix run proj1.exs n1 n2" (Where n1 is the lower bound and n2 is the upper-bound)

2.	Number of Worker Actors:
	Four

3.	Size of the work unit of each actor:
	Each worker gets exactly one-fourth of the total list. We used rem(<number>, 4) == 0,1,2,3 to divide the list.

4.	Result of running: mix run proj1.exs 100000 200000
	[108135, 135, 801]
	[117067, 167, 701]
	[124483, 281, 443]
	[126027, 201, 627]
	[129775, 179, 725]
	[156915, 165, 951]
	[116725, 161, 725]
	[125433, 231, 543]
	[133245, 315, 423]
	[134725, 317, 425]
	[135837, 351, 387]
	[136525, 215, 635]
	[146137, 317, 461]
	[152685, 261, 585]
	[156289, 269, 581]
	[175329, 231, 759]
	[180225, 225, 801]
	[180297, 201, 897]
	[193257, 327, 591]
	[193945, 395, 491]
	[197725, 275, 719]
	[104260, 260, 401]
	[105264, 204, 516]
	[115672, 152, 761]
	[118440, 141, 840]
	[120600, 201, 600]
	[125248, 152, 824]
	[125460, 204, 615, 246, 510]
	[125500, 251, 500]
	[129640, 140, 926]
	[135828, 231, 588]
	[136948, 146, 938]
	[146952, 156, 942]
	[150300, 300, 501]
	[152608, 251, 608]
	[153436, 356, 431]
	[156240, 240, 651]
	[162976, 176, 926]
	[163944, 396, 414]
	[186624, 216, 864]
	[190260, 210, 906]
	[102510, 201, 510]
	[105210, 210, 501]
	[105750, 150, 705]
	[110758, 158, 701]
	[123354, 231, 534]
	[126846, 261, 486]
	[131242, 311, 422]
	[132430, 323, 410]
	[140350, 350, 401]
	[145314, 351, 414]
	[172822, 221, 782]
	[173250, 231, 750]
	[174370, 371, 470]
	[182250, 225, 810]
	[182650, 281, 650]
	[192150, 210, 915]

5.	Running time of the above problem:
	real:       0m6.975s
	user:	    0m24.147s
	sys:	    0m0.391s
	cpu_time:   0m24.538s (Usertime+Systemtime)
	Ratio:      3.518 >1 (Parallelism is achieved)

6.	Biggest number solved
	
	10000000 10100000: 
	[10025010, 2001, 5010]
	[10042510, 2510, 4001]
	[10052010, 2010, 5001]
	[10052064, 2004, 5016]
	[10081260, 1260, 8001]

	mix.bat run .\proj1.exs 99900000 99999999 was the biggest number in range that we ran but couldn't find any vampire numbers in that range.

Approach:
1.	Elixir has powerful tools to implement concurrency through the actor actor model. We created 4 actors to distribute the load. We chose
	the number 4 because of the ramapant presence of 4 core systems.
2.	For every number we checked all permutations of its digits and then checked the vampire number conditions for each of these permutations
	and then returned them to the parent.
3.	The parent has a loop that runs 4 times waiting for messages from the actors and prints them when it receives them. Since the list is 
	divided by checking the remainder of its division by 4, the order of numbers is not maintained while sending them to the actors. Hence, 
	the ordering of the output in non deterministic.

Improvements:
1.	The approach used by us converted the number into a list and checked for permutations. The assumption was that the traditional way of
	finding all factors and then checking for their eligibility would take a lot of computing resources. In hindsight, the traditional way 
	would have been faster because integer processing would always be faster breaking it into a list and computing on it.