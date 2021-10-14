#define GENERAL_PROTECT_DATUM(Path)\
##Path/get_variables(var_name){\
	return FALSE;\
}\
##Path/may_edit_var(var_name, var_value){\
	return FALSE;\
}
