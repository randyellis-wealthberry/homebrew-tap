class InkwellDaily < Formula
  desc "Morning newspaper about yesterday's agent work and commits"
  homepage "https://github.com/randyellis-wealthberry/inkwell-daily"
  url "https://github.com/randyellis-wealthberry/inkwell-daily/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "e713287455f02b69ecd86a667a2e43bcfb617cd5924e81e8644b18bb7db708a6"
  license "MIT"

  depends_on "node"

  def install
    # The CLI finds Model.js and lib/ beside bin/, so keep the package shape.
    libexec.install "bin", "lib", "Model.js", "package.json", "README.md", "LICENSE"
    bin.install_symlink libexec/"bin/inkwell-daily.js" => "inkwell-daily"
  end

  def caveats
    <<~EOS
      Set the paper each morning at 5, and set yesterday's edition now:

        inkwell-daily install
        inkwell-daily build
        inkwell-daily open

      Pick another hour with: inkwell-daily install --hour 7
      Stop the schedule with:  inkwell-daily uninstall
    EOS
  end

  test do
    assert_match "Inkwell Daily", shell_output("#{bin}/inkwell-daily help")
    assert_match "editions", shell_output("#{bin}/inkwell-daily status")
  end
end
