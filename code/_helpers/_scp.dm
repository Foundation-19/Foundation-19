//SCP Helpers

///Checks if atom is an SCP
/proc/isSCP(atom/A)
	if(A)
		if(A.SCP.designation == A)
			return 1
	else
		if(A.SCP)
			return 1
