class InkwellDaily < Formula
  desc "Morning newspaper about yesterday's agent work and commits"
  homepage "https://github.com/randyellis-wealthberry/inkwell-daily"
  url "https://github.com/randyellis-wealthberry/inkwell-daily/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "ce44ee9ecbbe1fa3aecc650fe7f1d315e98b5133f7e3cb2a32b89946e4ec1214"
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
