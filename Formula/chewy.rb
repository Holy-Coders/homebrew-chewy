class Chewy < Formula
  desc "TUI for local AI image generation with Stable Diffusion and FLUX"
  homepage "https://github.com/Holy-Coders/chewy"
  url "https://github.com/Holy-Coders/chewy/archive/refs/tags/v0.5.2.tar.gz"
  version "0.5.2"
  sha256 "61e42bba36f95fed7df16b87e9235f2bbe72faf27591d74ba16146f5e9d9d38e"
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

      Place models in ~/models or set CHEWY_MODELS_DIR.
      Press ^d inside chewy to download models from HuggingFace.
    EOS
  end

  test do
    assert_predicate bin/"chewy", :executable?
  end
end
