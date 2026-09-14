class Avatars < Formula
  desc "Deterministic pen-and-ink avatar and profile icon generator"
  homepage "https://github.com/marcus/avatars"
  url "https://github.com/marcus/avatars/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "360b18ac0d06923189b6c22b23182bf74c1ae834ca5d7d1d9f4bf761797c05c2"
  license "MIT"
  head "https://github.com/marcus/avatars.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/avatars/internal/buildinfo.Version=v0.1.0",
      "-X github.com/marcus/avatars/internal/buildinfo.Commit=homebrew",
    ].join(" ")
    system "go", "build", *std_go_args(output: bin/"avatars", ldflags:), "./cmd/avatars"
  end

  test do
    assert_match "avatars v0.1.0 (homebrew)", shell_output("#{bin}/avatars --version")
  end
end
