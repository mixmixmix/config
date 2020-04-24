import XMonad
import XMonad.Wallpaper
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog


--  setrandomwallpaper ["$home/photo/wall"]
import XMonad
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.TwoPane (TwoPane(..))
import XMonad.Layout.Tabbed (simpleTabbed)


myLayoutHook =
  smartBorders $ -- layouts begin below
  noBorders Full
--  ||| Tall 1 10/100 60/100
--  ||| TwoPane 15/100 55/100
--  ||| Mirror (Tall 1 10/100 60/100)
--  ||| Grid
--  ||| simpleTabbed
--  -- ...

myConfig = def
  { terminal    = "xfce4-terminal" -- for Mod + Shift + Enter
  , borderWidth = 1
  , handleEventHook    = fullscreenEventHook
  , layoutHook = myLayoutHook
  }

-- main = xmonad =<< xmobar myConfig
main = do
  setRandomWallpaper ["$HOME/photo/wall"]
  xmonad =<< xmobar myConfig
