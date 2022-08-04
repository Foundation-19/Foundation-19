// Macro functions.
#define RAND_F(LOW, HIGH) (rand()*(HIGH-LOW) + LOW)
#define ceil(x) (-round(-(x)))
#define CEILING(x, y) ( -round(-(x) / (y)) * (y) )
#define MULT_BY_RANDOM_COEF(VAR,LO,HI) VAR =  round((VAR * rand(LO * 100, HI * 100))/100, 0.1)

// Similar to clamp but the bottom rolls around to the top and vice versa. min is inclusive, max is exclusive
#define WRAP(val, min, max) clamp(( min == max ? min : (val) - (round(((val) - (min))/((max) - (min))) * ((max) - (min))) ),min,max)

/// The percentage of value in max, rounded to places: 1 = nearest 0.1 , 0 = nearest 1 , -1 = nearest 10, etc
#define PERCENT(value, max, places) round((value) / (max) * 100, !(places) || 10 ** -(places))

/// Value or the nearest integer in either direction
#define Round(value) round((value), 1)

/// Value or the nearest multiple of divisor in either direction
#define Roundm(value, divisor) round((value), (divisor))

// round() acts like floor(x, 1) by default but can't handle other values
#define FLOOR(x, y) ( round((x) / (y)) * (y) )

// Real modulus that handles decimals
#define MODULUS(x, y) ( (x) - FLOOR(x, y))
