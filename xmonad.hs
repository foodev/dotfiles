import XMonad
import XMonad.Config.Xfce
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe, hPutStrLn)
import XMonad.Util.WorkspaceCompare
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.IndependentScreens
import XMonad.Layout.NoBorders
import XMonad.Layout.Simplest
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import Data.Ratio ((%))

xmobarBinary = "/usr/bin/xmobar"
xmobarrc = "/home/jonas/.xmobarrc"

xmobarFontFace = "Fantasque Sans Mono" -- "xft:Source Code Pro:size=9"
xmobarFontSize = 11

normalColor = "#657b83"
focusedColor = "#dc322f"
activeColor = "#b58900"

myLayout numberOfScreens = onWorkspaces screensDev layoutDev $ onWorkspaces screensChat layoutChat $ onWorkspaces screensGames layoutGames $ normal
    where
        screensDev   = withScreens numberOfScreens ["d"]
        screensChat  = withScreens numberOfScreens ["c"]
        screensGames = withScreens numberOfScreens ["g"]

        normal       = spacing space $ tiled ||| Mirror tiled ||| Full
        layoutDev    = spacing space $ Mirror tiledLarge ||| Full
        layoutChat   = spacing space $ withIM (1%7) (Role "buddy_list") Grid ||| Full
        layoutGames  = noBorders Simplest

        tiled        = Tall 1 (3/100) (5/9)
        tiledLarge   = Tall 1 (3/100) (5/6)
        space        = 4

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [
        ((m .|. mod4Mask, k), windows $ onCurrentScreen f i)
            | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

xmobarCommand (S s) = unwords [xmobarBinary, "-f", "\"xft:" ++ xmobarFontFace ++ ":size=" ++ show xmobarFontSize ++ "\"", "-B", "\"#002b36\"", "-F", "\"" ++ normalColor ++ "\"", "-t", "\" %StdinReader% }{ %date% \"", "-x", show s, xmobarrc ++ show s]

pp h screen = marshallPP screen xmobarPP {
                  ppOutput          = hPutStrLn h
                , ppCurrent         = xmobarColor activeColor "" . wrap "[" "]"
                , ppVisible         = xmobarColor activeColor ""
                , ppHidden          = xmobarColor normalColor ""
                , ppHiddenNoWindows = xmobarColor normalColor ""
                , ppTitle           = xmobarColor activeColor ""
                --, ppSort          = eetSortByIndex
                }

main = do
    -- xmproc <- spawnPipe (xmobarBinary ++ xmobarrc)
    numberOfScreens <- countScreens
    hs <- mapM (spawnPipe . xmobarCommand) [0..numberOfScreens-1]

    xmonad $ xfceConfig
        {
              modMask             = mod4Mask
            , handleEventHook     = fullscreenEventHook
            , terminal            = "xfce4-terminal"
            , workspaces          = withScreens numberOfScreens ["w", "d", "c", "m", "v", "g"]
            , borderWidth         = 2
            , normalBorderColor   = normalColor
            , focusedBorderColor  = focusedColor
            , manageHook          = manageDocks <+> manageHook xfceConfig
            , layoutHook          = avoidStruts $ myLayout numberOfScreens
            , keys                = myKeys <+> keys xfceConfig
            , logHook             = mapM_ dynamicLogWithPP $ zipWith pp hs [0..numberOfScreens]
        } `additionalKeys` [
            ((mod4Mask, xK_p),
                spawn "gmrun"),
                -- spawn "dmenu_run -x 0 -y 0 -w 1920 -h 30 -fn 'Source Sans Code-9' -sb '#586e75' -sf '#dc322f' -s 0 -z"),
            ((mod4Mask, xK_l),
                spawn "light-locker-command -l")
        ]

