class String
  def red
    "\e[38;5;160m#{self}\e[0m"
  end

  def white
    "\e[38;5;231m#{self}\e[0m"
  end

  def blue
    "\e[38;5;45m#{self}\e[0m"
  end

  def green
    "\e[38;5;120m#{self}\e[0m"
  end

  def purple
    "\e[38;5;104m#{self}\e[0m"
  end

  def light_pink
    "\e[38;5;218m#{self}\e[0m"
  end

  def pink
    "\e[38;5;204m#{self}\e[0m"
  end

  def yellow
    "\e[38;5;228m#{self}\e[0m"
  end

  def bold
    "\e[1m#{self}\e[22m"
  end

  def dim
    "\e[2m#{self}\e[22m"
  end


  # Background colors:
  def on_blue
    "\e[48;5;45m#{self}\e[0m"
  end

  def on_green
    "\e[48;5;120m#{self}\e[0m"
  end

  def on_purple
    "\e[48;5;104m#{self}\e[0m"
  end

  def on_light_pink
    "\e[48;5;218m#{self}\e[0m"
  end

  def on_pink
    "\e[48;5;204m#{self}\e[0m"
  end

  def on_yellow
    "\e[48;5;228m#{self}\e[0m"
  end
end