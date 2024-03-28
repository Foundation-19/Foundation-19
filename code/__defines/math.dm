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

#define ATAN2(x, y) ( !(x) && !(y) ? 0 : (y) >= 0 ? arccos((x) / sqrt((x)*(x) + (y)*(y))) : -arccos((x) / sqrt((x)*(x) + (y)*(y))) )


// round() acts like floor(x, 1) by default but can't handle other values
#define FLOOR(x, y) ( round((x) / (y)) * (y) )

// Real modulus that handles decimals
#define MODULUS(x, y) ( (x) - FLOOR(x, y))

/// Converts a probability/second chance to probability/seconds_per_tick chance
/// For example, if you want an event to happen with a 10% per second chance, but your proc only runs every 5 seconds, do `if(prob(100*SPT_PROB_RATE(0.1, 5)))`
#define SPT_PROB_RATE(prob_per_second, seconds_per_tick) (1 - (1 - (prob_per_second)) ** (seconds_per_tick))

/// Like SPT_PROB_RATE but easier to use, simply put `if(SPT_PROB(10, 5))`
#define SPT_PROB(prob_per_second_percent, seconds_per_tick) (prob(100*SPT_PROB_RATE((prob_per_second_percent)/100, (seconds_per_tick))))
