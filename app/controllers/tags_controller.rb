class TagsController < ApplicationController
  before_filter :get_category
  def get_category
    @category = Category.find_by_permalink!(params[:category_id])
  end

  # GET /tags
  # GET /tags.xml
  def index
    @tags = @category.tags.all

    respond_to do |format|
      format.html { redirect_to @category }
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = @category.tags.find_by_permalink!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tag = @category.tags.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = @category.tags.find_by_permalink(params[:id])
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = @category.tags.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to([@category,@tag], :notice => 'Tag was successfully created.') }
        format.xml  { render :xml => @tag, :status => :created, :location => [@category,@tag] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = @category.tags.find_by_permalink!(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to([@category,@tag], :notice => 'Tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = @category.tags.find_by_permalink!(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(category_tags_url(@category)) }
      format.xml  { head :ok }
    end
  end
end
