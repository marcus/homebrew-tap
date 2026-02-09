class Nightshift < Formula
  desc "AI coding agent runner for overnight maintenance tasks"
  homepage "https://github.com/marcus/nightshift"
  url "https://github.com/marcus/nightshift/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "6e184904979f30d6adfbd736227c0378c649ea438bf0d4cc4a38ca60d831b103"
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
