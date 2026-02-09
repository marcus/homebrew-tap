class Nightshift < Formula
  desc "AI coding agent runner for overnight maintenance tasks"
  homepage "https://github.com/marcus/nightshift"
  url "https://github.com/marcus/nightshift/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "87a380940d61802e6f397a917c84dce93e704f8eb5c89e15d6924177726e17b4"
  license "MIT"
  head "https://github.com/marcus/nightshift.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/marcus/nightshift/cmd/nightshift/commands.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/nightshift"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nightshift --version")
  end
end
