class Td < Formula
  desc "Task management CLI for AI-assisted development"
  homepage "https://github.com/marcus/td"
  url "https://github.com/marcus/td/archive/refs/tags/v0.51.2.tar.gz"
  sha256 "4be0090dd3bc6af07ebf2e2b4c5f8fd863ad8abb25ca15328eb4a2f24a5034c9"
  license "MIT"
  head "https://github.com/marcus/td.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/td --version")
  end
end
