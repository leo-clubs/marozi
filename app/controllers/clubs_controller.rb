class ClubsController < ApplicationController

  def index
    #TODO has to go in elastic search
    h = Club.all.inject({}) do |hash, club|
      key = club.district.name
      hash.merge({key => [club]}){|key, oldval, newval| oldval + newval}
    end
    @clubs = Hash[h.sort]
  end
end