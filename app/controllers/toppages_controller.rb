class ToppagesController < ApplicationController
  def index
    @photoposts = Photopost.all.order(id: :desc).first(3)
  end
end
