class Frost < Formula
  desc "Recommend a model and execution profile for a task written in plain language"
  homepage "https://github.com/marcus/frost"
  url "https://github.com/marcus/frost/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f042f5105ef6233fd6129342e2ec8051314a0e08c79f81f700fe0b9c1f24abcc"
  license "MIT"
  head "https://github.com/marcus/frost.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/frost/pkg/buildinfo.Version=v0.1.0",
      "-X github.com/marcus/frost/pkg/buildinfo.Commit=homebrew",
    ].join(" ")
    system "go", "build", *std_go_args(output: bin/"frost", ldflags:), "./cmd/frost"
    system "go", "build", *std_go_args(output: bin/"catalog-build"), "./tools/catalog-build"
    pkgshare.install "config", "examples"
    (pkgshare/"tools/catalog-build").install "tools/catalog-build/overlay.json",
                                          "tools/catalog-build/METRICS.md",
                                          "tools/catalog-build/NOTICES.md"
    (pkgshare/"tools/catalog-build").install "tools/catalog-build/licenses"
  end

  test do
    assert_match "frost v0.1.0 (homebrew)", shell_output("#{bin}/frost version")
    assert_match "catalog-build", shell_output("#{bin}/catalog-build --help")
    assert_path_exists pkgshare/"config/frost.example.toml"
    assert_path_exists pkgshare/"tools/catalog-build/overlay.json"
  end
end
