import XMonad
import XMonad.Config.Xfce

import XMonad.Util.EZConfig (removeKeys, additionalKeys)
import XMonad.Util.WorkspaceCompare (getSortByTag)
import XMonad.Util.Scratchpad

import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.EwmhDesktops (fullscreenEventHook)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.Place
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.IndependentScreens
import XMonad.Layout.NoBorders
import XMonad.Layout.Simplest
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenManageHook)

import qualified Data.Map as M
import qualified XMonad.StackSet as W
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

colorBase03 = "#002b36"
colorBase02 = "#073642"
colorBase01 = "#586e75"
colorBase00 = "#657b83"
colorBase0 = "#839496"
colorBase1 = "#93a1a1"
colorBase2 = "#eee8d5"
colorBase3 = "#fdf6e3"
colorYellow = "#b58900"
colorOrange = "#cb4b16"
colorRed = "#dc322f"
colorMagenta = "#d33682"
colorViolet = "#6c71c4"
colorBlue = "#268bd2"
colorCyan = "#2aa198"
colorGreen = "#859900"

myLayout numberOfScreens = onWorkspaces screensGames layoutGames $ fullscreenFull $ normal
    where
        screensGames = withScreens numberOfScreens ["V"]

        normal       = renamed [CutWordsLeft 2] $ spacing 4 $ tiled ||| Mirror tiled ||| Mirror tiledLarge ||| Full
        layoutGames  = noBorders Simplest

        tiled        = Tall 1 (3/100) (2/3)
        tiledLarge   = Tall 1 (3/100) (5/6)

myManageHook = composeAll
    [
          className =? "Xfrun4" --> placeHook (fixed (0.5,0.5)) <+> doFloat
        , fullscreenManageHook
        , scratchpadManageHookDefault
        , insertPosition Below Newer
    ]

myKeys conf@(XConfig {modMask = modm}) = M.fromList $
    [
        ((m .|. mod4Mask, k), windows $ onCurrentScreen f i)
            | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_5]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

main = do
    numberOfScreens <- countScreens
    dbus <- D.connectSession
    getWellKnownName dbus

    xmonad $ withUrgencyHook NoUrgencyHook $ xfceConfig {
            modMask             = mod4Mask
          , terminal            = "xfce4-terminal"
          , workspaces          = withScreens numberOfScreens ["I", "II", "III", "IV", "V"]
          , borderWidth         = 3
          , normalBorderColor   = colorBase0
          , focusedBorderColor  = colorOrange
          , handleEventHook     = fullscreenEventHook
          , manageHook          = manageHook xfceConfig <+> myManageHook
          , layoutHook          = avoidStruts $ myLayout numberOfScreens
          , keys                = myKeys <+> keys xfceConfig
          , logHook             = dynamicLogWithPP (prettyPrinter dbus)
        } `additionalKeys` [
            ((mod4Mask, xK_asciicircum), spawn "xfce4-terminal")
          , ((mod4Mask, xK_s), scratchpadSpawnActionTerminal "xfce4-terminal")
          , ((mod4Mask, xK_p), spawn "xfrun4 --collapsed")
          , ((controlMask .|. mod1Mask, xK_a), spawn "keepass --auto-type")
          -- , ((mod4Mask, xK_l), spawn "light-locker-command -l")
          , ((mod4Mask, xK_a), sendMessage MirrorShrink)
          , ((mod4Mask, xK_z), sendMessage MirrorExpand)
        ] `removeKeys` [
            (mod4Mask .|. shiftMask, xK_Return)
        ]

prettyPrinter :: D.Client -> PP
prettyPrinter dbus = defaultPP
    { ppOutput          = dbusOutput dbus
    , ppTitle           = wrap "<b>" "</b>"
    , ppCurrent         = pangoFgColor colorBase3 . pangoBgColor colorYellow . pangoSanitize . pad
    , ppVisible         = pangoFgColor colorBase3 . pangoBgColor colorBase0 . pangoSanitize . pad
    , ppHidden          = pangoFgColor colorBase3 . pangoBgColor colorBase0 . pangoSanitize . pad
    , ppHiddenNoWindows = const ""
    , ppUrgent          = pangoFgColor colorBase3 . pangoBgColor colorRed
    , ppSep             = "  <b>·</b>  "
    , ppSort            = getSortByTag
    }

getWellKnownName :: D.Client -> IO ()
getWellKnownName dbus = do
    D.requestName dbus (D.busName_ "org.xmonad.Log")
                [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
    return ()

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal (D.objectPath_ "/org/xmonad/Log") (D.interfaceName_ "org.xmonad.Log") (D.memberName_ "Update")) {
                 D.signalBody = [D.toVariant (UTF8.decodeString str)]
        }
    D.emit dbus signal

pangoFgColor :: String -> String -> String
pangoFgColor fg = wrap left right
    where
        left  = "<span foreground=\"" ++ fg ++ "\">"
        right = "</span>"

pangoBgColor :: String -> String -> String
pangoBgColor fg = wrap left right
    where
        left  = "<span background=\"" ++ fg ++ "\">"
        right = "</span>"

pangoSanitize :: String -> String
pangoSanitize = foldr sanitize ""
    where
        sanitize '>'  xs = "&gt;" ++ xs
        sanitize '<'  xs = "&lt;" ++ xs
        sanitize '\"' xs = "&quot;" ++ xs
        sanitize '&'  xs = "&amp;" ++ xs
        sanitize x    xs = x:xs
