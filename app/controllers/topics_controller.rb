class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def destroy
    @topic = Topic.find( params[:id] )
    @topic.destroy

    respond_to do |format|
      # :remote => true
      format.js # destroy.js.erb
      format.html { redirect_to topics_path }
    end
  end

end
