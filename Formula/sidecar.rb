class Sidecar < Formula
  desc "A TUI dashboard for AI coding agents"
  homepage "https://github.com/marcus/sidecar"
  url "https://github.com/marcus/sidecar/archive/refs/tags/v1.14.0.tar.gz"
  sha256 "061b202236ce3710c4218bb55bfb077b5301397f3330bdf0fdc0e55905471406"
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
