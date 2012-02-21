guard "rspec", :version => 2 do

  watch %r{^spec/spec_helper\.rb$} do
    "spec/"
  end

  watch %r{^lib/(.+)\.rb$} do |m|
    "spec/#{m[1]}_spec.rb"
  end

  watch %r{^spec/.+_spec\.rb$}

end
