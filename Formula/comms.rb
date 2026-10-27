class Comms < Formula
  desc "Short-lived local messaging for independent agent sessions"
  homepage "https://github.com/marcus/comms"
  url "https://github.com/marcus/comms/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "d4691173c0293e1badcbdd37056a6f486670ced94415a9886d12a6b2d84da839"
  license "Apache-2.0"
  head "https://github.com/marcus/comms.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/comms/pkg/buildinfo.Version=v1.7.0",
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
    assert_match "comms v1.7.0 (homebrew)", shell_output("#{bin}/comms --version")
  end
end
