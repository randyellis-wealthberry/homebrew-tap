class InkwellDaily < Formula
  desc "Morning newspaper about yesterday's agent work and commits"
  homepage "https://github.com/randyellis-wealthberry/inkwell-daily"
  url "https://github.com/randyellis-wealthberry/inkwell-daily/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "12c244feb519978ee89e9d954f1a576ff8461c057d3f82bd3fe0634e039995de"
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
