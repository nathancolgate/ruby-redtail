# A sample Guardfile
# More info at https://github.com/guard/guard#readme
notification :ruby_gntp
guard :test do
  watch(%r{^test/.+_test\.rb$})
  # watch('test/test_helper.rb')  { 'test' }

  # Non-rails
  watch(%r{^lib/ruby-redtail/(.+)\.rb$}) { |m| "test/#{m[1]}_test.rb" }

end
