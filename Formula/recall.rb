class Recall < Formula
  desc "Federated, evidence-first retrieval for personal AI agents"
  homepage "https://github.com/marcus/recall"
  url "https://github.com/marcus/recall/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b7bdadc8d42b369cdae6d3df8c10281fbcf948ecc4b58bf16296a061e6ad7f35"
  license "Apache-2.0"
  head "https://github.com/marcus/recall.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/recall/pkg/buildinfo.Version=v0.1.0",
      "-X github.com/marcus/recall/pkg/buildinfo.Commit=homebrew",
    ].join(" ")
    system "go", "build", *std_go_args(output: bin/"recall", ldflags:), "./cmd/recall"
    system "go", "build", *std_go_args(output: bin/"recall-stream", ldflags:), "./cmd/recall-stream"
  end

  test do
    assert_match "recall v0.1.0 (homebrew)", shell_output("#{bin}/recall version")
    assert_match "recall-stream/1 v0.1.0", shell_output("#{bin}/recall-stream -version")
  end
end
