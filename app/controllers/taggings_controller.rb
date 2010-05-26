class TaggingsController < ApplicationController
  # Retrieve the 
  before_filter :get_object
  def get_object
    if params[:tag_id]
      @parent = Category.find_by_permalink!(params[:category_id])
      @object = @parent.tags.find_by_permalink!(params[:tag_id])
      @path = category_tags_url(@parent, @object)
    elsif params[:character_id]
      @object = Character.find_by_permalink!(params[:character_id])
      @path = character_url(@object)
    end
  end

  # PUT /object_path/tags/id
  # PUT /object_path/tags/id.xml
  def update
    @tag = Tag.find_by_permalink!(params[:id])
    @object.tags << @tag unless @object.tags.include?(@tag)

    respond_to do |format|
      if @object.save
        format.html { redirect_to(@path, :notice => 'Tagging was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /object_path/tags/id
  # DELETE /object_path/tags/id.xml
  def destroy
    @tag = Tag.find_by_permalink!(params[:id])
    @object.tags.delete(@tag) if @object.tags.include?(@tag)

    respond_to do |format|
      format.html { redirect_to(@path) }
      format.xml  { head :ok }
    end
  end
end
