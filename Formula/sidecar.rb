class Sidecar < Formula
  desc "A TUI dashboard for AI coding agents"
  homepage "https://github.com/marcus/sidecar"
  url "https://github.com/marcus/sidecar/archive/refs/tags/v0.99.1.tar.gz"
  sha256 "f947e5a652ad4b2bb42283f79d4f0e59afeed7e6eeac37d329dc6d221e869d94"
  license "MIT"
  head "https://github.com/marcus/sidecar.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/sidecar"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sidecar --version")
  end
end
