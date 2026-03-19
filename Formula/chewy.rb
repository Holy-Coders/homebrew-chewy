class Chewy < Formula
  desc "TUI for local AI image generation with Stable Diffusion and FLUX"
  homepage "https://github.com/Holy-Coders/chewy"
  url "https://github.com/Holy-Coders/chewy/archive/refs/tags/v0.9.1.tar.gz"
  version "0.9.1"
  sha256 "c1c2c3d5b3988f0ada79ba0e1198b40e77b3d0dac16f8c5596aea45367fd25c2"
  license "MIT"

  depends_on "holy-coders/chewy/sd-cpp"
  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    ENV["GEM_PATH"] = libexec

    system "gem", "install", "bubbletea", "-v", "0.1.3", "--no-document", "--install-dir", libexec
    system "gem", "install", "lipgloss", "-v", "0.2.2", "--no-document", "--install-dir", libexec
    system "gem", "install", "bubbles", "-v", "0.1.1", "--no-document", "--install-dir", libexec
    system "gem", "install", "chunky_png", "-v", "1.4.0", "--no-document", "--install-dir", libexec
    system "gem", "install", "base64", "--no-document", "--install-dir", libexec

    libexec.install "chewy.rb"
    libexec.install "lib"
    libexec.install "Gemfile"
    libexec.install "Gemfile.lock"
    libexec.install "logo.png"
    libexec.install "VERSION"

    (bin/"chewy").write <<~BASH
      #!/bin/bash
      export GEM_HOME="#{libexec}"
      export GEM_PATH="#{libexec}"
      exec "#{Formula["ruby"].opt_bin}/ruby" "#{libexec}/chewy.rb" "$@"
    BASH
  end

  def caveats
    <<~EOS

               ▄▄▄▄████████▄▄▄▄▄
           ▄██▀▀▀▀▀█▄ ▀██▀▄▄██▀███▄
         ▄██▀▀▀▀▀▄  ▀▀ ▀  ▀  ▄▀▀▀▀██▄
        ███▀▀▀                  ▀▀▀███
       ▄██▀▀   ▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄   ▀██▄
      ▄█▀    ▀▀▀█████▀   ▀▀████▀▀▀   ▀█
      ██▄█           ▀▀█▀▀▀          ▄██
      ███▄█  ▄    ▄▄▄▄▄▄▄▄▄▄▄▀▀    ▄▄██▀
       ▄██ ▄█                    ▄ ████
      ▄███▀██▄▄▄             ▄   ███▀ ▀▀
             ▀▀██ ██▄   ▄█▄▄█▀▄▄▀▀▀
                ▀▀▀ ▀▀▀▀███▀

      Run `chewy` to launch the TUI.

      Place models in ~/.config/chewy/models or set CHEWY_MODELS_DIR.
      Press ^d inside chewy to download models from HuggingFace.
    EOS
  end

  test do
    assert_predicate bin/"chewy", :executable?
  end
end
