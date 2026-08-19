class Sidecar < Formula
  desc "A TUI dashboard for AI coding agents"
  homepage "https://github.com/marcus/sidecar"
  url "https://github.com/marcus/sidecar/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "2d7da140a82db2ff4e6447569ac37b4703bcfb0b1c73438a65958928946acc56"
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
