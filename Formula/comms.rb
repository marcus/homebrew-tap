class Comms < Formula
  desc "Short-lived local messaging for independent agent sessions"
  homepage "https://github.com/marcus/comms"
  url "https://github.com/marcus/comms/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "f8ee118a448df2c96ff3ae32cc39eef4c1a0284e5d6ea1636fd1d3f68bc62490"
  license "Apache-2.0"
  head "https://github.com/marcus/comms.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/comms/pkg/buildinfo.Version=v1.8.0",
      "-X github.com/marcus/comms/pkg/buildinfo.Commit=homebrew",
    ].join(" ")
    system "go", "build", *std_go_args(output: bin/"comms", ldflags:), "./cmd/comms"
  end

  service do
    run [opt_bin/"comms", "serve", "--supervised"]
    run_at_load true
    keep_alive true
    log_path var/"log/comms.log"
    error_log_path var/"log/comms.err.log"
  end

  test do
    assert_match "comms v1.8.0 (homebrew)", shell_output("#{bin}/comms --version")
  end
end
