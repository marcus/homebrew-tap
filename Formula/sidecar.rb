class Sidecar < Formula
  desc "A TUI dashboard for AI coding agents"
  homepage "https://github.com/marcus/sidecar"
  url "https://github.com/marcus/sidecar/archive/refs/tags/v1.16.0.tar.gz"
  sha256 "ab6b418c5d3e114b014bac8c3172b60f7186e334ee41a3c4c63829cbad7c2381"
  license "MIT"
  head "https://github.com/marcus/sidecar.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/sidecar"
  end

  service do
    name macos: "com.haplab.sidecar.api", linux: "sidecar-api"
    # Follow the same stable link that managed local/worktree installs activate.
    run [HOMEBREW_PREFIX/"bin/sidecar", "api", "serve"]
    sockets browser: "tcp://127.0.0.1:7861"
    keep_alive true
    environment_variables PATH: std_service_path_env, SIDECAR_API_SOCKET_ACTIVATION: "1"
    log_path var/"log/sidecar-api.log"
    error_log_path var/"log/sidecar-api.log"
  end

  def caveats
    if OS.linux?
      "Use `sidecar api service install` on Linux: Homebrew services cannot generate the systemd socket unit that keeps the browser origin reserved during upgrades."
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sidecar --version")
  end
end
