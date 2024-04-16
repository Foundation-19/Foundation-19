// Balance values
/// Default core size
#define CORE_SIZE_DEFAULT 8000
/// Default max cycles
#define CORE_MAX_CYCLES 80000

// Instructions - default is CORE_INSTRUCTION_DAT
/// data - kills the active process
#define CORE_INSTRUCTION_DAT 0
/// move - copies data from address A to address B
#define CORE_INSTRUCTION_MOV 1
/// add - adds value of A to address B
#define CORE_INSTRUCTION_ADD 2
/// subtract - subtracts value of A to address B
#define CORE_INSTRUCTION_SUB 3
/// multiply - multiplies value of A with address B
#define CORE_INSTRUCTION_MUL 4
/// divide - divides value of A from address B, kills active process if A = 0
#define CORE_INSTRUCTION_DIV 5
/// modulo - modulos value of A from address B, kills active process if A = 0
#define CORE_INSTRUCTION_MOD 6
/// jump - jumps to address A
#define CORE_INSTRUCTION_JMP 7
/// jump if zero - jumps to address A if value B is zero
#define CORE_INSTRUCTION_JMZ 8
/// jump if not zero - jumps to address A if value B is not zero
#define CORE_INSTRUCTION_JMN 9
/// decrement and jump if not zero - decrements value B, then jumps to address A if value B is not zero
#define CORE_INSTRUCTION_DJN 10
/// split - spawns a new process at address A
#define CORE_INSTRUCTION_SPL 11
/// skip if equal - skips the next instruction if value A is equal to value B
#define CORE_INSTRUCTION_SEQ 12
/// skip if not equal - skips the next instruction if value A is not equal to value B
#define CORE_INSTRUCTION_SNE 13
/// skip if lower than - skips the next instruction if value A is less than value B
#define CORE_INSTRUCTION_SLT 14
/// no operation - does nothing
#define CORE_INSTRUCTION_NOP 15
// TODO: P-space?

// Addressing Modes - default is CORE_ADDMODE_DIRECT
/// Direct
#define CORE_ADDMODE_DIRECT 0
/// Immediate
#define CORE_ADDMODE_IMMEDIATE 1
/// A-field indirect
#define CORE_ADDMODE_A_INDIRECT 2
/// B-field indirect
#define CORE_ADDMODE_B_INDIRECT 3
/// A-field indirect with predecrement
#define CORE_ADDMODE_A_INDIRECT_PREDEC 4
/// B-field indirect with predecrement
#define CORE_ADDMODE_B_INDIRECT_PREDEC 5
/// A-field indirect with postincrement
#define CORE_ADDMODE_A_INDIRECT_POSTIN 6
/// B-field indirect with postincrement
#define CORE_ADDMODE_B_INDIRECT_POSTIN 7

// Instruction Modifiers - default depends on instruction
/// A-field to A-field
#define CORE_INSMOD_A 1
/// B-field to B-field
#define CORE_INSMOD_B 2
/// A-field to B-field
#define CORE_INSMOD_AB 3
/// B-field to A-field
#define CORE_INSMOD_BA 4
/// A-field to A-field and B-field to B-field - same fields
#define CORE_INSMOD_F 5
/// A-field to B-field and B-field to A-field - opposite fields
#define CORE_INSMOD_X 6
/// Whole instruction
#define CORE_INSMOD_I 7
/// Empty instruction. Used for internal calculations
#define CORE_INSMOD_DEAD 8
