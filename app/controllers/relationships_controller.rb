class RelationshipsController < ApplicationController
  # Retrieve the character from whom the relationship points first,
  # and store it for later use in the actions.
  before_filter :get_character
  def get_character
    @character = Character.find_by_permalink!(params[:character_id])
  end

  # GET /relationships
  # GET /relationships.xml
  def index
    @relationships = @character.relationships.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relationships }
    end
  end

  # GET /relationships/1
  # GET /relationships/1.xml
  def show
    @relationship = @character.relationships.find_by_permalink!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @relationship }
    end
  end

  # GET /relationships/new
  # GET /relationships/new.xml
  def new
    @relationship = @character.relationships.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @relationship }
    end
  end

  # GET /relationships/1/edit
  def edit
    @relationship = @character.relationships.find_by_permalink!(params[:id])
  end

  # POST /relationships
  # POST /relationships.xml
  def create
    @relationship = @character.relationships.new(params[:relationship])
    
    respond_to do |format|
      if @relationship.save
        format.html { redirect_to([@character,@relationship], :notice => 'Relationship was successfully created.') }
        format.xml  { render :xml => @relationship, :status => :created, :location => @relationship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @relationship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /relationships/1
  # PUT /relationships/1.xml
  def update
    @relationship = @character.relationships.find_by_permalink!(params[:id])

    respond_to do |format|
      if @relationship.update_attributes(params[:relationship])
        format.html { redirect_to([@character,@relationship], :notice => 'Relationship was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @relationship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.xml
  def destroy
    @relationship = @character.relationships.find_by_permalink!(params[:id])
    @relationship.destroy

    respond_to do |format|
      format.html { redirect_to(relationships_url(@character)) }
      format.xml  { head :ok }
    end
  end
end
