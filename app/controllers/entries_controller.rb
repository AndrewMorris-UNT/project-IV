class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html

  def index
    @entries = Entry.all
    respond_with(@entries)
  end

  def show
    respond_with(@entry)
  end

  def new
    @entry = current_user.entries.build
    respond_with(@entry)
  end

  def edit
  end

  def create
    @entry = current_user.entries.build(params[:entry])
    @entry.save
    respond_with(@entry)
  end

  def update
    @entry.update(params[:entry])
    respond_with(@entry)
  end

  def destroy
    @entry.destroy
    respond_with(@entry)
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to entries_path, notice: "Not authorized to edit this entry" if @entry.nil?
    end

    def entry_params
      params.require(:entry).permit(:description, :image)
    end
end
