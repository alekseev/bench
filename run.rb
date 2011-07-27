dir = Dir.pwd

langs = {
  :ruby => {
    :exec_prefix => '/usr/bin/env ruby',
    :script_ext => '.rb',
    :exec_ext => '.rb',
    :version => {
      :command => 'ruby -v',
      :regexp =>/ruby\s(\d{1})\.(\d{1})\.(\d{1})p(\d+)\s/
    },
    :time => 0
  },
  :php => {
    :exec_prefix => '/usr/bin/env php',
    :script_ext => '.php',
    :exec_ext => '.php',
    :version => {
      :command => 'php -v',
      :regexp =>/PHP\s(\d{1})\.(\d{1})\.(\d{1})/
    },
    :time => 0
  },
  :java => {
    :exec_prefix => '/usr/bin/env java',
    :script_ext => '.class',
    :exec_ext => '',
    :version => {
      :command => '', # 'java -version',
      :regexp => /java\sversion\s\"(\d{1})\.(\d{1})\.(\d{1})_(\d{1,3})\"/
    },
    :time => 0
  },
  :python => {
    :exec_prefix => '/usr/bin/env python',
    :script_ext => '_test.py',
    :exec_ext => '_test.py',
    :version => {
      :command => '', # 'python -V',
      :regexp => /Python\s(\d{1})\.(\d{1})\.(\d{1})/
    },
    :time => 0
  },
  :perl => {
    :exec_prefix => '/usr/bin/env perl',
    :script_ext => '.pl',
    :exec_ext => '.pl',
    :version => {
      :command => 'perl -v',
      :regexp => /v(\d{1})\.(\d{1,2})\.(\d{1})/
    },
    :time => 0
  }
}

tests = {:random => {}, :regexp => {}, :md5 => {}}

class AsciiTable
  attr_accessor :data, :header, :lineup
  
  def build
    
    max_len = {}
    self.data.each do |row|
      j = 0
      row.each do |string|
        if max_len[j].nil? or max_len[j] < string.to_s.length
          max_len[j] = string.to_s.length
          j += 1
        end
      end
    end
    
    puts ' ' + '_' * (max_len.values.inject(0){ |sum, i| sum + i + 2 } + max_len.values.length - 1)
    i = 0
    self.data.each do |row|
      str = '|'
      j = 0
      row.each do |string|
        str << format(string.to_s, max_len[j]) + '|'
        j += 1
      end
      puts str
      i += 1
      if i == 1 and self.header
        str = '|'
        max_len.each{ |_, i| str << '=' * (i + 2) + '|' }
        puts str
      elsif i < data.length and self.lineup
        str = '|'
        max_len.each{ |_, i| str << '-' * (i + 2) + '|' }
        puts str
      end
    end
    str = '|'
    max_len.each{ |_, i| str << '_' * (i + 2) + '|' }
    puts str
  end
  
  def format string, length
    ' ' + string + ' ' * (length - string.length + 1)
  end
end


langs.each do |name, info|
  if `whereis #{name.to_s}`
    if info[:version][:command].length > 0
      v = `#{info[:version][:command]}`.match(info[:version][:regexp])
      langs[name][:version][:number] = v.to_a[1..3].join('.')
    else
      langs[name][:version][:number] = '?'
    end
    tests.each do |test, data|
      path = 'scripts/' + name.to_s + '/'
      file = test.to_s + info[:exec_ext]
      if File.exists? dir + '/' + path + test.to_s + info[:script_ext]
        Dir.chdir(dir + '/' + path)
        time = Time.now
        `#{info[:exec_prefix]} #{file}`
        time = (Time.now - time).to_f
        tests[test][name] = time
        langs[name][:time] += time
      else
        tests[test][name] = '------'
      end
    end
  end
end

data = []
data << [''] + langs.map{ |name, info| name.to_s + ' (' + info[:version][:number] + ')' }
tests.each{ |test, results| data << [test.to_s] + results.map{ |i, v| v.to_s[0..5]}}
data << ['total'] + langs.map{ |name, info| info[:time].to_s[0..5] }

at = AsciiTable.new
at.data = data
at.header = true
at.build