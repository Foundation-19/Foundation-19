/proc/slur(phrase)
	phrase = html_decode(phrase)
	var/leng=length_char(phrase)
	var/counter=length_char(phrase)
	var/newphrase=""
	var/newletter=""
	while(counter>=1)
		newletter=copytext_char(phrase,(leng-counter)+1,(leng-counter)+2)
		if(rand(1,3)==3)
			if(lowertext(newletter)=="o")
				newletter="u"
			if(lowertext(newletter)=="s")
				newletter="ch"
			if(lowertext(newletter)=="a")
				newletter="ah"
			if(lowertext(newletter)=="c")
				newletter="k"
				newletter="ah"
			if(lowertext(newletter)=="c")
				newletter="k"

			if(lowertext(newletter)=="о")  newletter="у"
			if(lowertext(newletter)=="с")  newletter="з"
			if(lowertext(newletter)=="а")  newletter="ах"
			if(lowertext(newletter)=="с")  newletter="к"
			if(lowertext(newletter)=="ч")  newletter="з"
		switch(rand(1,7))
			if(1,3,5)
				newletter="[lowertext(newletter)]"
			if(2,4,6)
				newletter="[uppertext(newletter)]"
			if(7)
				newletter+="'"
			//if(9,10)	newletter="<b>[newletter]</b>"
			//if(11,12)	newletter="<big>[newletter]</big>"
			//if(13)	newletter="<small>[newletter]</small>"
		newphrase+="[newletter]";counter-=1
	return newphrase

/proc/stutter(n)
	var/te = html_decode(n)
	var/t = ""//placed before the message. Not really sure what it's for.
	n = length_char(n)//length of the entire word
	var/p = null
	p = 1//1 is the start of any word
	while(p <= n)//while P, which starts at 1 is less or equal to N which is the length.
		var/n_letter = copytext(te, p, p + 1)//copies text from a certain distance. In this case, only one letter at a time.
		var/list/letters_list = list(
			"b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z",
			"б","с","д","ф","г","ч","ж","к","л","т","н","р","т","в","х","у","з")
		if (prob(80) && (ckey(n_letter) in letters_list))
			if (prob(10))
				n_letter = text("[n_letter]-[n_letter]-[n_letter]-[n_letter]")//replaces the current letter with this instead.
			else
				if (prob(20))
					n_letter = text("[n_letter]-[n_letter]-[n_letter]")
				else
					if (prob(5))
						n_letter = null
					else
						n_letter = text("[n_letter]-[n_letter]")
		t = text("[t][n_letter]")//since the above is ran through for each letter, the text just adds up back to the original word.
		p++//for each letter p is increased to find where the next letter will be.
	return sanitize(t)
