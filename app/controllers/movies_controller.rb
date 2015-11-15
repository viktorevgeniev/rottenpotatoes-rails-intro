class MoviesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort = params[:sort]

    if params[:sort].nil? && params[:ratings].nil? &&
      (!session[:sort].nil? || !session[:ratings].nil?)
      redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings])
    end
    
    @ratings = params[:ratings]
    @all_ratings = Movie.ratings

    @direction = (params[:direction] == "asc") ? "desc" : "asc"

    if @ratings.nil?
      @movies = Movie.all
    else
      @movies = Movie.where(:rating => @ratings.keys).all
    end
   
    if !@sort.nil?
      @movies = Movie.order("#{@sort} #{@direction}")
    end
    session[:ratings]
    session[:sort]
#    if @ratings.nil?
#      @ratings = @all_ratings
#    else
#      @ratings = params[:ratings]
#    end
    
    
  end

  def new
    session.clear
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
