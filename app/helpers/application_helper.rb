module ApplicationHelper
  # Custom array methods
  Array.class_eval do
    def clean_empty
      self.reject! { |e| e.to_s.empty? }
    end
  end

  def redirect_safe(url)
    if url != :back
      redirect_to url
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def flash_success(message, redirect_url = nil)
    flash[:success] = message
    redirect_safe(redirect_url) if !redirect_url.nil?
  end

  def flash_danger(message, redirect_url = nil)
    flash[:danger] = message
    redirect_safe(redirect_url) if !redirect_url.nil?
  end

  def flash_warning(message, redirect_url = nil)
    flash[:warning] = message
    redirect_safe(redirect_url) if !redirect_url.nil?
  end

  def flash_info(message, redirect_url = nil)
    flash[:info] = message
    redirect_safe(redirect_url) if !redirect_url.nil?
  end

  def elapsed_time(time_input)
    time = Time.now - (time_input || Time.now)
    tokens = {
      31536000 => 'year',
      2592000 => 'month',
      604800 => 'week',
      86400 => 'day',
      3600 => 'hour',
      60 => 'minute',
      1 => 'second'
    }

    tokens.each do |unit, word|
      # Convert units
      num_units = (time / unit).floor

      # check plural
      plural = num_units > 1 ? 's' : nil
      return "#{num_units} #{word}#{plural}" if (unit < time)
    end

    # If time is 0
    return "0 seconds"
  end
end
