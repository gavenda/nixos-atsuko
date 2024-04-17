{ lib, ... }:

let
  # Turns `"program.desktop" = "mimetype"` into `"mimetype" = "program.desktop"`,
  # making it easier to associate a *.desktop with multiple mimetypes without
  # too much repetition.
  associate = { desktops, mimeTypes }:
    lib.listToAttrs (builtins.map (mime: { name = mime; value = desktops; }) mimeTypes);
in

{
  xdg.mime = {
    enable = true;

    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
    };

    # Handle other audio formats already specified as audio/x-* but
    # not audio/*, or as audio/* but not audio/x-*.
    addedAssociations = associate {
      desktops = "io.bassi.Amberol.desktop";
      mimeTypes = [
        "audio/aac"
        "audio/ac3"
        "audio/flac"
        "audio/m4a"
        "audio/mp1"
        "audio/mp2"
        "audio/mp3"
        "audio/mpegurl"
        "audio/mpg"
        "audio/ogg"
        "audio/opus"
        "audio/x-wav"
      ];
    };
  };
}
