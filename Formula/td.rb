class Td < Formula
  desc "Task management CLI for AI-assisted development"
  homepage "https://github.com/marcus/td"
  url "https://github.com/marcus/td/archive/refs/tags/v0.69.0.tar.gz"
  sha256 "fc33c534963f9de9c2730cb4731ac638f444e7a7875c120475545c5922becbb3"
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
