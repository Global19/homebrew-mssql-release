class MssqlToolsAT17011 < Formula
  desc "Sqlcmd and Bcp for Microsoft(R) SQL Server(R)"
  homepage "https://msdn.microsoft.com/en-us/library/ms162773.aspx"
  url "http://download.microsoft.com/download/F/D/1/FD16AA69-F27D-440E-A15A-6C521A1972E6/mssql-tools-17.0.1.1.tar.gz"
  version "17.0.1.1"
  sha256 "61fe8c34e6695b04ac12008c697c888bf9a85dad5490d3cf8b535d358c258a5d"

  depends_on "unixodbc"
  depends_on "openssl"
  depends_on "msodbcsql17"

  def check_eula_acceptance
    if ENV["ACCEPT_EULA"] != "y" and ENV["ACCEPT_EULA"] != "Y" then
      puts "The license terms for this product can be downloaded from"
      puts "http://go.microsoft.com/fwlink/?LinkId=746949 and found in"
      puts "/usr/local/share/doc/mssql-tools/LICENSE.txt . By entering 'YES',"
      puts "you indicate that you accept the license terms."
      puts ""
      while true do
        puts "Do you accept the license terms? (Enter YES or NO)"
        accept_eula = STDIN.gets.chomp
        if accept_eula then
          if accept_eula.upcase == "YES" then
            break
          elsif accept_eula.upcase == "NO" then
            puts "Installation terminated: License terms not accepted."
            return false
          else
            puts "Please enter YES or NO"
          end
        else
          puts "Installation terminated: Could not prompt for license acceptance."
          puts "If you are performing an unattended installation, you may set"
          puts "ACCEPT_EULA to Y to indicate your acceptance of the license terms."
          return false
        end
      end
    end
    return true
  end

  def install
    if !check_eula_acceptance
      return false
    end

    chmod 0444, "bin/sqlcmd"
    chmod 0444, "bin/bcp"
    chmod 0444, "share/resources/en_US/BatchParserGrammar.dfa"
    chmod 0444, "share/resources/en_US/BatchParserGrammar.llr"
    chmod 0444, "share/resources/en_US/bcp.rll"
    chmod 0444, "share/resources/en_US/SQLCMD.rll"
    chmod 0644, "usr/share/doc/mssql-tools/LICENSE.txt"
    chmod 0644, "usr/share/doc/mssql-tools/THIRDPARTYNOTICES.txt"

    cp_r ".", "#{prefix}"
  end
end
