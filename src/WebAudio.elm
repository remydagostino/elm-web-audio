module WebAudio
  ( AudioContext(..)
  , Param(..)
  , Wave(..)
  , audioContext
  , oscillator
  , outputTo
  , play
  ) where

{-| A library for producing audio with the web audio api

# Testing
@docs AudioContext
@docs Param
@docs Wave
@docs audioContext
@docs oscillator
@docs outputTo
@docs play
-}

import Task exposing (Task)
import Native.WebAudio

{-| TODO
-}
type Param = ParamValue Float

{-| TODO
-}
type Wave = Sine
          | Triangle
          | Sawtooth
          | Square

{-| TODO
-}
type AudioContext = AudioContext
type Oscillator = Oscillator
type ConnectedOscillator = ConnectedOscillator

{-| TODO
-}
audioContext : Task () AudioContext
audioContext = Native.WebAudio.audioContext

{-| TODO
-}
oscillator : AudioContext -> Wave -> Param -> Task () Oscillator
oscillator = Native.WebAudio.oscillator

{-| TODO
-}
outputTo : AudioContext -> Oscillator -> Task () ConnectedOscillator
outputTo = Native.WebAudio.outputTo

{-| TODO
-}
play : AudioContext -> ConnectedOscillator -> Float -> Float -> Task () ()
play = Native.WebAudio.play
