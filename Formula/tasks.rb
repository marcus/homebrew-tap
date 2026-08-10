class Tasks < Formula
  desc "Local-first GTD task system for human and AI co-working"
  homepage "https://github.com/marcus/tasks"
  url "https://github.com/marcus/tasks/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "2f8f41d9f594668b012c0530d4957896c2477f6ee90705d64f2146d45ea73acc"
  license "MIT"
  head "https://github.com/marcus/tasks.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = [
      "-s",
      "-w",
      "-X github.com/marcus/tasks/internal/buildinfo.Version=v1.4.0",
      "-X github.com/marcus/tasks/internal/buildinfo.Commit=homebrew",
    ].join(" ")
    system "go", "build", *std_go_args(output: bin/"tasks", ldflags:), "./cmd/tasks"
    system "go", "build", *std_go_args(output: bin/"tasks-api", ldflags:), "./cmd/tasks-api"
    system "go", "build", *std_go_args(output: bin/"tasks-tui", ldflags:), "./cmd/tasks-tui"
  end

  test do
    assert_match "tasks v1.4.0 (homebrew)", shell_output("#{bin}/tasks --version")
    assert_match "tasks-api v1.4.0 (homebrew)", shell_output("#{bin}/tasks-api --version")
    assert_match "tasks-tui v1.4.0 (homebrew)", shell_output("#{bin}/tasks-tui --version")
  end
end
