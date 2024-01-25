{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.autoPatchelfHook
    pkgs.python3
    pkgs.cairo
    pkgs.pkg-config
  ];

  packages = [
    (pkgs.python3.withPackages (ps: [
      ps.lark
      ps.numpy
      ps.pip
      ps.setuptools
      ps.z3
      ps.python-lsp-server
    ]))

    pkgs.curl
    pkgs.jq
  ];
  
  #nativeBuildInputs = [ pkgs.libsForQt5.qt5.wrapQtAppsHook ];
  # dontWrapQtApps = true;
  
  # LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.glib}/lib";


  
  # shellHook = ''
  #   export PYTHONPATH=$PYTHONPATH:${pkgs.python3.sitePackages}
     
  #   export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
  #     #pkgs.ffmpeg
  #   ]}

  #   source ./env/bin/activate

  # '';
}

