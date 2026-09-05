class Comms < Formula
  desc "Short-lived local messaging for independent agent sessions"
  homepage "https://github.com/marcus/comms"
  url "https://github.com/marcus/comms/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "3b1879dbb4401f3562773dc00ecac0c5d2d023310fe6a2cd2b3923563f7bf022"
  license "Apache-2.0"
  head "https://github.com/marcus/comms.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/comms/pkg/buildinfo.Version=v1.3.0",
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
    assert_match "comms v1.3.0 (homebrew)", shell_output("#{bin}/comms version")
  end
end
