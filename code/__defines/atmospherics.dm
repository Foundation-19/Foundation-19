// For use with pipe rotate verb
#define PIPE_ROTATE_STANDARD 0 // usual rotate
#define PIPE_ROTATE_TWODIR   1 // Sanitizes cardinal directions to just two, leaves corner directions alone
#define PIPE_ROTATE_ONEDIR   2 // Only has one dir, south

//Connection Type Definitions
#define CONNECT_TYPE_REGULAR        (1<<0)
#define CONNECT_TYPE_SUPPLY         (1<<1)
#define CONNECT_TYPE_SCRUBBER       (1<<2)
#define CONNECT_TYPE_HE				(1<<3)
#define CONNECT_TYPE_FUEL           (1<<4)

#define DISPOSAL_FLIP_NONE          0
#define DISPOSAL_FLIP_FLIP          (1<<0)
#define DISPOSAL_FLIP_LEFT          (1<<1)
#define DISPOSAL_FLIP_RIGHT         (1<<2)

//Pipe classifications
#define PIPE_CLASS_OTHER            0
#define PIPE_CLASS_UNARY            1
#define PIPE_CLASS_BINARY           2
#define PIPE_CLASS_TRINARY          3
#define PIPE_CLASS_QUATERNARY       4
#define PIPE_CLASS_OMNI             5

#define ADIABATIC_EXPONENT          0.667 //Actually adiabatic exponent - 1.
