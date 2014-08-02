class Exception
  def details
    "#{self.class} (#{message})"
  end

  def inspect_backtrace(backtrace_cleaner = Rails::backtrace_cleaner)
    str = "#{details}:\n    "
    if backtrace_cleaner
      str << "#{backtrace_cleaner.clean(backtrace).join("\n    ")}\n" if backtrace
    else
      str << "#{backtrace.join("\n    ")}\n"
    end
    str
  end
end
