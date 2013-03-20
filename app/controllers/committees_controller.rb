class CommitteesController < ApplicationController

  def index
    @committees = Committee.all
  end
end