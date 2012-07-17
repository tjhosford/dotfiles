require "rubygems"

IRB.conf[:PROMPT_MODE] = :SIMPLE

def require_rb_files_from(dir)
  Dir.glob(File.join(dir, "*.rb")) do |file|
    require file
  end
end

require_rb_files_from(File.join(ENV["HOME"], ".irbrc.d"))

require "awesome_print"

unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end
