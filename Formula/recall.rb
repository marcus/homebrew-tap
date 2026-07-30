class Recall < Formula
  desc "Federated, evidence-first retrieval for personal AI agents"
  homepage "https://github.com/marcus/recall"
  url "https://github.com/marcus/recall/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "6cb2579db83ba82e1fe9bcddea1ff7ee21ab11655ec0bd298cf27a74e074a9d1"
  license "Apache-2.0"
  head "https://github.com/marcus/recall.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/recall/pkg/buildinfo.Version=v0.3.0",
      "-X github.com/marcus/recall/pkg/buildinfo.Commit=homebrew",
    ].join(" ")
    system "go", "build", *std_go_args(output: bin/"recall", ldflags:), "./cmd/recall"
    system "go", "build", *std_go_args(output: bin/"recall-gmail", ldflags:), "./cmd/recall-gmail"
    system "go", "build", *std_go_args(output: bin/"recall-qmd", ldflags:), "./cmd/recall-qmd"
    system "go", "build", *std_go_args(output: bin/"recall-stream", ldflags:), "./cmd/recall-stream"
    pkgshare.install "cmd/recall-gmail/conformance" => "gmail-conformance"
    pkgshare.install "cmd/recall-qmd/conformance" => "qmd-conformance"
  end

  test do
    assert_match "recall v0.3.0 (homebrew)", shell_output("#{bin}/recall version")
    assert_match "recall-gmail/1 v0.3.0", shell_output("#{bin}/recall-gmail -version")
    assert_match "recall-qmd/1 v0.3.0", shell_output("#{bin}/recall-qmd -version")
    assert_match "recall-stream/1 v0.3.0", shell_output("#{bin}/recall-stream -version")
    assert_path_exists pkgshare/"gmail-conformance/handshake/manifest.json"
    assert_path_exists pkgshare/"qmd-conformance/handshake/manifest.json"
  end
end
