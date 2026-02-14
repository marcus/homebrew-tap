class Td < Formula
  desc "Task management CLI for AI-assisted development"
  homepage "https://github.com/marcus/td"
  url "https://github.com/marcus/td/archive/refs/tags/v0.36.0.tar.gz"
  sha256 "0624736e9f2cdbad3309b01ab1dc3def09dbc276e794cc6e2d417c3839bbd930"
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
