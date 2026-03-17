class Chewy < Formula
  desc "TUI for local AI image generation with Stable Diffusion and FLUX"
  homepage "https://github.com/Holy-Coders/chewy"
  url "https://github.com/Holy-Coders/chewy/archive/refs/tags/v0.2.0.tar.gz"
  version "0.2.0"
  sha256 "f79effc65f7933c1e52039f0e3267aa4f1c8b5e81b5d799f94cd7310c9624276"
  license "MIT"

  depends_on "holy-coders/chewy/sd-cpp"
  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec/"gems"
    ENV["GEM_PATH"] = libexec/"gems"

    system "gem", "install", "bundler", "--no-document", "--install-dir", libexec/"gems"

    bundle = libexec/"gems/bin/bundle"
    system bundle, "config", "set", "--local", "path", libexec/"gems"
    system bundle, "config", "set", "--local", "without", "development:test"
    system bundle, "install"

    libexec.install "chewy.rb"
    libexec.install "Gemfile"
    libexec.install "Gemfile.lock"

    (bin/"chewy").write <<~BASH
      #!/bin/bash
      export GEM_HOME="#{libexec}/gems"
      export GEM_PATH="#{libexec}/gems"
      exec "#{Formula["ruby"].opt_bin}/ruby" "#{libexec}/chewy.rb" "$@"
    BASH
  end

  test do
    assert_predicate bin/"chewy", :executable?
  end
end
