class TaggingsController < ApplicationController
  # Retrieve the 
  before_filter :get_object
  def get_object
    if params[:tag_id]
      @parent = Category.find_by_permalink!(:category_id)
      @object = @parent.tags.find_by_permalink!(:tag_id)
      @path = category_tags_url(@parent, @object)
    elsif params[:character_id]
      @object = Character.find_by_permalink!(:character_id)
      @path = character_url(@object)
    end
  end
  # GET /object_path/tags
  # GET /object_path/tags.xml
  def index
    @tags = @object.tags.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # GET /object_path/tags/id
  # GET /object_path/tags/id.xml
  def show
    @tag = @object.tags.find_by_permalink!(params[:id])

    respond_to do |format|
      format.html { redirect_to category_tags_url(@tag.category, @tag) } # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /object_path/tags/new
  # GET /object_path/tags/new.xml
  def new
    @tags = Tag.all -

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tagging }
    end
  end

  # GET /object_path/tags/id/edit
  def edit
    @tagging = Tagging.find(params[:id])
  end

  # POST /object_path/tags
  # POST /object_path/tags
  def create
    @tagging = Tagging.new(params[:tagging])

    respond_to do |format|
      if @tagging.save
        format.html { redirect_to(@path, :notice => 'Tagging was successfully created.') }
        format.xml  { render :xml => @tagging, :status => :created, :location => @tagging }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /object_path/tags/id
  # PUT /object_path/tags/id.xml
  def update
    @tagging = Tagging.find(params[:id])

    respond_to do |format|
      if @tagging.update_attributes(params[:tagging])
        format.html { redirect_to(@path, :notice => 'Tagging was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /object_path/tags/id
  # DELETE /object_path/tags/id.xml
  def destroy
    @tagging = Tagging.find(params[:id])
    @tagging.destroy

    respond_to do |format|
      format.html { redirect_to(@path) }
      format.xml  { head :ok }
    end
  end
end
