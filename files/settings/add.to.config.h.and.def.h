////////////////////////////    KEYBOARD KNOB VOLUME CONTROL
/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* commands */
static const char *volumeupcmd[]   = { "pamixer", "--increase", "5", NULL };
static const char *volumedowncmd[] = { "pamixer", "--decrease", "5", NULL };
static const char *volumemutecmd[] = { "pamixer", "--toggle-mute", NULL };

/* key bindings */
static Key keys[] = {
    /* modifier           key        function        argument */
    ...
    { 0, XF86XK_AudioLowerVolume,   spawn,      {.v = volumedowncmd } },
    { 0, XF86XK_AudioRaiseVolume,   spawn,      {.v = volumeupcmd } },
    { 0, XF86XK_AudioMute,          spawn,      {.v = volumemutecmd } },
    ...
};

////////////////////////////    DO NOT USE BOTH AT THE SAME TIME
/* Light Mode */
static const char *colors[][3] = {
    // color           fg         bg
    [SchemeNorm] = { "#bbbbbb", "#222222", "#005577" },
    [SchemeSel]  = { "#eeeeee", "#005577", "#ffffff" },
};

/* Dark Mode */
static const char *colors[][3] = {
    // color           fg         bg
    [SchemeNorm] = { "#bbbbbb", "#000000", "#222222" },
    [SchemeSel]  = { "#eeeeee", "#005577", "#444444" },
};



////////////////////////// DWM CONFIG FILE
// Add the Rofi command
static const char *rofircmd[]  = { "rofi", "-show", "drun", NULL };

// Key bindings
static Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
    { MODKEY,                       XK_a,      spawn,          {.v = rofircmd } },
    // Other key bindings...
};
