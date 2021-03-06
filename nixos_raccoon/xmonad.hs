import XMonad
import XMonad.Wallpaper
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog


--  setrandomwallpaper ["$home/photo/wall"]
import XMonad
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.EwmhDesktops

myConfig = def
  { terminal    = "xfce4-terminal" -- for Mod + Shift + Enter
  , borderWidth = 1
  , handleEventHook    = fullscreenEventHook
  , modMask = mod4Mask
  }

-- main = xmonad =<< xmobar myConfig
main = do
  setRandomWallpaper ["$HOME/photo/wall"]
  xmonad =<< xmobar myConfig
