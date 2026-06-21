class Td < Formula
  desc "Task management CLI for AI-assisted development"
  homepage "https://github.com/marcus/td"
  url "https://github.com/marcus/td/archive/refs/tags/v0.51.0.tar.gz"
  sha256 "ef0d7f716bd338536ce41e2eb261bdc65913d5da93d17f58f7dac987c751c488"
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
