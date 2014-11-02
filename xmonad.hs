import XMonad
import XMonad.Config.Xfce
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.IndependentScreens
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import Data.Ratio ((%))

-- layout
myLayout = onWorkspaces (withScreens 2 ["chat"]) pidginLayout $ normal
    where
        normal          = spacing space $ tiled ||| Mirror tiled ||| Full
        pidginLayout    = spacing space $ withIM (1%7) (Role "buddy_list") Grid ||| Full

        tiled           = Tall 1 (3/100) (5/9)
        space           = 3

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [
        ((m .|. mod4Mask, k), windows $ onCurrentScreen f i)
            | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

main = xmonad $ xfceConfig
    {
        modMask             = mod4Mask,
        terminal            = "xfce4-terminal",
        workspaces          = withScreens 2 ["web", "dev", "chat", "vm", "games"],
        borderWidth         = 2,
        normalBorderColor   = "#586e75",
        focusedBorderColor  = "#dc322f",
        manageHook          = manageDocks <+> manageHook xfceConfig,
        layoutHook          = avoidStruts $ myLayout,
        keys                = myKeys <+> keys xfceConfig
    } `additionalKeys` [
        ((mod4Mask, xK_p),
            spawn "dmenu_run -x 160 -y 520 -w 1600 -h 30 -o 0.8 -dim 0.2 -fn 'Source Sans Code-11' -p '»' -nb '#2d2d2d' -sb '#d64937' -s 0 -z")
    ]
