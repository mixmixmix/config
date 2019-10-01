import XMonad
import XMonad.Wallpaper
import XMonad.Hooks.DynamicLog


--  setRandomWallpaper ["$HOME/photo/wall"]
import XMonad
import XMonad.Hooks.DynamicLog (xmobar)
 
myConfig = def
  { terminal    = "xfce4-terminal" -- for Mod + Shift + Enter
  , borderWidth = 3
  }
 
main = xmonad =<< xmobar myConfig
