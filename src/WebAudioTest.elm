import WebAudio exposing (oscillator, outputTo, play, Param(..))
import Graphics.Element as El
import Graphics.Collage as Collage
import Graphics.Input as Input
import Color
import Signal
import Task exposing (Task, andThen)
import Text


type Sound = Silent | Low | Medium | High

soundMailbox : Signal.Mailbox Sound
soundMailbox = Signal.mailbox Silent

port audio : Signal (Task () ())
port audio =
  Signal.map playSound soundMailbox.signal

playSound : Sound -> Task () ()
playSound sound =
  WebAudio.audioContext
    `andThen` \ctx -> oscillator ctx WebAudio.Sine (ParamValue <| soundFreq sound)
    `andThen` \osc -> outputTo ctx osc
    `andThen` \con -> play ctx con 0 1


soundFreq : Sound -> Float
soundFreq sound =
  case sound of
    Silent -> 0.0
    Low    -> 221.0
    Medium -> 440.0
    High   -> 660.0


main =
  El.above
    welcomeMessage
    boxes

welcomeMessage =
  El.leftAligned <| Text.fromString "Web audio + Elm"

boxes =
  El.flow El.right
    [ keyBox Color.red Low
    , keyBox Color.green Medium
    , keyBox Color.blue High ]

keyBox color sound =
  El.color color (El.size 80 80 El.empty)
  |> Input.clickable (Signal.message soundMailbox.address sound)
