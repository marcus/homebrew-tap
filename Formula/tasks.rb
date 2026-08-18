class Tasks < Formula
  desc "Local-first GTD task system for human and AI co-working"
  homepage "https://github.com/marcus/tasks"
  url "https://github.com/marcus/tasks/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "8cccf72dfdfa6d9d4f3f02daa1a3f6700715cc6d7eeb914ade48fc47a2964fa4"
  license "MIT"
  head "https://github.com/marcus/tasks.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/tasks/internal/buildinfo.Version=v1.10.0",
      "-X github.com/marcus/tasks/internal/buildinfo.Commit=homebrew",
    ].join(" ")
    system "go", "build", *std_go_args(output: bin/"tasks", ldflags:), "./cmd/tasks"
    system "go", "build", *std_go_args(output: bin/"tasks-api", ldflags:), "./cmd/tasks-api"
    system "go", "build", *std_go_args(output: bin/"tasks-tui", ldflags:), "./cmd/tasks-tui"
  end

  test do
    assert_match "tasks v1.10.0 (homebrew)", shell_output("#{bin}/tasks --version")
    assert_match "tasks-api v1.10.0 (homebrew)", shell_output("#{bin}/tasks-api --version")
    assert_match "tasks-tui v1.10.0 (homebrew)", shell_output("#{bin}/tasks-tui --version")
  end
end
