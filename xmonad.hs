import XMonad
import XMonad.Wallpaper
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.TwoPane (TwoPane(..))
import XMonad.Layout.Tabbed (simpleTabbed)
import XMonad.Layout.Spacing


--  setrandomwallpaper ["$home/photo/wall"]
import XMonad
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.EwmhDesktops

--smartBorders $ layoutHook defaultConfig

-- myLayoutHook =
--   smartBorders $ -- layouts begin below
--   noBorders Full
--   ||| Tall 1 10/100 60/100
--   ||| TwoPane 15/100 55/100
--   ||| Mirror (Tall 1 10/100 60/100)
--   ||| Grid
--   ||| simpleTabbed

-- myLayoutHook = spacing 10 $ Tall (1 (3/100) (1/2)) ||| Full
myLayoutHook = smartSpacing 7 $ Tall 1 (3/100) (1/2) ||| Mirror (Tall 1 (3/100) (1/2)) ||| Grid ||| noBorders Full

myConfig = def
  { terminal    = "xfce4-terminal" -- for Mod + Shift + Enter
  , borderWidth = 3
  , handleEventHook = fullscreenEventHook
  , modMask = mod4Mask
  , layoutHook = smartBorders $ myLayoutHook
  }

-- main = xmonad =<< xmobar myConfig
main = do
  setRandomWallpaper ["$HOME/photo/wall"]
  xmonad =<< xmobar myConfig
