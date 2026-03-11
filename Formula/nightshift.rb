class Nightshift < Formula
  desc "AI coding agent runner for overnight maintenance tasks"
  homepage "https://github.com/marcus/nightshift"
  url "https://github.com/marcus/nightshift/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "637d22e9874a98edd90fa4fa0f05157b589f09428cb44d0356f587f4c15509e6"
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
