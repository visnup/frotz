require 'frotz'

class IndexController < ApplicationController
  def index
    session[:save] ||= params[:save] || UUID.random_create
    save = "/tmp/#{session[:save]}.sav"

    Frotz.new do |f|
      f.restore save  if File.exists?(save)

      s = f.type(params[:command] || 'look')
      s.sub! /.*\n\n/, ''
      s.sub! "\n\n>", ''

      f.save save

      render :text => s
    end
  end
end
