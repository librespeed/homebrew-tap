class LibrespeedCli < Formula
  desc "Command-line client for LibreSpeed"
  homepage "https://github.com/librespeed/speedtest-cli"
  url "https://github.com/librespeed/speedtest-cli/archive/v1.0.5.tar.gz"
  sha256 "af2b6b108a83db9bd3ce3459b315aee4fddca171fdee4e5507311e3a5864caf7"
  head "https://github.com/librespeed/speedtest-cli.git"

  bottle :unneeded

  depends_on "go" => :build

  def install
    build_time = Utils.popen_read("date -u '+%Y-%m-%d %H:%M:%S %Z' 2> /dev/null").chomp
    ldflags = ["-w -s",
               "-X \"librespeed-cli/defs.ProgName=librespeed-cli\"",
               "-X \"librespeed-cli/defs.ProgVersion=v#{version}\"",
               "-X \"librespeed-cli/defs.BuildDate=#{build_time}\""]
    system "go", "build", "-o", bin/"librespeed-cli", "-ldflags", ldflags.join(" "), "-trimpath", "main.go"
  end

  test do
    system bin/"librespeed-cli"
  end
end
