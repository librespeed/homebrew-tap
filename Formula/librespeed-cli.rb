class LibrespeedCli < Formula
  desc "Command-line client for LibreSpeed"
  homepage "https://github.com/librespeed/speedtest-cli"
  url "https://github.com/librespeed/speedtest-cli/archive/v1.0.1.tar.gz"
  sha256 "32040c0e788aef6078f68e7a987eeca1cf39774eb1a2a6793858a4d81cf37fe5"
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
