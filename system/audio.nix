# System Audio Configuration

{ pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."60-microphone-rnnoise" = {
      "context.modules" = [
        { 
          name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "Microphone (Noise Suppressed)";
            "media.name" = "Microphone (Noise Suppressed)";
            "filter.graph" = {
              nodes = [
                {
                  type = "ladspa";
                  name = "rnnoise";
                  plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                  label = "noise_suppressor_mono";
                  control = {
                    "VAD Threshold (%)" = 85.0;
                    "VAD Grace Period (ms)" = 500;
                    "Retroactive VAD Grace (ms)" = 0;
                  };
                }
              ];
            };
            "audio.rate" = 48000;
            "audio.position" = [ "FL" ];
            "capture.props" = {
              "node.passive" = true;
              "node.name" = "rnnoise_input";
            };
            "playback.props" = {
              "media.class" = "Audio/Source";
              "node.name" = "rnnoise_output";
            };
          };
        }
      ];
    };

    # Echo cancellation
    extraConfig.pipewire."70-echo-cancel" = {
      "context.modules" = [
        {   
          name = "libpipewire-module-echo-cancel";
          args = {
            # Monitor mode: Instead of creating a virtual sink into which all
            # applications must play, in PipeWire the echo cancellation module can read
            # the audio that should be cancelled directly from the current fallback
            # audio output
            "monitor.mode" = true;
            # The audio source / microphone wherein the echo should be cancelled is not
            # specified explicitly; the module follows the fallback audio source setting
            "source.props" = {
                # Name and description of the virtual source where you get the audio
                # without echoed speaker output
                "node.name" = "source_ec";
                "node.description" = "Echo-Cancelled Source";
            };
            "aec.args" = {
                # Settings for the WebRTC echo cancellation engine
                "webrtc.gain_control" = true;
                "webrtc.extended_filter" = false;
                # Other WebRTC echo cancellation settings which may or may not exist
                # Documentation for the WebRTC echo cancellation library is difficult
                # to find
                #webrtc.analog_gain_control = false
                #webrtc.digital_gain_control = true
                #webrtc.experimental_agc = true
                #webrtc.noise_suppression = true
            };
          };
        }
      ];
    };
  };

}
