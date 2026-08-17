class Tasks < Formula
  desc "Local-first GTD task system for human and AI co-working"
  homepage "https://github.com/marcus/tasks"
  url "https://github.com/marcus/tasks/archive/refs/tags/v1.8.3.tar.gz"
  sha256 "9c11e18a59d7b5b29cd2ec08cf59e805271061e186866fbd36f66f1b0366ab3b"
  license "MIT"
  head "https://github.com/marcus/tasks.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/tasks/internal/buildinfo.Version=v1.8.3",
      "-X github.com/marcus/tasks/internal/buildinfo.Commit=homebrew",
    ].join(" ")
    system "go", "build", *std_go_args(output: bin/"tasks", ldflags:), "./cmd/tasks"
    system "go", "build", *std_go_args(output: bin/"tasks-api", ldflags:), "./cmd/tasks-api"
    system "go", "build", *std_go_args(output: bin/"tasks-tui", ldflags:), "./cmd/tasks-tui"
  end

  test do
    assert_match "tasks v1.8.3 (homebrew)", shell_output("#{bin}/tasks --version")
    assert_match "tasks-api v1.8.3 (homebrew)", shell_output("#{bin}/tasks-api --version")
    assert_match "tasks-tui v1.8.3 (homebrew)", shell_output("#{bin}/tasks-tui --version")
  end
end
