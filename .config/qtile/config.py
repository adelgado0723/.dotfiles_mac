# -*- coding: utf-8 -*-
import os

import socket
import subprocess
from sys import prefix
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen

from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy

from typing import List  # noqa: F401from typing import List  # noqa: F401
from Xlib import display as xdisplay


mod = "mod4"  # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"  # My terminal of choice
myBrowser = "brave"  # My browser of choice
myMusicPlayer = "rhythmbox"
myChatApp = "slack"
myDBApp = "mongodb-compass"

keys = [
    # The essentials
    Key([mod], "Return", lazy.spawn(myTerm + " -e zsh"), desc="Launches My Terminal"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.spawn("dmenu_run -l 20 -p 'Run: '"),
        desc="Run Launcher",
    ),
    Key(
        [mod, "shift"],
        "d",
        lazy.spawn("j4-dmenu-desktop --dmenu='dmenu'"),
        desc="j4-dmenu-desktop",
    ),
    Key([mod], "b", lazy.spawn(myBrowser), desc="Brave"),
    Key([mod, "shift"], "m", lazy.spawn(myMusicPlayer), desc="Rhythmbox"),
    Key([mod, "shift"], "c", lazy.spawn("discord"), desc="Discord"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle through layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill active window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key(["control", "shift"], "v", lazy.cmd_spawn(myTerm + " -e nvim"), desc="Neovim"),
    ### Switch focus to specific monitor (out of three)
    Key([mod], "w", lazy.to_screen(0), desc="Keyboard focus to monitor 1"),
    Key([mod], "e", lazy.to_screen(1), desc="Keyboard focus to monitor 2"),
    Key([mod], "r", lazy.to_screen(2), desc="Keyboard focus to monitor 3"),
    ### Switch focus of monitors
    Key([mod], "period", lazy.next_screen(), desc="Move focus to next monitor"),
    Key([mod], "comma", lazy.prev_screen(), desc="Move focus to prev monitor"),
    ### Treetab controls
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.move_left(),
        desc="Move up a section in treetab",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.move_right(),
        desc="Move down a section in treetab",
    ),
    ### Window controls
    Key([mod], "j", lazy.layout.down(), desc="Move focus down in current stack pane"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up in current stack pane"),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc="Move windows down in current stack",
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc="Move windows up in current stack",
    ),
    Key(
        [mod],
        "h",
        lazy.layout.shrink(),
        lazy.layout.decrease_nmaster(),
        desc="Shrink window (MonadTall), decrease number in master pane (Tile)",
    ),
    Key(
        [mod],
        "l",
        lazy.layout.grow(),
        lazy.layout.increase_nmaster(),
        desc="Expand window (MonadTall), increase number in master pane (Tile)",
    ),
    Key([mod], "n", lazy.layout.normalize(), desc="normalize window size ratios"),
    Key(
        [mod],
        "m",
        lazy.layout.maximize(),
        desc="toggle window between minimum and maximum sizes",
    ),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="toggle floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="toggle fullscreen"),
    ### Stack controls
    Key(
        [mod, "shift"],
        "Tab",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc="Switch which side main pane occupies (XmonadTall)",
    ),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack",
    ),
    Key(
        [mod, "shift"],
        "space",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    #    Key(
    #        [mod, "shift"],
    #        "w",
    #        # qtile.cmd_spawn("$HOME/scripts/setRandomWallpaper.sh"),
    #        lazy.spawn("/home/adelg/scripts/setRandomWallpaper.sh"),
    #        desc="change wallpapers",
    #    ),
    #
    # system scripts SUPER + a
    KeyChord(
        [mod],
        "a",
        [
            Key(
                [],
                "w",
                lazy.spawn("setRandomWallpaper"),
                desc="change wallpapers",
            ),
            Key(
                [],
                "s",
                lazy.spawn("flameshot gui"),
                desc="screenshot",
            ),
            Key([], "e", lazy.spawn(myTerm + " -e fzf-emoji"), desc="emoji picker"),
        ],
    ),
    # Keybindings for work
    KeyChord(
        [mod],
        "w",
        [
            Key([], "c", lazy.spawn(myChatApp), desc="Slack"),
            Key([], "d", lazy.spawn(myDBApp), desc="Compass"),
            Key([], "p", lazy.spawn("postman"), desc="Postman"),
        ],
    ),
    # Dmenu scripts launched using the key chord SUPER+p followed by 'key'
    KeyChord(
        [mod],
        "p",
        [
            Key(
                [],
                "e",
                lazy.spawn("dm-confedit"),
                desc="Choose a config file to edit",
            ),
            Key(
                [],
                "i",
                lazy.spawn("dm-maim"),
                desc="Take screenshots via dmenu",
            ),
            Key(
                [],
                "o",
                lazy.spawn("dm-emoji"),
                desc="Select emoji to insert",
            ),
            Key(
                [],
                "n",
                lazy.spawn("dm-icons"),
                desc="Select Nerd Font icon to insert",
            ),
            Key(
                [],
                "k",
                lazy.spawn("dm-kill"),
                desc="Kill processes via dmenu",
            ),
            Key([], "l", lazy.spawn("dm-logout"), desc="A logout menu"),
            Key(
                [],
                "m",
                lazy.spawn("dm-man"),
                desc="Search manpages in dmenu",
            ),
            Key(
                [],
                "r",
                lazy.spawn("dm-reddit"),
                desc="Search reddit via dmenu",
            ),
            Key(
                [],
                "s",
                lazy.spawn("dm-websearch"),
                desc="Search various search engines via dmenu",
            ),
            Key([], "p", lazy.spawn("passmenu"), desc="Retrieve passwords with dmenu"),
        ],
    ),
]

colors = {
    "background": ["#4d5b86", "#44475a"],  # Background 0
    "foreground": ["#f8f8f2", "#f8f8f2"],  # foreground (white) 1
    "lighter_gray": ["#44475a", "#44475a"],  # lighter gray 2
    "green": ["#50fa7b", "#50fa7b"],  # green 3
    "orange": ["#ffb86c", "#ffb86c"],  # orange 4
    "black": ["#000000", "#000000"],  # black 5
    "red": ["#ff5555", "#ff5555"],  # red 6
    "yellow": ["#f1fa8c", "#f1fa8c"],  # yellow 7
    "gradient_purple": ["#bd93f9", "#4d5b86"],  # gradient purple 8
    "magenta": ["#ff79c6", "#ff79c6"],  # magenta 9
    "cyan": ["#8be9fd", "#8be9fd"],  # cyan 10
    "light_gray": ["#bfbfbf", "#bfbfbf"],  # light gray 11
    "light_purple": ["#bd93f9", "#bd93f9"],  # light purple
}

groups = [
    Group("", layout="monadtall"),
    Group("", layout="monadtall"),
    Group("﬐", layout="monadtall"),
    Group("", layout="monadtall"),
    Group("", layout="monadtall"),
    Group("漣", layout="monadtall"),
    Group("ﱘ", layout="monadtall"),
    Group("", layout="monadtall"),
    Group("", layout="monadtall"),
]
# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder

dgroups_key_binder = simple_key_binder("mod4")

layout_theme = {
    "border_width": 2,
    "margin": 2,
    "border_focus": colors["green"][0],
    "border_normal": colors["background"][0],
}

layouts = [
    # layout.MonadWide(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Stack(stacks=2, **layout_theme),
    # layout.Columns(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Stack(num_stacks=2),
    layout.RatioTile(**layout_theme),
    layout.TreeTab(
        font="Hack Nerd Font Mono",
        fontsize=12,
        sections=["FIRST", "SECOND", "THIRD", "FOURTH"],
        section_fontsize=12,
        border_width=2,
        bg_color="282a36",
        active_bg="282a36",
        active_fg="f1fa8c",
        inactive_bg="14151b",
        inactive_fg="ebf85d",
        padding_left=0,
        padding_x=0,
        padding_y=5,
        section_top=10,
        section_bottom=20,
        level_shift=8,
        vspace=3,
        panel_width=200,
    ),
    # layout.Floating(layout_theme),
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Hack Nerd Font Mono Bold",
    fontsize=16,
    padding=3,
    background=colors["background"],
    # foreground=colors["light_purple"],
    foreground=colors["cyan"],
)

seperator_foreground = colors["gradient_purple"]

extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.Sep(linewidth=0, padding=12, foreground=colors["lighter_gray"], background=colors["background"]),
        widget.Image(
            filename="~/.config/qtile/icons/code-100.png",
            scale="True",
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(myTerm)},
            padding=0,
        ),
        widget.Sep(linewidth=0, padding=6, foreground=colors["lighter_gray"]),
        widget.GroupBox(
            font="Hack Nerd Font Mono",
            fontsize=30,
            # margin_y=3,
            # margin_x=5,
            # padding_y=5,
            # padding_x=3,
            margin_y=4,
            margin_x=2,
            padding_y=2,
            padding_x=2,
            borderwidth=2,
            active=colors["yellow"],
            inactive=colors["foreground"],
            rounded=False,
            highlight_color=colors["black"],
            highlight_method="line",
            this_current_screen_border=colors["cyan"],
            this_screen_border=colors["green"],
            other_current_screen_border=colors["magenta"],
            other_screen_border=colors["orange"],
            foreground=colors["foreground"],
        ),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=3, fontsize=14
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            padding=0,
            scale=0.7,
        ),
        widget.CurrentLayout(foreground=colors["orange"], padding=5),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=5, fontsize=14
        ),
        widget.WindowName(foreground=colors["foreground"], padding=0),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=0, fontsize=14
        ),
        widget.CheckUpdates(
            update_interval=1800,
            distro="Ubuntu",
            display_format=" {updates} ",
            colour_have_updates=colors["red"],
            colour_no_updates=colors["green"],
            execute="alacritty -e updateAndUpgrade",
            no_update_string="",
        ),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=5, fontsize=14
        ),
        widget.Net(
            interface="wlp0s20f3",
            format="↓{down}  ↑{up}",
        ),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=0, fontsize=14
        ),
        widget.ThermalSensor(
            threshold=150,
            fmt=" {}",
            metric=False,
            foreground=colors["green"],
            foreground_alert=colors["red"],
        ),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=0, fontsize=14
        ),
        widget.Memory(
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    myTerm + " -e /home/adelg/scripts/htopWithSound.sh"
                )
            },
            fmt="{}",
        ),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=0, fontsize=14
        ),
        widget.CPU(
            format=" {load_percent}%",
            foreground=colors["orange"],
        ),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=0, fontsize=14
        ),
        widget.Pomodoro(
            color_active=colors["orange"],
            color_break=colors["red"],
            color_inactive=colors["light_purple"],
            prefix_inactive="🍅",
            prefix_paused="",
        ),
        widget.Volume(
            fmt="{}",
            emoji=True,
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    "sh /home/adelg/scripts/muteWithSound.sh"
                )
            },
            padding=0,
        ),
        # widget.TextBox(
        #     text="|", foreground=seperator_foreground, padding=0, fontsize=14
        # ),
        widget.Systray(
            # background=colors[0],
            # foreground=colors[9],
        ),
        # widget.BatteryIcon(
        #     mouse_callbacks={
        #         "Button1": lambda: qtile.cmd_spawn(
        #             "sh /home/adelg/scripts/notify-send/getBatteryLevel.sh"
        #         )
        #     },
        # ),
        widget.TextBox(
            text="|", foreground=seperator_foreground, padding=0, fontsize=14
        ),
        widget.Clock(format="%B %d - %H:%M ", foreground=colors["green"]),
    ]
    return widgets_list


def get_num_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    if get_num_monitors() > 1:
        del widgets_screen2[22:23]
        # for i, tmpWidget in enumerate(widgets_screen1):
        #     os.system("/usr/bin/notify-send test " + str(i) + " " + str(tmpWidget))

    return widgets_screen2  # Monitor 2 will display all widgets in widgets_list


def init_screens():
    return [
        Screen(bottom=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=30)),
        Screen(bottom=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=30)),
        Screen(bottom=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=30)),
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        # default_float_rules include: utility, notification, toolbar, splash, dialog,
        # file_progress, confirm, download and error.
        *layout.Floating.default_float_rules,
        Match(title="Confirmation"),  # tastyworks exit box
        Match(title="Qalculate!"),  # qalculate-gtk
        Match(title="Zoom"),  # qalculate-gtk
        Match(title="OBS"),  # obs -- not working
        Match(wm_class="kdenlive"),  # kdenlive
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


@hook.subscribe.startup
def start():
    subprocess.call(["key-config"])
    subprocess.call(["alsactl --file ~/.config/alsa/state restore"])


# Reloads config on arandar screen change, but takes forever to complete
# @hook.subscribe.screen_change
# def restart_on_randr(_):
# qtile.cmd_reload_config()


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
