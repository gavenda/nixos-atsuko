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
        { name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "Microphone (noise suppressed)";
            "media.name" = "Microphone (noise suppressed)";
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
  };
}
