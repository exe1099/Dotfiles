//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	/* {"", "cat /tmp/recordingicon 2>/dev/null",	0,	9}, */
	/* {"",	"music",	0,	11}, */
	/*{"",	"pacpackages",	0,	8}, */
	/*{"",	"news",		0,	6}, */
	/* {"",	"crypto",	0,	13}, */
	/* {"",	"price bat \"Basic Attention Token\" 🦁",	0,	20}, */
	/* {"",	"price btc Bitcoin 💰",				0,	21}, */
	/* {"",	"price lbc \"LBRY Token\" 📚",			0,	22}, */
	/* {"",	"torrent",	20,	7}, */
	/* {"",	"memory",	10,	14}, */
	/* {"",	"moonphase",	18000,	17}, */
	/* {"",	"weather",	18000,	5}, */
	/* {"",	"mailbox",	180,	12}, */
    {"   ",	"",	5,	11},
	{" ",	"volume",	0,	10},
	{"",	"battery",	5,	12},
    {" ",	"cpu_usage",		10,	13},
    {" ",	"temperature",	5,	14},
	{"",	"calendar",	1,	1},
    {"",	"",	0,	15},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char *delim = "  ";
