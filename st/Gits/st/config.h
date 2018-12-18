//
//  ______  _____  _________   ______   _        ______   _______  ______  ______   _________  _____  ______   ______   _
// / |       | |  | | | | | \ | |  | \ | |      | |         | |   | |     | |  | \ | | | | | \  | |  | |  \ \ | |  | | | |
// '------.  | |  | | | | | | | |__|_/ | |   _  | |----     | |   | |---- | |__| | | | | | | |  | |  | |  | | | |__| | | |   _
//  ____|_/ _|_|_ |_| |_| |_| |_|      |_|__|_| |_|____     |_|   |_|____ |_|  \_\ |_| |_| |_| _|_|_ |_|  |_| |_|  |_| |_|__|_|
//

// => General --------------------------------------------------------{{{

// What program is execed by st depends of these precedence rules:
// 1: program passed with -e
// 2: utmp option
// 3: SHELL environment variable
// 4: value of shell in /etc/passwd
// 5: value of shell in config.h
static char *shell = "/bin/sh";
char *utmp = NULL;
char *stty_args = "stty raw pass8 nl -echo -iexten -cstopb 38400";

// identification sequence returned in DA and DECID
char *vtiden = "\033[?6c";

// Kerning / character bounding-box multipliers
static float cwscale = 1.0;
static float chscale = 1.0;

// word delimiter string
// More advanced example: " `'\"()[]{}"
char *worddelimiters = " ";

// selection timeouts (in milliseconds)
static unsigned int doubleclicktimeout = 300;
static unsigned int tripleclicktimeout = 600;

// alt screens
int allowaltscreen = 1;

// frames per second st should at maximum draw to the screen
static unsigned int xfps = 120;
static unsigned int actionfps = 30;

// st will set TERM variable with this value
static char *termname = "st-256color";

// }}}
// => UI -------------------------------------------------------------{{{

// font: see http://freedesktop.org/software/fontconfig/fontconfig-user.html
static char *font = "mono:pixelsize=16:antialias=true:autohint=true";
static int borderpx = 2;

// bell volume; must be in range [-100, 100]; 0 for disabling it
static int bellvolume = 0;

// thickness of underline and bar cursors
static unsigned int cursorthickness = 2;

// default shape of cursor
// 2: Block ("█")
// 4: Underline ("_")
// 6: Bar ("|")
// 7: Snowman ("☃")
static unsigned int cursorshape = 2;

// default columns and rows numbers
static unsigned int cols = 80;
static unsigned int rows = 24;

// }}}
// => Shortcuts ------------------------------------------------------{{{

// Internal mouse shortcuts.
// Beware that overloading Button1 will disable the selection.
static MouseShortcut mshortcuts[] = {
	/* button               mask            string */
	{ Button4,              XK_NO_MOD,      "\031" },
	{ Button5,              XK_NO_MOD,      "\005" },
};

// Internal keyboard shortcuts.
#define MODKEY Mod1Mask

MouseKey mkeys[] = {
	/* button               mask            function        argument */
	{ Button4,              ShiftMask,      kscrollup,      {.i =  1} },
	{ Button5,              ShiftMask,      kscrolldown,    {.i =  1} },
	{ Button4,              MODKEY,         kscrollup,      {.i =  1} },
	{ Button5,              MODKEY,         kscrolldown,    {.i =  1} },
	{ Button4,              MODKEY|ShiftMask,         zoom,      {.f =  +1} },
	{ Button5,              MODKEY|ShiftMask,         zoom,    {.f =  -1} },
};

static char *openurlcmd[] = { "/bin/sh", "-c",
    "xurls | dmenu -l 10 | xargs -r xdg-open",
    "externalpipe", NULL };

static Shortcut shortcuts[] = {
	/* mask                 keysym          function        argument */
	{ XK_ANY_MOD,           XK_Break,       sendbreak,      {.i =  0} },
	{ ControlMask,          XK_Print,       toggleprinter,  {.i =  0} },
	{ ShiftMask,            XK_Print,       printscreen,    {.i =  0} },
	{ XK_ANY_MOD,           XK_Print,       printsel,       {.i =  0} },
	{ MODKEY|ShiftMask,     XK_Prior,       zoom,           {.f = +1} },
	{ MODKEY|ShiftMask,     XK_Next,        zoom,           {.f = -1} },
	{ MODKEY,		XK_Home,	zoomreset,	{.f =  0} },
	{ ShiftMask,            XK_Insert,      clippaste,      {.i =  0} },
	{ MODKEY,               XK_c,           clipcopy,       {.i =  0} },
	{ MODKEY,               XK_v,           clippaste,      {.i =  0} },
	{ MODKEY,               XK_p,           selpaste,       {.i =  0} },
	{ MODKEY,		XK_Num_Lock,	numlock,	{.i =  0} },
	{ MODKEY,               XK_Control_L,   iso14755,       {.i =  0} },
	{ ShiftMask,            XK_Page_Up,     kscrollup,      {.i = -1} },
	{ ShiftMask,            XK_Page_Down,   kscrolldown,    {.i = -1} },
	{ MODKEY,               XK_Page_Up,     kscrollup,      {.i = -1} },
	{ MODKEY,               XK_Page_Down,   kscrolldown,    {.i = -1} },
    // deactivated to be able to use it in vim for moving line up/down
	// { MODKEY,            	XK_k,  		kscrollup,      {.i =  1} },
	// { MODKEY,            	XK_j,   	kscrolldown,    {.i =  1} },
	{ MODKEY,            	XK_Up,  	kscrollup,      {.i =  1} },
	{ MODKEY,            	XK_Down,   	kscrolldown,    {.i =  1} },
	{ MODKEY,	        XK_u,		kscrollup,      {.i = -1} },
	{ MODKEY,  		XK_d,		kscrolldown,   	{.i = -1} },
	{ MODKEY|ShiftMask,     XK_Up,          zoom,           {.f = +1} },
	{ MODKEY|ShiftMask,     XK_Down,        zoom,           {.f = -1} },
	{ MODKEY|ShiftMask,     XK_K,           zoom,           {.f = +1} },
	{ MODKEY|ShiftMask,     XK_J,           zoom,           {.f = -1} },
	{ MODKEY|ShiftMask,     XK_U,           zoom,           {.f = +2} },
	{ MODKEY|ShiftMask,     XK_D,           zoom,           {.f = -2} },
    	{ MODKEY,		XK_l,		externalpipe,	{ .v = openurlcmd } },
};

// Special keys (change & recompile st.info accordingly)
//
// Mask value:
// * Use XK_ANY_MOD to match the key no matter modifiers state
// * Use XK_NO_MOD to match the key alone (no modifiers)
// appkey value:
// * 0: no value
// * > 0: keypad application mode enabled
// *   = 2: term.numlock = 1
// * < 0: keypad application mode disabled
// appcursor value:
// * 0: no value
// * > 0: cursor application mode enabled
// * < 0: cursor application mode disabled
// crlf value
// * 0: no value
// * > 0: crlf mode is enabled
// * < 0: crlf mode is disabled
//
// Be careful with the order of the definitions because st searches in
// this table sequentially, so any XK_ANY_MOD must be in the last
// position for a key.

// If you want keys other than the X11 function keys (0xFD00 - 0xFFFF)
// to be mapped below, add them to this array.
static KeySym mappedkeys[] = { -1 };

// State bits to ignore when matching key or button events.  By default,
// numlock (Mod2Mask) and keyboard layout (XK_SWITCH_MOD) are ignored.
static uint ignoremod = Mod2Mask|XK_SWITCH_MOD;

// Override mouse-select while mask is active (when MODE_MOUSE is set).
// Note that if you want to use ShiftMask with selmasks, set this to an other
// modifier, set to 0 to not use it.
static uint forceselmod = ShiftMask;

// this is the huge key array which defines all compatibility to the linux
// world. please decide about changes wisely.
static key key[] = {
	/* keysym           mask            string      appkey appcursor */
	{ xk_kp_home,       shiftmask,      "\033[2j",       0,   -1},
	{ xk_kp_home,       shiftmask,      "\033[1;2h",     0,   +1},
	{ xk_kp_home,       xk_any_mod,     "\033[h",        0,   -1},
	{ xk_kp_home,       xk_any_mod,     "\033[1~",       0,   +1},
	{ xk_kp_up,         xk_any_mod,     "\033ox",       +1,    0},
	{ xk_kp_up,         xk_any_mod,     "\033[a",        0,   -1},
	{ xk_kp_up,         xk_any_mod,     "\033oa",        0,   +1},
	{ xk_kp_down,       xk_any_mod,     "\033or",       +1,    0},
	{ xk_kp_down,       xk_any_mod,     "\033[b",        0,   -1},
	{ xk_kp_down,       xk_any_mod,     "\033ob",        0,   +1},
	{ xk_kp_left,       xk_any_mod,     "\033ot",       +1,    0},
	{ xk_kp_left,       xk_any_mod,     "\033[d",        0,   -1},
	{ xk_kp_left,       xk_any_mod,     "\033od",        0,   +1},
	{ xk_kp_right,      xk_any_mod,     "\033ov",       +1,    0},
	{ xk_kp_right,      xk_any_mod,     "\033[c",        0,   -1},
	{ xk_kp_right,      xk_any_mod,     "\033oc",        0,   +1},
	{ xk_kp_prior,      shiftmask,      "\033[5;2~",     0,    0},
	{ xk_kp_prior,      xk_any_mod,     "\033[5~",       0,    0},
	{ xk_kp_begin,      xk_any_mod,     "\033[e",        0,    0},
	{ xk_kp_end,        controlmask,    "\033[j",       -1,    0},
	{ xk_kp_end,        controlmask,    "\033[1;5f",    +1,    0},
	{ xk_kp_end,        shiftmask,      "\033[k",       -1,    0},
	{ xk_kp_end,        shiftmask,      "\033[1;2f",    +1,    0},
	{ xk_kp_end,        xk_any_mod,     "\033[4~",       0,    0},
	{ xk_kp_next,       shiftmask,      "\033[6;2~",     0,    0},
	{ xk_kp_next,       xk_any_mod,     "\033[6~",       0,    0},
	{ xk_kp_insert,     shiftmask,      "\033[2;2~",    +1,    0},
	{ xk_kp_insert,     shiftmask,      "\033[4l",      -1,    0},
	{ xk_kp_insert,     controlmask,    "\033[l",       -1,    0},
	{ xk_kp_insert,     controlmask,    "\033[2;5~",    +1,    0},
	{ xk_kp_insert,     xk_any_mod,     "\033[4h",      -1,    0},
	{ xk_kp_insert,     xk_any_mod,     "\033[2~",      +1,    0},
	{ xk_kp_delete,     controlmask,    "\033[m",       -1,    0},
	{ xk_kp_delete,     controlmask,    "\033[3;5~",    +1,    0},
	{ xk_kp_delete,     shiftmask,      "\033[2k",      -1,    0},
	{ xk_kp_delete,     shiftmask,      "\033[3;2~",    +1,    0},
	{ xk_kp_delete,     xk_any_mod,     "\033[p",       -1,    0},
	{ xk_kp_delete,     xk_any_mod,     "\033[3~",      +1,    0},
	{ xk_kp_multiply,   xk_any_mod,     "\033oj",       +2,    0},
	{ xk_kp_add,        xk_any_mod,     "\033ok",       +2,    0},
	{ xk_kp_enter,      xk_any_mod,     "\033om",       +2,    0},
	{ xk_kp_enter,      xk_any_mod,     "\r",           -1,    0},
	{ xk_kp_subtract,   xk_any_mod,     "\033om",       +2,    0},
	{ xk_kp_decimal,    xk_any_mod,     "\033on",       +2,    0},
	{ xk_kp_divide,     xk_any_mod,     "\033oo",       +2,    0},
	{ xk_kp_0,          xk_any_mod,     "\033op",       +2,    0},
	{ xk_kp_1,          xk_any_mod,     "\033oq",       +2,    0},
	{ xk_kp_2,          xk_any_mod,     "\033or",       +2,    0},
	{ xk_kp_3,          xk_any_mod,     "\033os",       +2,    0},
	{ xk_kp_4,          xk_any_mod,     "\033ot",       +2,    0},
	{ xk_kp_5,          xk_any_mod,     "\033ou",       +2,    0},
	{ xk_kp_6,          xk_any_mod,     "\033ov",       +2,    0},
	{ xk_kp_7,          xk_any_mod,     "\033ow",       +2,    0},
	{ xk_kp_8,          xk_any_mod,     "\033ox",       +2,    0},
	{ xk_kp_9,          xk_any_mod,     "\033oy",       +2,    0},
	{ xk_up,            shiftmask,      "\033[1;2a",     0,    0},
	{ xk_up,            mod1mask,       "\033[1;3a",     0,    0},
	{ xk_up,         shiftmask|mod1mask,"\033[1;4a",     0,    0},
	{ xk_up,            controlmask,    "\033[1;5a",     0,    0},
	{ xk_up,      shiftmask|controlmask,"\033[1;6a",     0,    0},
	{ xk_up,       controlmask|mod1mask,"\033[1;7a",     0,    0},
	{ xk_up,shiftmask|controlmask|mod1mask,"\033[1;8a",  0,    0},
	{ xk_up,            xk_any_mod,     "\033[a",        0,   -1},
	{ xk_up,            xk_any_mod,     "\033oa",        0,   +1},
	{ xk_down,          shiftmask,      "\033[1;2b",     0,    0},
	{ xk_down,          mod1mask,       "\033[1;3b",     0,    0},
	{ xk_down,       shiftmask|mod1mask,"\033[1;4b",     0,    0},
	{ xk_down,          controlmask,    "\033[1;5b",     0,    0},
	{ xk_down,    shiftmask|controlmask,"\033[1;6b",     0,    0},
	{ xk_down,     controlmask|mod1mask,"\033[1;7b",     0,    0},
	{ xk_down,shiftmask|controlmask|mod1mask,"\033[1;8b",0,    0},
	{ xk_down,          xk_any_mod,     "\033[b",        0,   -1},
	{ xk_down,          xk_any_mod,     "\033ob",        0,   +1},
	{ xk_left,          shiftmask,      "\033[1;2d",     0,    0},
	{ xk_left,          mod1mask,       "\033[1;3d",     0,    0},
	{ xk_left,       shiftmask|mod1mask,"\033[1;4d",     0,    0},
	{ xk_left,          controlmask,    "\033[1;5d",     0,    0},
	{ xk_left,    shiftmask|controlmask,"\033[1;6d",     0,    0},
	{ xk_left,     controlmask|mod1mask,"\033[1;7d",     0,    0},
	{ xk_left,shiftmask|controlmask|mod1mask,"\033[1;8d",0,    0},
	{ xk_left,          xk_any_mod,     "\033[d",        0,   -1},
	{ xk_left,          xk_any_mod,     "\033od",        0,   +1},
	{ xk_right,         shiftmask,      "\033[1;2c",     0,    0},
	{ xk_right,         mod1mask,       "\033[1;3c",     0,    0},
	{ xk_right,      shiftmask|mod1mask,"\033[1;4c",     0,    0},
	{ xk_right,         controlmask,    "\033[1;5c",     0,    0},
	{ xk_right,   shiftmask|controlmask,"\033[1;6c",     0,    0},
	{ xk_right,    controlmask|mod1mask,"\033[1;7c",     0,    0},
	{ xk_right,shiftmask|controlmask|mod1mask,"\033[1;8c",0,   0},
	{ xk_right,         xk_any_mod,     "\033[c",        0,   -1},
	{ xk_right,         xk_any_mod,     "\033oc",        0,   +1},
	{ xk_iso_left_tab,  shiftmask,      "\033[z",        0,    0},
	{ xk_return,        mod1mask,       "\033\r",        0,    0},
	{ xk_return,        xk_any_mod,     "\r",            0,    0},
	{ xk_insert,        shiftmask,      "\033[4l",      -1,    0},
	{ xk_insert,        shiftmask,      "\033[2;2~",    +1,    0},
	{ xk_insert,        controlmask,    "\033[l",       -1,    0},
	{ xk_insert,        controlmask,    "\033[2;5~",    +1,    0},
	{ xk_insert,        xk_any_mod,     "\033[4h",      -1,    0},
	{ xk_insert,        xk_any_mod,     "\033[2~",      +1,    0},
	{ xk_delete,        controlmask,    "\033[m",       -1,    0},
	{ xk_delete,        controlmask,    "\033[3;5~",    +1,    0},
	{ xk_delete,        shiftmask,      "\033[2k",      -1,    0},
	{ xk_delete,        shiftmask,      "\033[3;2~",    +1,    0},
	{ xk_delete,        xk_any_mod,     "\033[p",       -1,    0},
	{ xk_delete,        xk_any_mod,     "\033[3~",      +1,    0},
	{ xk_backspace,     xk_no_mod,      "\177",          0,    0},
	{ xk_backspace,     mod1mask,       "\033\177",      0,    0},
	{ xk_home,          shiftmask,      "\033[2j",       0,   -1},
	{ xk_home,          shiftmask,      "\033[1;2h",     0,   +1},
	{ xk_home,          xk_any_mod,     "\033[h",        0,   -1},
	{ xk_home,          xk_any_mod,     "\033[1~",       0,   +1},
	{ xk_end,           controlmask,    "\033[j",       -1,    0},
	{ xk_end,           controlmask,    "\033[1;5f",    +1,    0},
	{ xk_end,           shiftmask,      "\033[k",       -1,    0},
	{ xk_end,           shiftmask,      "\033[1;2f",    +1,    0},
	{ xk_end,           xk_any_mod,     "\033[4~",       0,    0},
	{ xk_prior,         controlmask,    "\033[5;5~",     0,    0},
	{ xk_prior,         shiftmask,      "\033[5;2~",     0,    0},
	{ xk_prior,         xk_any_mod,     "\033[5~",       0,    0},
	{ xk_next,          controlmask,    "\033[6;5~",     0,    0},
	{ xk_next,          shiftmask,      "\033[6;2~",     0,    0},
	{ xk_next,          xk_any_mod,     "\033[6~",       0,    0},
	{ xk_f1,            xk_no_mod,      "\033op" ,       0,    0},
	{ xk_f1, /* f13 */  shiftmask,      "\033[1;2p",     0,    0},
	{ xk_f1, /* f25 */  controlmask,    "\033[1;5p",     0,    0},
	{ xk_f1, /* f37 */  mod4mask,       "\033[1;6p",     0,    0},
	{ xk_f1, /* f49 */  mod1mask,       "\033[1;3p",     0,    0},
	{ xk_f1, /* f61 */  mod3mask,       "\033[1;4p",     0,    0},
	{ xk_f2,            xk_no_mod,      "\033oq" ,       0,    0},
	{ xk_f2, /* f14 */  shiftmask,      "\033[1;2q",     0,    0},
	{ xk_f2, /* f26 */  controlmask,    "\033[1;5q",     0,    0},
	{ xk_f2, /* f38 */  mod4mask,       "\033[1;6q",     0,    0},
	{ xk_f2, /* f50 */  mod1mask,       "\033[1;3q",     0,    0},
	{ xk_f2, /* f62 */  mod3mask,       "\033[1;4q",     0,    0},
	{ xk_f3,            xk_no_mod,      "\033or" ,       0,    0},
	{ xk_f3, /* f15 */  shiftmask,      "\033[1;2r",     0,    0},
	{ xk_f3, /* f27 */  controlmask,    "\033[1;5r",     0,    0},
	{ xk_f3, /* f39 */  mod4mask,       "\033[1;6r",     0,    0},
	{ xk_f3, /* f51 */  mod1mask,       "\033[1;3r",     0,    0},
	{ xk_f3, /* f63 */  mod3mask,       "\033[1;4r",     0,    0},
	{ xk_f4,            xk_no_mod,      "\033os" ,       0,    0},
	{ xk_f4, /* f16 */  shiftmask,      "\033[1;2s",     0,    0},
	{ xk_f4, /* f28 */  controlmask,    "\033[1;5s",     0,    0},
	{ xk_f4, /* f40 */  mod4mask,       "\033[1;6s",     0,    0},
	{ xk_f4, /* f52 */  mod1mask,       "\033[1;3s",     0,    0},
	{ xk_f5,            xk_no_mod,      "\033[15~",      0,    0},
	{ xk_f5, /* f17 */  shiftmask,      "\033[15;2~",    0,    0},
	{ xk_f5, /* f29 */  controlmask,    "\033[15;5~",    0,    0},
	{ xk_f5, /* f41 */  mod4mask,       "\033[15;6~",    0,    0},
	{ xk_f5, /* f53 */  mod1mask,       "\033[15;3~",    0,    0},
	{ xk_f6,            xk_no_mod,      "\033[17~",      0,    0},
	{ xk_f6, /* f18 */  shiftmask,      "\033[17;2~",    0,    0},
	{ xk_f6, /* f30 */  controlmask,    "\033[17;5~",    0,    0},
	{ xk_f6, /* f42 */  mod4mask,       "\033[17;6~",    0,    0},
	{ xk_f6, /* f54 */  mod1mask,       "\033[17;3~",    0,    0},
	{ xk_f7,            xk_no_mod,      "\033[18~",      0,    0},
	{ xk_f7, /* f19 */  shiftmask,      "\033[18;2~",    0,    0},
	{ xk_f7, /* f31 */  controlmask,    "\033[18;5~",    0,    0},
	{ xk_f7, /* f43 */  mod4mask,       "\033[18;6~",    0,    0},
	{ xk_f7, /* f55 */  mod1mask,       "\033[18;3~",    0,    0},
	{ xk_f8,            xk_no_mod,      "\033[19~",      0,    0},
	{ xk_f8, /* f20 */  shiftmask,      "\033[19;2~",    0,    0},
	{ xk_f8, /* f32 */  controlmask,    "\033[19;5~",    0,    0},
	{ xk_f8, /* f44 */  mod4mask,       "\033[19;6~",    0,    0},
	{ xk_f8, /* f56 */  mod1mask,       "\033[19;3~",    0,    0},
	{ xk_f9,            xk_no_mod,      "\033[20~",      0,    0},
	{ xk_f9, /* f21 */  shiftmask,      "\033[20;2~",    0,    0},
	{ xk_f9, /* f33 */  controlmask,    "\033[20;5~",    0,    0},
	{ xk_f9, /* f45 */  mod4mask,       "\033[20;6~",    0,    0},
	{ xk_f9, /* f57 */  mod1mask,       "\033[20;3~",    0,    0},
	{ xk_f10,           xk_no_mod,      "\033[21~",      0,    0},
	{ xk_f10, /* f22 */ shiftmask,      "\033[21;2~",    0,    0},
	{ xk_f10, /* f34 */ controlmask,    "\033[21;5~",    0,    0},
	{ xk_f10, /* f46 */ mod4mask,       "\033[21;6~",    0,    0},
	{ xk_f10, /* f58 */ mod1mask,       "\033[21;3~",    0,    0},
	{ xk_f11,           xk_no_mod,      "\033[23~",      0,    0},
	{ xk_f11, /* f23 */ shiftmask,      "\033[23;2~",    0,    0},
	{ xk_f11, /* f35 */ controlmask,    "\033[23;5~",    0,    0},
	{ xk_f11, /* f47 */ mod4mask,       "\033[23;6~",    0,    0},
	{ xk_f11, /* f59 */ mod1mask,       "\033[23;3~",    0,    0},
	{ xk_f12,           xk_no_mod,      "\033[24~",      0,    0},
	{ xk_f12, /* f24 */ shiftmask,      "\033[24;2~",    0,    0},
	{ xk_f12, /* f36 */ controlmask,    "\033[24;5~",    0,    0},
	{ xk_f12, /* f48 */ mod4mask,       "\033[24;6~",    0,    0},
	{ xk_f12, /* f60 */ mod1mask,       "\033[24;3~",    0,    0},
	{ xk_f13,           xk_no_mod,      "\033[1;2p",     0,    0},
	{ xk_f14,           xk_no_mod,      "\033[1;2q",     0,    0},
	{ xk_f15,           xk_no_mod,      "\033[1;2r",     0,    0},
	{ xk_f16,           xk_no_mod,      "\033[1;2s",     0,    0},
	{ xk_f17,           xk_no_mod,      "\033[15;2~",    0,    0},
	{ xk_f18,           xk_no_mod,      "\033[17;2~",    0,    0},
	{ xk_f19,           xk_no_mod,      "\033[18;2~",    0,    0},
	{ xk_f20,           xk_no_mod,      "\033[19;2~",    0,    0},
	{ xk_f21,           xk_no_mod,      "\033[20;2~",    0,    0},
	{ xk_f22,           xk_no_mod,      "\033[21;2~",    0,    0},
	{ xk_f23,           xk_no_mod,      "\033[23;2~",    0,    0},
	{ xk_f24,           xk_no_mod,      "\033[24;2~",    0,    0},
	{ xk_f25,           xk_no_mod,      "\033[1;5p",     0,    0},
	{ xk_f26,           xk_no_mod,      "\033[1;5q",     0,    0},
	{ xk_f27,           xk_no_mod,      "\033[1;5r",     0,    0},
	{ xk_f28,           xk_no_mod,      "\033[1;5s",     0,    0},
	{ xk_f29,           xk_no_mod,      "\033[15;5~",    0,    0},
	{ xk_f30,           xk_no_mod,      "\033[17;5~",    0,    0},
	{ xk_f31,           xk_no_mod,      "\033[18;5~",    0,    0},
	{ xk_f32,           xk_no_mod,      "\033[19;5~",    0,    0},
	{ xk_f33,           xk_no_mod,      "\033[20;5~",    0,    0},
	{ xk_f34,           xk_no_mod,      "\033[21;5~",    0,    0},
	{ xk_f35,           xk_no_mod,      "\033[23;5~",    0,    0},
};

// Selection types' masks.
// Use the same masks as usual.
// Button1Mask is always unset, to make masks match between ButtonPress.
// ButtonRelease and MotionNotify.
// If no match is found, regular selection is used.
static uint selmasks[] = {
	[SEL_RECTANGULAR] = Mod1Mask,
};

// Printable characters in ASCII, used to estimate the advance width
// of single wide characters.
static char ascii_printable[] =
	" !\"#$%&'()*+,-./0123456789:;<=>?"
	"@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_"
	"`abcdefghijklmnopqrstuvwxyz{|}~";

// }}}
// => Colors ---------------------------------------------------------{{{

 // bg opacity
unsigned int alpha = 0xed;

static const char *colorname[] = {
	"#282828", /* hard contrast: #1d2021 / soft contrast: #32302f */
	"#cc241d",
	"#98971a",
	"#d79921",
	"#458588",
	"#b16286",
	"#689d6a",
	"#a89984",
	"#928374",
	"#fb4934",
	"#b8bb26",
	"#fabd2f",
	"#83a598",
	"#d3869b",
	"#8ec07c",
	"#ebdbb2",
	[255] = 0,
	/* more colors can be added after 255 to use with DefaultXX */
	"black",   /* 256 -> bg */
	"white",   /* 257 -> fg */
};


// Default colors (colorname index)
// foreground, background, cursor, reverse cursor
unsigned int defaultfg = 15;
unsigned int defaultbg = 0;
static unsigned int defaultcs = 15;
static unsigned int defaultrcs = 0;

// Default colour and shape of the mouse cursor
static unsigned int mouseshape = XC_xterm;
static unsigned int mousefg = 7;
static unsigned int mousebg = 0;

// Color used to display font attributes when fontconfig selected a font which
// doesn't match the ones requested.
static unsigned int defaultattr = 11;

// }}}
// => Xresources -----------------------------------------------------{{{

// Xresources preferences to load at startup
ResourcePref resources[] = {
		{ "font",         STRING,  &font },
		{ "color0",       STRING,  &colorname[0] },
		{ "color1",       STRING,  &colorname[1] },
		{ "color2",       STRING,  &colorname[2] },
		{ "color3",       STRING,  &colorname[3] },
		{ "color4",       STRING,  &colorname[4] },
		{ "color5",       STRING,  &colorname[5] },
		{ "color6",       STRING,  &colorname[6] },
		{ "color7",       STRING,  &colorname[7] },
		{ "color8",       STRING,  &colorname[8] },
		{ "color9",       STRING,  &colorname[9] },
		{ "color10",      STRING,  &colorname[10] },
		{ "color11",      STRING,  &colorname[11] },
		{ "color12",      STRING,  &colorname[12] },
		{ "color13",      STRING,  &colorname[13] },
		{ "color14",      STRING,  &colorname[14] },
		{ "color15",      STRING,  &colorname[15] },
		{ "background",   STRING,  &colorname[256] },
		{ "foreground",   STRING,  &colorname[257] },
		{ "cursorColor",  STRING,  &colorname[258] },
		{ "termname",     STRING,  &termname },
		{ "shell",        STRING,  &shell },
		{ "xfps",         INTEGER, &xfps },
		{ "actionfps",    INTEGER, &actionfps },
		{ "blinktimeout", INTEGER, &blinktimeout },
		{ "bellvolume",   INTEGER, &bellvolume },
		{ "tabspaces",    INTEGER, &tabspaces },
		{ "cwscale",      FLOAT,   &cwscale },
		{ "chscale",      FLOAT,   &chscale },
		{ "alpha",      INTEGER,   &alpha },
};

// }}}
// => Unsorted -------------------------------------------------------{{{
// blinking timeout (set to 0 to disable blinking) for the terminal blinking
// attribute.
static unsigned int blinktimeout = 800;

// spaces per tab
//
// When you are changing this value, don't forget to adapt the »it« value in
// the st.info and appropriately install the st.info in the environment where
// you use this st version.
//
//     it#$tabspaces,
//
// Secondly make sure your kernel is not expanding tabs. When running `stty
// -a` »tab0« should appear. You can tell the terminal to not expand tabs by
//  running following command:
//
//     stty tabs
unsigned int tabspaces = 8;

// }}}
