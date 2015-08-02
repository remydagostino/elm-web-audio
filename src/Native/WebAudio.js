Elm.Native.WebAudio = {};

Elm.Native.WebAudio.make = function(localRuntime) {
  localRuntime.Native = localRuntime.Native || {};
  localRuntime.Native.WebAudio = localRuntime.Native.WebAudio || {};

  if (localRuntime.Native.WebAudio.values){
    return localRuntime.Native.WebAudio.values;
  }

  var Task = Elm.Native.Task.make(localRuntime);

  function hi(a) {
    return function(b) {
      return a + b;
    };
  }

  var audioContext = Task.asyncFunction(function(callback) {
    var context;

    try {
      context = new AudioContext();
    } catch (err) {
      callback(Task.fail('???'));
    }

    if (context) {
      callback(Task.succeed(context));
    }
  });

  var oscillator = function(context) {
    return function(wave) {
      return function(audioParam) {
        return Task.asyncFunction(function(callback) {
          var osc;

          try {
            osc = context.createOscillator();
            osc.type = ({
              Sine: 'sine',
              Triangle: 'triangle',
              Sawtooth: 'sawtooth',
              Square: 'square'
            })[wave.ctor];

            if (audioParam.ctor === 'ParamValue') {
              osc.frequency.value = audioParam._0;
            }
          } catch (err) {
            callback(Task.fail('???'));
          }

          if (context) {
            callback(Task.succeed(osc));
          }
        });
      };
    };
  };

  var outputTo = function(context) {
    return function(osc) {
      return Task.asyncFunction(function(callback) {
        try {
          osc.connect(context.destination);
        } catch (err) {
          callback(Task.fail('???'));
        }

        if (context) {
          callback(Task.succeed(osc));
        }
      });
    };
  };

  var play = function(context) {
    return function(osc) {
      return function(startAfter) {
        return function(stopAfter) {
          return Task.asyncFunction(function(callback) {
            try {
              osc.start(context.currentTime + startAfter);
              osc.stop(context.currentTime + startAfter + stopAfter);
            } catch (err) {
              callback(Task.fail('???'));
            }

            if (context) {
              callback(Task.succeed());
            }
          });
        };
      };
    };
  };

  return {
    audioContext: audioContext,
    oscillator: oscillator,
    outputTo: outputTo,
    play: play,
    hi: hi
  };
};
