// SCiPnet module-configuration values. Do not change these. If you need to add another use larger number (5..6..7 etc)
/// Downloads of software from SCiPnet
#define NTNET_SOFTWAREDOWNLOAD 1
/// P2P transfers of files between devices
#define NTNET_PEERTOPEER 2
/// Communication (messaging)
#define NTNET_COMMUNICATION 3
/// Control of various systems, RCon, air alarm control, etc.
#define NTNET_SYSTEMCONTROL 4

// SCiPnet transfer speeds, used when downloading/uploading a file/program.
/// GQ/s transfer speed when the device is wirelessly connected and on Low signal
#define NTNETSPEED_LOWSIGNAL 0.5
/// GQ/s transfer speed when the device is wirelessly connected and on High signal
#define NTNETSPEED_HIGHSIGNAL 1
/// GQ/s transfer speed when the device is using wired connection
#define NTNETSPEED_ETHERNET 2
/// Multiplier for Denial of Service program. Resulting load on SCiPnet relay is this multiplied by NTNETSPEED of the device
#define NTNETSPEED_DOS_AMPLIFICATION 5

// Program bitflags
#define PROGRAM_ALL 		(~0)
#define PROGRAM_CONSOLE 	(1<<0)
#define PROGRAM_LAPTOP 		(1<<1)
#define PROGRAM_TABLET 		(1<<2)
#define PROGRAM_TELESCREEN 	(1<<3)
#define PROGRAM_PDA 		(1<<4)

// Program states
#define PROGRAM_STATE_KILLED 		0
#define PROGRAM_STATE_BACKGROUND 	1
#define PROGRAM_STATE_ACTIVE 		2

// Data block sizes (data is divided by this to get file size)
#define BLOCK_SIZE_DATA		2000
#define BLOCK_SIZE_NEWS		5000

// Caps for SCiPnet logging. Less than 10 would make logging useless anyway, more than 500 may make the log browser too laggy. Defaults to 100 unless user changes it.
#define MAX_NTNET_LOGS 500
#define MIN_NTNET_LOGS 10

//Built-in email accounts
#define EMAIL_DOCUMENTS "document.server@internal-services.net"
#define EMAIL_SYSADMIN  "admin@internal-services.net"
#define EMAIL_BROADCAST "broadcast@internal-services.net"
#define EMAIL_BROADCAST_ENG "broadcast_engineering@internal-services.net"
#define EMAIL_BROADCAST_SEC "broadcast_security@internal-services.net"
#define EMAIL_BROADCAST_MED	"broadcast_medical@internal-services.net"
#define EMAIL_BROADCAST_SCI	"broadcast_research@internal-services.net"
#define EMAIL_BROADCAST_CIV	"broadcast_civilian@internal-services.net"
#define EMAIL_BROADCAST_COM	"broadcast_administration@internal-services.net"
#define EMAIL_BROADCAST_SRV	"broadcast_service@internal-services.net"
#define EMAIL_BROADCAST_SUP	"broadcast_logistics@internal-services.net"
#define EMAIL_BROADCAST_LCZ "broadcast_lcz-security@internal-services.net"
#define EMAIL_BROADCAST_HCZ "broadcast_hcz-security@internal-services.net"
#define EMAIL_BROADCAST_ECZ "broadcast_ez-security@internal-services.net"
