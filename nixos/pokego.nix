{
  lib,
    buildGoModule,
    fetchFromGitHub,
}:

buildGoModule rec {
  pname = "pokego";
  version = "0.5.2";

  src = fetchFromGitHub {
    owner = "rubiin";
    repo = "pokego";
    rev = "v${version}";
    hash = "sha256-cFpEi8wBdCzAl9dputoCwy8LeGyK3UF2vyylft7/1wY=";
  };

  vendorHash = "sha256-7SoKHH+tDJKhUQDoVwAzVZXoPuKNJEHDEyQ77BPEDQ0=";

# Install shell completions
  postInstall = ''
    install -Dm644 completions/pokego.bash "$out/share/bash-completion/completions/pokego"
    install -Dm644 completions/pokego.fish "$out/share/fish/vendor_completions.d/pokego.fish"
    install -Dm644 completions/pokego.zsh "$out/share/zsh/site-functions/_pokego"
    '';

  meta = {
    description = "Command-line tool that lets you display Pokémon sprites in color directly in your terminal";
    homepage = "https://github.com/rubiin/pokego";
    license = lib.licenses.gpl3Only;
    mainProgram = "pokego";
    platforms = lib.platforms.all;
  };
}
