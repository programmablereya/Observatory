class TagsController < ApplicationController
  # Retrieve the category this tag is associated with before
  # doing anything else.
  before_filter :get_category
  def get_category
    @category = Category.find_by_permalink!(params[:category_id])
  end

  # GET /categories/category_id/tags
  # GET /categories/category_id/tags.xml
  def index
    @tags = @category.tags.all

    respond_to do |format|
      format.html { redirect_to @category }
      format.xml  { render :xml => @tags }
    end
  end

  # GET /categories/category_id/tags/id
  # GET /categories/category_id/tags/id.xml
  def show
    @tag = @category.tags.find_by_permalink!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /categories/category_id/tags/new
  # GET /categories/category_id/tags/new.xml
  def new
    @tag = @category.tags.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /categories/category_id/tags/id/edit
  def edit
    @tag = @category.tags.find_by_permalink(params[:id])
  end

  # POST /categories/category_id/tags
  # POST /categories/category_id/tags.xml
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

  # PUT /categories/category_id/tags/id
  # PUT /categories/category_id/tags/id.xml
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

  # DELETE /categories/category_id/tags/id
  # DELETE /categories/category_id/tags/id.xml
  def destroy
    @tag = @category.tags.find_by_permalink!(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(category_tags_url(@category)) }
      format.xml  { head :ok }
    end
  end
end
