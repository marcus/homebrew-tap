class Td < Formula
  desc "Task management CLI for AI-assisted development"
  homepage "https://github.com/marcus/td"
  url "https://github.com/marcus/td/archive/refs/tags/v0.68.0.tar.gz"
  sha256 "94a76777f7f3bbc2371ee57a8a4c0db2a1fabb2348926224d658ee2e15a4c367"
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
