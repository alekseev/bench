require 'rubygems'
require 'terminal-table/import'

dir = Dir.pwd

langs = {
  :ruby => {
    :exec_command => 'ruby %s.rb',
    :script_ext => '.rb',
    :exec_ext => '.rb',
    :version => {
      :command => 'ruby -v',
      :regexp =>/ruby\s(\d{1})\.(\d{1})\.(\d{1})p(\d+)\s/
    },
    :time => 0
  },
  :php => {
    :exec_command => 'php %s.php',
    :script_ext => '.php',
    :exec_ext => '.php',
    :version => {
      :command => 'php -v',
      :regexp =>/PHP\s(\d{1})\.(\d{1})\.(\d{1})/
    },
    :time => 0
  },
  :java => {
    :exec_command => 'java %s',
    :compile_command => 'javac %s.java',
    :script_ext => '.java',
    :exec_ext => '.class',
    :version => {
      :command => '', # 'java -version',
      :regexp => /java\sversion\s\"(\d{1})\.(\d{1})\.(\d{1})_(\d{1,3})\"/
    },
    :time => 0
  },
  :python => {
    :exec_command => 'python %s_test.py',
    :script_ext => '_test.py',
    :exec_ext => '_test.py',
    :version => {
      :command => '', # 'python -V',
      :regexp => /Python\s(\d{1})\.(\d{1})\.(\d{1})/
    },
    :time => 0
  },
  :perl => {
    :exec_command => 'perl %s.pl',
    :script_ext => '.pl',
    :exec_ext => '.pl',
    :version => {
      :command => 'perl -v',
      :regexp => /v(\d{1})\.(\d{1,2})\.(\d{1})/
    },
    :time => 0
  },
  :cpp => {
    :exec_command => './%s.o',
    :compile_command => 'g++ -o %s_test.o %s_test.cpp',
    :script_ext => '_test.cpp',
    :exec_ext => '_test.o',
    :version => {
      :command => '',
      :regexp => nil
    },
    :time => 0
  }
}

tests = {:random => {}, :regexp => {}, :md5 => {}}

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
        unless File.exists? dir + '/' + path + test.to_s + info[:exec_ext]
          puts "Compiling test \"#{test.to_s}\" for #{name.to_s}"
          system(info[:compile_command].gsub(/%s/, test.to_s))
        end
        puts "Running test \"#{test.to_s}\" with #{name.to_s}"
        time = Time.now
        system(info[:exec_command].gsub(/%s/, test.to_s))
        time = (Time.now - time).to_f
        tests[test][name] = time
        langs[name][:time] += time
        unless info[:compile_command].nil?
          puts "Removing compiled test \"#{test.to_s}\" for #{name.to_s}"
          path = dir + '/' + path + test.to_s + info[:exec_ext]
          system(`rm #{path}`)
        end
      else
        tests[test][name] = '------'
      end
    end
  end
end

puts

stat_table = table do |t|
  t.headings = [''] + langs.map{ |name, info| name.to_s + ' (' + info[:version][:number] + ')' }
  tests.each{ |test, results| t << [test.to_s] + results.map{ |i, v| v.to_s[0..6] } }
  t << ['total'] + langs.map{ |name, info| info[:time].to_s[0..6] }
end

puts stat_table
