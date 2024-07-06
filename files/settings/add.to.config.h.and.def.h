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
