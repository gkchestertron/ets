class StaticController < ApplicationController
  def home
  end

  def bot
      puts "It's a bot!"
      puts request.fullpath #use this to find in the static version of the site
  end
end
