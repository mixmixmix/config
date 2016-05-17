import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome

main = xmonad defaultConfig
	{ borderWidth = 2 
	, modMask = mod4Mask
	, terminal = myTerminal
	}

myTerminal :: String
myTerminal = "gnome-terminal"
